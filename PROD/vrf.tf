resource "aci_vrf" "terraform_vrf" {
  tenant_dn   = aci_tenant.terraform_tenant.id
  name        = var.vrf_name
  description = "Created with Terraform"
}

resource "aci_any" "example_vzany" {
  vrf_dn       = aci_vrf.terraform_vrf.id
  pref_gr_memb = "enabled"
}