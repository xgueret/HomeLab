locals {
  worker_names = formatlist("k8s-%s", range(0, var.proxmox_nodes))
  worker_id = formatlist("901%s", range(0, var.proxmox_nodes))
  worker_ips_vmbr0 = formatlist("192.168.1.1%s", range(0, var.proxmox_nodes))
  worker_gateway_vmbr0 = "192.168.1.254"
  #worker_ips_vmbr1 = formatlist("10.0.1.1%s", range(0, var.proxmox_nodes))
}

resource "proxmox_vm_qemu" "proxmox_resource" {
  count = var.proxmox_nodes
  name = "${local.worker_names[count.index]}"
  target_node = "pve"
  desc = "HomeLab Kubernetes node"
  vmid = "${local.worker_id[count.index]}"
  clone = "ubuntu-2204-cloudinit-template"

  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  //scsi0
  disk {
    slot = 0
    size = var.proxmox_vm_disk0_size
    type = "scsi"
    storage = var.proxmox_vm_disk0_storage
  }
  
  network {
    model   = "virtio"
    bridge  = "vmbr0"
  }

  #network {
  #  model   = "virtio"
  #  bridge  = "vmbr1"
  #}

  lifecycle {
    ignore_changes = [
      network,  
    ]  
  }
  
  timeouts {
    create = "10m"
    update = "5m"
    delete = "5m"
  }


  ipconfig0 = "ip=${local.worker_ips_vmbr0[count.index]}/24,gw=${local.worker_gateway_vmbr0}"
  #ipconfig1 = "ip=${local.worker_ips_vmbr1[count.index]}/24"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
   
}