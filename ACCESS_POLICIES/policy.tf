resource "aci_fabric_if_pol" "cl_10G_link_policy" {
  name        = var.link_speed_policy_name
  #name        = "cl_10G_ON"
  description = "Created by Terraform"
  auto_neg    = "on"
  fec_mode    = "inherit"
  link_debounce  = "100"
  speed       = var.link_speed_10G
  #speed       = "10G"
}

resource "aci_lldp_interface_policy" "cl_lldp_policy" {
  description = "Created by Terraform"
  name        = var.lldp_policy_name
  # name        = "cl_lldp_on"
  admin_rx_st = "enabled"
  admin_tx_st = "enabled"
}

resource "aci_cdp_interface_policy" "cl_cdp_policy" {
  description = "Created by Terraform"
  name        = var.cdp_policy_name
  # name        = "cl_cdp_enable"
  admin_st    = "enabled"
}

# Tie in policies for EPG static path binding configuration
resource "aci_leaf_access_port_policy_group" "cl_access_port_policy_group" {
  description = "Created by Terraform"
  name        = "cl_10G_access"
  relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.cl_lldp_policy.id
  relation_infra_rs_cdp_if_pol = aci_cdp_interface_policy.cl_cdp_policy.id
  relation_infra_rs_att_ent_p = aci_attachable_access_entity_profile.cl_aaep.id
  relation_infra_rs_h_if_pol = aci_fabric_if_pol.cl_10G_link_policy.id
}

# Tie in policies for L3Out configuration
resource "aci_leaf_access_port_policy_group" "cl_l3out_access_port_policy_group" {
  description = "Created by Terraform"
  name        = "cl_l3out_10G_access"
  relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.cl_lldp_policy.id
  relation_infra_rs_cdp_if_pol = aci_cdp_interface_policy.cl_cdp_policy.id
  relation_infra_rs_att_ent_p = aci_attachable_access_entity_profile.cl_l3_aaep.id
  relation_infra_rs_h_if_pol = aci_fabric_if_pol.cl_10G_link_policy.id
}
