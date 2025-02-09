terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
    }
  }
}

/*
 Use variable substitution for APIC Username/Password and APIC IP.
*/

provider "aci" {
  # ACI Username
  username = var.apic_username
  # ACI Password
  password = var.apic_password
  # cisco-aci url
  url      = var.apic_url
  insecure = true
}