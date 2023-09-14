variable "pm_host" {
    description = "host ip / url for proxmox"
    type = string
    default = "root@pam"
}

variable "pm_token_id" {
    description = "api token id for proxmox"
    type = string
}

variable "pm_node" {
    description = "name of the proxmox node to deploy vms on"
    type = string
    default = "CHANGE_ME"
}

variable "template_name" {
    default = "ubuntu-2004-cloudinit-template"
}

variable "num_k3s_master" {
    description = "number of master nodes to startup"
    default = 1
}

variable "num_k3s_worker" {
    description = "number of worker nodes to startup"
    default = 2
}

variable "k3s_master_mem" {
    description = "amount of memory provided to master nodes"
    default = "4096"
}

variable "k3s_worker_mem" {
    description = "amount of memory provided to worker nodes"
    default = "4096"
}

variable "k3s_master_storage" {
    description = "amount of storage provided to master nodes"
    default = "10G"
}

variable "k3s_worker_storage" {
    description = "amount of storage provided to worker nodes"
    default = "10G"
}

variable "master_ips" {
    description = "List of ip addresses for master nodes"
}

variable "worker_ips" {
    description = "List of ip addresses for worker nodes"
}

variable "networkrange" {
    default = 24
}

variable "gateway" {
    default = "192.168.3.1"
}

variable "ssh_key" {
    description = "SSH key added to VMs"
}