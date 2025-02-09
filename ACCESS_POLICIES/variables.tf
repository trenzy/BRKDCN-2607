/* 
To set apic_username and apic_password, make sure to set environment variables:

export TF_VAR_apic_username=<username>
export TF_VAR_apic_password=<password>
export TF_VAR_apic_url=<password>

*/

variable "apic_username" {
  default = "admin"
}

variable "apic_password" {
}

variable "apic_url" {
  default = "https://172.31.2.31"
}

/* Variable definition for VLANs and pools */

variable "l3out_vlan_pool_name" {
  type = string
}

variable "l3out_vlan_pool_range_start" {
  type = string
}

variable "l3out_vlan_pool_range_end" {
  type = string
}

variable "phys_vlan_pool_name" {
  type = string
}

variable "phys_vlan_pool_range_start" {
  type = string
}

variable "phys_vlan_pool_range_end" {
  type = string
}

/* Variable definition for Domains (Physical and L3Out) */

variable "phys_domain_name" {
  type = string
  description = "Define Physical Domain Name"
}

variable "l3out_domain_name" {
  type = string
  description = "L3Out Domain Name"
}

/* Variable definition for AAEP */

variable "phys_aaep_name" {
  type = string
  description = "AAEP for Phys Domain"
}

variable "l3out_aaep_name" {
  type = string
  description = "AAEP for Phys Domain"
}

/* Variable definition for Access Port Block names */

variable "access_port_block_101_name" {
  type = string
}

variable "access_port_block_102_name" {
  type = string
}

/* CDP and LLDP Policy variables */

variable "cdp_policy_name" {
  type = string
}

variable "lldp_policy_name" {
  type = string
}

variable "link_speed_policy_name" {
  type = string
}

variable "link_speed_10G" {
  type = string
}