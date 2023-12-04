// Proxmox variables

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
    default = "192.168.0.1"
}

variable "ssh_key" {
    description = "SSH key added to VMs"
}

// Nginx variables

variable "create_nginx" {
    default     = false
    type        = bool
    description = "Decides whether we want to create nginx resources using terraform or not"
}

variable "nginx_release_name" {
    default     = "nginx-ingress"
    type        = string
    description = "Name of the nginx release name"
}

variable "nginx_namespace" {
    default     = "nginx"
    type        = string
    description = "Name of the nginx namespace"
}

variable "nginx_chart_version" {
    type        = string
    description = "nginx chart version"
}

variable "create_nginx_namespace" {
    default     = true
    type        = bool
    description = "Boolean to control nginx namespace creation"
}

variable "nginx_values_file" {
    default     = "nginx_values.yaml"
    type        = string
    description = "Name of the values file which holds the helm chart values"
}