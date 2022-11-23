resource "digitalocean_droplet" "v2ray-server" {
  image  = "ubuntu-20-04-x64"
  name   = var.server_name
  region = "fra1"
  size   = "s-1vcpu-512mb-10gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  user_data = file("../v2ray_installer.sh")
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
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
    "x-ui Username"     = "admin"
    "x-ui Password"     = "admin"
  }
}
