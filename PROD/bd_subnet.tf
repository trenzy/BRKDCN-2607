resource "aci_subnet" "bridge_domain_subnet" {
  for_each  = { for bd in var.bridge_domains : bd.name => bd }
  parent_dn = aci_bridge_domain.bridge_domain[each.value.name].id
  ip        = each.value.subnet
  scope     = ["public"]
}