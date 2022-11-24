# V2ray installation <!-- omit in toc -->

- [Simple setup (Without Domain)](#simple-setup-without-domain)
- [Digital Ocean instance + CloudFlare DNS (With domain)](#digital-ocean-instance--cloudflare-dns-with-domain)
  - [Deploy Digital Ocean instance](#deploy-digital-ocean-instance)
  - [Register a domain](#register-a-domain)
  - [Deploy Cloudflare DNS](#deploy-cloudflare-dns)
  - [Create a SSL certificate](#create-a-ssl-certificate)

## Simple setup (Without Domain)

```bash

# Install v2ray core
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
# Install the latest release of geoip.dat and geosite.dat
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)
# Install x-ui
# Source: https://github.com/hossinasaadi/x-ui
yes no | bash <(curl -Ls https://raw.githubusercontent.com/hossinasaadi/x-ui/master/install.sh)

```

## Digital Ocean instance + CloudFlare DNS (With domain)

### Deploy Digital Ocean instance

```bash

cd instance-digitalocean
cat <<EOF >> terraform.tfvars
private_key   = "<PATH TO YOUR PUBLIC KEY>"
public_key   = "<PATH TO YOUR PRIVATE KEY>"
api_token = "<DIGITAL OCEAN API TOKEN>" # Create one via https://cloud.digitalocean.com/account/api/tokens
EOF

terraform init
terraform apply --auto-approve

# To destroy use below command:
# terraform destroy --auto-approve
```

### Register a domain

Register a domain name.
Free domain can be register in [https://freenom.com/](https://freenom.com/)

### Deploy Cloudflare DNS

```bash
cd dns-cloudflare

cat <<EOF >> terraform.tfvars
domain_name   = "<YOUR REGISTERED DOMAIN NAME>"
server_ipv4_address   = "<Server IP address OUTPUT FROM instance-digitalocean >"
api_token = "<CLOUDFLARE AIP KEY>" # Create on from https://dash.cloudflare.com/profile/api-tokens
EOF

terraform init
terraform apply --auto-approve

# To destroy use below command:
# terraform destroy --auto-approve
```

### Create a SSL certificate

TBD
