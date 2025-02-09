data "aci_l3_domain_profile" "cl_l3out_phys_domain" {
  name  = "cl_l3out_phys_domain"
}

resource "aci_l3_outside" "cl_l3_outside" {
  tenant_dn      = aci_tenant.terraform_tenant.id
  relation_l3ext_rs_ectx = aci_vrf.terraform_vrf.id
  relation_l3ext_rs_l3_dom_att = data.aci_l3_domain_profile.cl_l3out_phys_domain.id
  description    = "L3Out created by Terraform"
  name           = "cl_l3out"
  enforce_rtctrl = ["export"]
}

resource "aci_logical_node_profile" "cl_logical_node_102_profile" {
  l3_outside_dn = aci_l3_outside.cl_l3_outside.id
  description   = "Configured by Terraform"
  name          = "cl_102_node_prod"
}

resource "aci_logical_node_to_fabric_node" "node_102" {
  logical_node_profile_dn = aci_logical_node_profile.cl_logical_node_102_profile.id
  tdn                     = "topology/pod-1/node-102"
  rtr_id                  = "10.1.1.240"
  rtr_id_loop_back        = "yes"
}

resource "aci_logical_interface_profile" "cl_logical_interface_profile" {
  logical_node_profile_dn = aci_logical_node_profile.cl_logical_node_102_profile.id
  description             = "CL logical interface profile"
  name                    = "cl_prod_l3out_int_prof"
}

resource "aci_external_network_instance_profile" "cl_ext_net_inst_profile" {
  l3_outside_dn = aci_l3_outside.cl_l3_outside.id
  description   = "Created by terraform"
  name          = "ext_inst_prof"
  relation_fv_rs_prov = [aci_contract.l3_out_contract.id]
}

resource "aci_l3out_path_attachment" "cl_node_102_to_l3out" {
  logical_interface_profile_dn = aci_logical_interface_profile.cl_logical_interface_profile.id
  target_dn                    = "topology/pod-1/paths-102/pathep-[eth1/39]"
  if_inst_t                    = "l3-port"
  addr                         = "10.255.255.1/30"
  #encap                        = "vlan-1261"
  mode                         = "regular"
  mtu                          = "9000"
}

resource "aci_l3_ext_subnet" "cl_l3out_ext_subnet" {
  external_network_instance_profile_dn = aci_external_network_instance_profile.cl_ext_net_inst_profile.id
  description                          = "Created with Terraform"
  ip                                   = "0.0.0.0/0"
  # aggregate                            = "shared-rtctrl"
  name_alias                           = "alias_ext_subnet"
  scope                                = ["import-security"]
  #scope                                = ["import-rtctrl", "export-rtctrl", "import-security"]
}

/* Create a static route for the L3Out */
resource "aci_l3out_static_route" "cl_l3out_static_route" {
  fabric_node_dn = aci_logical_node_to_fabric_node.node_102.id
  ip             = "0.0.0.0/0"
  aggregate      = "no"
  pref           = "1"
  description    = "Created by Terraform"
}

/* 
   Create the static route next hop. Relies on the resource
   above for the actual static route
*/
resource "aci_l3out_static_route_next_hop" "example" {
  static_route_dn      = aci_l3out_static_route.cl_l3out_static_route.id
  nh_addr              = "10.255.255.2"
  pref                 = "1"
  nexthop_profile_type = "prefix"
  description          = "Created by Terraform"
}

resource "aci_route_control_profile" "cl_l3out_route_profile" {
  parent_dn                  = aci_tenant.terraform_tenant.id
  name                       = "cl_l3out_route_prof"
  description                = "Created by Terraform"
  route_control_profile_type = "global"
}