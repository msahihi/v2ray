variable "api_token"{
  type = string
  description = <<EOT
  CloudFlare Api Token created at https://dash.cloudflare.com/profile/api-tokens
  Required permission: 
   - Zone: Zone / Edit
   - Zone: Zone Setting / Edit
   - Zone: DNS / Edit
  EOT
}

variable "domain_name"{
  type = string
  description = "Your registered domain example.com"
}

variable "server_ipv4_address"{
  type = string
  description = "#Your ec2/droplet instance IPv4 Address"
}
