output "proxmox_ip_address_default" {
  description = "Current IP Default"
  value = proxmox_vm_qemu.proxmox_resource.*.default_ipv4_address
}