/*
Using preferred groups for communication, but need a contract for L3Out. This
is provisioned here
*/
resource "aci_contract" "l3_out_contract" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "l3out_contract"
  scope     = "tenant"
}

resource "aci_contract_subject" "l3_out_sub" {
  contract_dn                  = aci_contract.l3_out_contract.id
  name                         = "l3out_subject"
  relation_vz_rs_subj_filt_att = [aci_filter.allow_any_filter.id]
}

resource "aci_filter" "allow_any_filter" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "allow_any"
}

resource "aci_filter_entry" "allow_any_filter_entry" {
  name        = "any"
  filter_dn   = aci_filter.allow_any_filter.id
  ether_t     = "ip"
  prot        = "unspecified"
  d_from_port = "unspecified"
  d_to_port   = "unspecified"
  stateful    = "yes"
}