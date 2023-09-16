resource "proxmox_vm_qemu" "proxmox_vm_master" {
    count = var.num_k3s_master
    name = "k3s-master-${count.index}"
    target_node = var.pm_node
    clone = var.template_name
    os_type = "cloud-init"
    agent = 1
    memory = var.k3s_master_mem
    cores = 4
    scsihw = "virtio-scsi-pci"
    bootdisk = "scsi0"
    
    ipconfig0 = "ip=${var.master_ips[count.index]}/${var.networkrange},gw=${var.gateway}"
    nameserver = "1.1.1.1"
    
    lifecycle {
        ignore_changes = [
            ciuser,
            sshkeys,
            disk,
            network
        ]
    }
    
    disk {
        slot = 0
        size = var.k3s_master_storage
        type = "scsi"
        storage = "local-lvm"
        iothread = 0
    }
    
    sshkeys = <<EOF
    ${var.ssh_key}
    EOF
}

resource "proxmox_vm_qemu" "proxmox_vm_worker" {
    count = var.num_k3s_worker
    name = "k3s-worker-${count.index}"
    target_node = var.pm_node
    clone = var.template_name
    os_type = "cloud-init"
    agent = 1
    memory = var.k3s_worker_mem
    sockets = 1
    cores = 4
    cpu = "host"
    scsihw = "virtio-scsi-pci"
    bootdisk = "scsi0"

    ipconfig0 = "ip=${var.worker_ips[count.index]}/${var.networkrange},gw=${var.gateway}"
    nameserver = "1.1.1.1"

    lifecycle {
        ignore_changes = [
            ciuser,
            sshkeys,
            disk,
            network
        ]
    }
    
    disk {
        slot = 0
        size = var.k3s_worker_storage
        type = "scsi"
        storage = "local-lvm"
        iothread = 0
    }
    
    sshkeys = <<EOF
    ${var.ssh_key}
    EOF
}