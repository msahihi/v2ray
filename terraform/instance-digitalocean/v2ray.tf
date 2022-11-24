resource "digitalocean_ssh_key" "v2ray_terraform" {
  name       = "v2ray_terraform"
  public_key = file(var.public_key)
}

resource "digitalocean_droplet" "v2ray-server" {
  image  = var.droplet_image
  name   = var.server_name
  region = var.region
  size   = var.droplet_size
  ssh_keys = [
      digitalocean_ssh_key.v2ray_terraform.fingerprint
  ]
  user_data = file("../../v2ray_installer.sh")
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.private_key)
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "/bin/bash -c \"timeout 300 sed '/finished at/q' <(tail -f /var/log/cloud-init-output.log)\""
    ]
  }
}

output "droplet_information" {
  value = {
    "Server IP address" = digitalocean_droplet.v2ray-server.ipv4_address
    "x-ui Console"      = "http://${digitalocean_droplet.v2ray-server.ipv4_address}:54321"
    "x-ui Username"     = "admin" # default x-ui username
    "x-ui Password"     = "admin" # default x-ui password
  }
}
