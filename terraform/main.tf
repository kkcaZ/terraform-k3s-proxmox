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

module "k3s" {
    depends_on_ = module.proxmox

    source  = "xunleii/k3s/module"
    k3s_version = "v1.27.5+k3s1"
    k3s_install_env_vars = {
        "K3S_KUBECONFIG_MODE"="644"
    }
    drain_timeout = "60s"
    managed_fields = ["label", "taint"]
    cidr = {
        pods     = "10.42.0.0/16"
        services = "10.43.0.0/16"
    }

    servers = {
        for index, ip in module.proxmox.master_ips :
        "master-${index}" => {
            ip = ip
            connection = {
                user = "ubuntu"
                host = ip
            }
            labels = {"node.kubernetes.io/type" = "master"}
            taints = {"node.k3s.io/type" = "server:NoSchedule"}
        }
    }
    agents = {
        for index, ip in module.proxmox.worker_ips :
        "agent-${index}" => {
            ip = ip
            connection = {
                user = "ubuntu"
                host = ip
            }
            labels = {"node.kubernetes.io/pool" = "service-pool"}
        }
    }
}

resource "local_file" "kube_config" {
    depends_on = [ module.proxmox, module.k3s ]
    content = module.k3s.kube_config
    filename = var.helm_config_path
}

module "mongodb" {
    source = "./mongodb"
    depends_on = [ module.proxmox, module.k3s, local_file.kube_config ]
}

module "jx-vault" {
    depends_on = [ module.proxmox, module.k3s, local_file.kube_config ]
    source = "./jx-vault"
}

output "kube_config" {
    value = module.k3s.kube_config
    sensitive = true
}