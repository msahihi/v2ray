variable "region" {
  type        = string
  default     = "fra1"
  description = "Check availale slugs at https://slugs.do-api.dev/"
}

variable "droplet_size" {
  type    = string
  default = "s-1vcpu-512mb-10gb"
}

variable "droplet_image" {
  type    = string
  default = "ubuntu-20-04-x64"
}

variable "server_name" {
  type    = string
  default = "v2ray"
}

variable "api_token" {
  type        = string
  description = "API token from "
}

variable "private_key" {
  type        = string
  description = "Path to ssh private key"
}

variable "public_key" {
  type        = string
  description = "Path to ssh public key"
}
