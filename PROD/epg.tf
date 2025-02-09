resource "aci_application_epg" "epg" {
  for_each               = { for epg in var.epgs : epg.name => epg }
  application_profile_dn = aci_application_profile.terraform_ap.id
  name                   = each.value.name
  relation_fv_rs_bd      = aci_bridge_domain.bridge_domain["${each.value.name}-bd"].id
  pref_gr_memb           = each.value.pref_group
  relation_fv_rs_cons    = [aci_contract.l3_out_contract.id]
}

data "aci_physical_domain" "read_in_domain" {
  name  = "cl_phys_domain"
}

resource "aci_epg_to_domain" "epg_to_domain" {
  application_epg_dn = aci_application_epg.epg["prod"].id
  tdn                = data.aci_physical_domain.read_in_domain.id
}

resource "aci_epg_to_static_path" "prod_epg_static_path" {
  application_epg_dn = aci_application_epg.epg["prod"].id
  encap              = "vlan-1251"
  mode               = "untagged"
  tdn                = "topology/pod-1/paths-101/pathep-[eth1/33]"
}