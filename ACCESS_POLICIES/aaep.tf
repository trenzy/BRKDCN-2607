/* 
AAEP for Phys Domain
*/

resource "aci_attachable_access_entity_profile" "cl_aaep" {
  name        = var.phys_aaep_name
  #name        = "cl_phys_aaep"
  description = "Created by Terraform"
  relation_infra_rs_dom_p = [aci_physical_domain.cl_phys_domain.id]
}

/*
AAEP for L3Out
*/

resource "aci_attachable_access_entity_profile" "cl_l3_aaep" {
  name        = var.l3out_aaep_name
  #name        = "cl_l3out_aaep"
  description = "Created by Terraform"
  relation_infra_rs_dom_p = [aci_l3_domain_profile.cl_l3_phys_domain.id]
}