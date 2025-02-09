resource "aci_tenant" "terraform_tenant" {
  name        = var.tenant_name
  description = "Created with Terraform"
}