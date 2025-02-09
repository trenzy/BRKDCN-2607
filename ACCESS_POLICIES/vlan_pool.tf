/* 
This is to configure VLAN pool and range for the Endpoint
*/

resource "aci_vlan_pool" "cl_vlan_pool" {
  name       = var.phys_vlan_pool_name
  #name       = "cl_vlan_pool"
  alloc_mode = "static"
  description = "Created with Terraform"
}

resource "aci_ranges" "cl_pool_range" {
  vlan_pool_dn = aci_vlan_pool.cl_vlan_pool.id
  from         = var.phys_vlan_pool_range_start
  #from         = "vlan-1250"
  to           = var.phys_vlan_pool_range_end
  # to           = "vlan-1259"
  alloc_mode   = "static"
  role         = "external"
}

/* This is to configure the VLAN pool for the L3Out */

resource "aci_vlan_pool" "cl_l3_vlan_pool" {
  name       = var.l3out_vlan_pool_name
  #name       = "cl_l3out_vlan_pool"
  alloc_mode = "static"
  description = "Created with Terraform"
}

resource "aci_ranges" "cl_l3_pool_range" {
  vlan_pool_dn = aci_vlan_pool.cl_l3_vlan_pool.id
  from         = var.l3out_vlan_pool_range_start
  #from         = "vlan-1260"
  to           = var.l3out_vlan_pool_range_end
  #to           = "vlan-1269"
  alloc_mode   = "static"
  role         = "external"
}