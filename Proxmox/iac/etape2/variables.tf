variable "proxmox_api_url" {
    type = string
    description = <<-EOT
    Proxmox API URL
    i.e https://192.168.1.1:8006/api2/json
    EOT
}

variable "proxmox_vm_memory" {
  type = number
  description = "CPU memory for VM"
  default = 4098
}

variable "proxmox_vm_disk0_storage" {
  type = string
  description = "Disk 0 storage name i.e local-lvm"
  default = "local-lvm"
}

variable "proxmox_vm_disk0_size" {
  type =  string
  description = "Disk 0 storage size i.e 40G"
  default = "40G"
}

variable "proxmox_nodes" {
  type = number
  description = "Number of kubernetes node"
  default = 3
}

variable "ssh_key" {
  type = string
  sensitive = true
  description = "SSH key pub that add to VM"
}

