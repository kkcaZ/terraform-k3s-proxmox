terraform {
    required_providers {
        proxmox = {
            source  = "telmate/proxmox"
            version = "2.9.14"
        }
    }
}

provider "proxmox" {
    pm_api_url = "https://${var.pm_host}:8006/api2/json"
    pm_api_token_id = var.pm_token_id
    pm_tls_insecure = true
}
