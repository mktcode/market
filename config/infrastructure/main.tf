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

resource "hcloud_firewall" "market-app" {
  name = "market-app"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [hcloud_load_balancer.market-app.ipv4]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [hcloud_load_balancer.market-app.ipv4]
  }
}

resource "hcloud_firewall" "market-db" {
  name = "market-db"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "3306"
    source_ips = [
      hcloud_server.market-app-1.ipv4_address,
      hcloud_server.market-app-2.ipv4_address
    ]
  }
}

resource "hcloud_firewall" "monitor" {
  name = "monitor"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_server" "market-app-1" {
  name = "market-app-1"
  image = "ubuntu-24.04"
  server_type = "cx22"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  location = "fsn1"
  ssh_keys = [
    data.hcloud_ssh_key.default.id
  ]
  user_data = file("${path.module}/market-app.cloud-init.yml")
  firewall_ids = [ hcloud_firewall.market-app.id ]
}

resource "hcloud_server" "market-app-2" {
  name = "market-app-2"
  image = "ubuntu-24.04"
  server_type = "cx22"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  location = "nbg1"
  ssh_keys = [
    data.hcloud_ssh_key.default.id
  ]
  user_data = file("${path.module}/market-app.cloud-init.yml")
  firewall_ids = [ hcloud_firewall.market-app.id ]
}

resource "hcloud_server" "market-db" {
  name = "market-db"
  image = "ubuntu-24.04"
  server_type = "cx22"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  location = "nbg1"
  ssh_keys = [
    data.hcloud_ssh_key.default.id
  ]
  user_data = file("${path.module}/market-db.cloud-init.yml")
  firewall_ids = [ hcloud_firewall.market-db.id ]
}

resource "hcloud_server" "monitor" {
  name = "monitor"
  image = "prometheus-grafana"
  server_type = "cax11"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  location = "hel1"
  ssh_keys = [
    data.hcloud_ssh_key.default.id
  ]
  firewall_ids = [ hcloud_firewall.monitor.id ]
}

output "market-app-1_ip" {
  value = hcloud_server.market-app-1.ipv4_address
}

output "market-app-2_ip" {
  value = hcloud_server.market-app-2.ipv4_address
}

output "market-db_ip" {
  value = hcloud_server.market-db.ipv4_address
}

resource "hcloud_load_balancer" "market-app" {
  name               = "market-app"
  load_balancer_type = "lb11"
  location           = "nbg1"
}

resource "hcloud_load_balancer_target" "market-app-1" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.market-app.id
  server_id        = hcloud_server.market-app-1.id
}

resource "hcloud_load_balancer_target" "market-app-2" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.market-app.id
  server_id        = hcloud_server.market-app-2.id
}

resource "hcloud_managed_certificate" "market-app" {
  name = "market-app"
  domain_names = ["emmaherbst.de"]
}

resource "hcloud_load_balancer_service" "market-app-health" {
  load_balancer_id = hcloud_load_balancer.market-app.id
  protocol         = "https"

  http {
    redirect_http = true
    certificates = [hcloud_managed_certificate.market-app.id]
  }

  health_check {
    protocol = "http"
    port     = 80
    interval = 30
    timeout  = 5

    http {
      path         = "/up"
      tls          = false
      status_codes = ["200"]
    }
  }
}