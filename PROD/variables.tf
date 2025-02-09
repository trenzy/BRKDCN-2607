/* 
To set apic_username and apic_password, make sure to set environment variables:

export TF_VAR_apic_username=<username>
export TF_VAR_apic_password=<password>
export TF_VAR_apic_url=<password>

*/

variable "apic_username" {
  default = "admin"
}

variable "apic_password" {
}

variable "apic_url" {
  default = "https://172.31.2.31"
}

variable "tenant_name" {
  type = string
}

variable "vrf_name" {
  type = string
}

variable "ap_name" {
  type = string
}

// Create separate BDs with for_each
variable "bridge_domains" {
    default = [ 
    {
      name   = "prod-bd"
      subnet = "10.1.1.1/24"
    },
    {
      name   = "dev-bd"
      subnet = "10.1.2.1/24"
    },
    {
      name   = "test-bd"
      subnet = "10.1.3.1/24"
    }
    ]
}

// Create separate BDs with for_each
variable "epgs" {
    default = [ 
    {
      name   = "prod"
      pref_group = "include"
    },
    {
      name   = "dev"
      pref_group = "include"
    },
    {
      name   = "test"
      pref_group = "include"
    }
    ]
}