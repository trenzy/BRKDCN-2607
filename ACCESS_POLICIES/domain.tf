/*
Domain configuration for End Point Group
*/

resource "aci_physical_domain" "cl_phys_domain" {
  depends_on                = [aci_vlan_pool.cl_vlan_pool]
  name                      = var.phys_domain_name
  #name                      = "cl_phys_domain"
  relation_infra_rs_vlan_ns = aci_vlan_pool.cl_vlan_pool.id
}

resource "aci_aaep_to_domain" "cl_aaep_to_domain" {
  attachable_access_entity_profile_dn = aci_attachable_access_entity_profile.cl_aaep.id
  domain_dn                           = aci_physical_domain.cl_phys_domain.id
}

/*
Domain configuration for L3Out
*/

resource "aci_l3_domain_profile" "cl_l3_phys_domain" {
  name                      = var.l3out_domain_name
  #name                      = "cl_l3out_phys_domain"
  relation_infra_rs_vlan_ns = aci_vlan_pool.cl_l3_vlan_pool.id
}

resource "aci_aaep_to_domain" "cl_l3_aaep_to_domain" {
  attachable_access_entity_profile_dn = aci_attachable_access_entity_profile.cl_l3_aaep.id
  domain_dn                           = aci_l3_domain_profile.cl_l3_phys_domain.id
}