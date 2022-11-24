resource "cloudflare_zone" "domain" {
  zone = var.domain_name
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.domain.id
  name    = "www"
  value   = var.server_ipv4_address
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "domain" {
  zone_id = cloudflare_zone.domain.id
  name    = var.domain_name
  value   = var.server_ipv4_address
  type    = "A"
  proxied = false # in case of changing it to ture one should consider https://developers.cloudflare.com/fundamentals/get-started/setup/allow-cloudflare-ip-addresses/#allowlist-cloudflare-ip-addresses
}

resource "cloudflare_zone_settings_override" "domain-settings" {
  zone_id = cloudflare_zone.domain.id

  settings {
    tls_1_3                  = "on"
    automatic_https_rewrites = "on"
    ssl                      = "strict"
  }
}

output "domain_name" {
  value = var.domain_name
}

output "zone_id" {
  value = cloudflare_zone.domain.id
}

output "name_servers" {
  value = cloudflare_zone.domain.name_servers
}
