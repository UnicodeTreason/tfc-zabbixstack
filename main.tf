terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.9.1"
    }
  }
}

provider "vultr" {
  # In your .bashrc you need to set
  # export VULTR_API_KEY="Your Vultr API Key"
}

# Configure VM
resource "vultr_instance" "srv02" {
  region    = var.region_sydney
  os_id     = var.os_centos_9
  plan      = var.plan_one_cpu_two_gb_ram
  hostname  = "srv02"
  label     = "Zabbix Host"
  tag       = "terraform"
}

# Configure DNS
resource "vultr_dns_record" "srv02unicodetreasoncom" {
    domain = "unicodetreason.com"
    name = "srv02"
    data = vultr_instance.srv02.main_ip
    type = "A"
}