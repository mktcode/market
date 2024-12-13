terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

variable "hcloud_token" {
  sensitive = true
}

data "hcloud_ssh_key" "default" {
  name = "kontakt@markus-kottlaender.de"
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_server" "market-app-1" {
  name = "market-app-1"
  image = "ubuntu-24.04"
  server_type = "cax11"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  location = "fsn1"
  ssh_keys = [
    data.hcloud_ssh_key.default.id
  ]
  user_data = file("${path.module}/market-app.cloud-init.yml")
}

resource "hcloud_rdns" "market-app-1" {
  server_id = hcloud_server.market-app-1.id
  ip_address = hcloud_server.market-app-1.ipv4_address
  dns_ptr = "market.markus-kottlaender.de"
}

output "market-app-1_ip" {
  value = hcloud_server.market-app-1.ipv4_address
}
