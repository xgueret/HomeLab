terraform {
    required_providers {
      proxmox = {
        source = "telmate/proxmox"
        version="2.9.14"
      }
    }
}

provider "proxmox" {
    pm_api_url = var.proxmox_api_url
}