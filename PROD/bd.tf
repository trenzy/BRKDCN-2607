resource "aci_bridge_domain" "bridge_domain" {
  for_each           = { for bd in var.bridge_domains : bd.name => bd }
  tenant_dn          = aci_tenant.terraform_tenant.id
  relation_fv_rs_ctx = aci_vrf.terraform_vrf.id
  name               = each.value.name
  relation_fv_rs_bd_to_out = [aci_l3_outside.cl_l3_outside.id]
}