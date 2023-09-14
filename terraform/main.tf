module "proxmox" {
    source = "./proxmox"
    pm_host = var.pm_host
    pm_token_id = var.pm_token_id
    pm_node = var.pm_node
    template_name = var.template_name
    num_k3s_master = var.num_k3s_master
    num_k3s_worker = var.num_k3s_worker
    k3s_master_mem = var.k3s_master_mem
    k3s_worker_mem = var.k3s_worker_mem
    k3s_master_storage = var.k3s_master_storage
    k3s_worker_storage = var.k3s_worker_storage
    master_ips = var.master_ips
    worker_ips = var.worker_ips
    networkrange = var.networkrange
    gateway = var.gateway
    ssh_key = var.ssh_key
}