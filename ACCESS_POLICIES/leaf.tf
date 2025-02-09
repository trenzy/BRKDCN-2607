/*
Leaf Profiles were create previously (NOT through Terraform sadly!)
so we use data sources to read in that information to configure our access
port selectors and blocks.
*/

data "aci_leaf_profile" "cl_Leaf101_Prof" {
  name  = "Leaf101_Prof"
}

data "aci_leaf_profile" "cl_Leaf_102_Prof" {
  name  = "Leaf102_Prof"
}

/*
You can uncomment this section out if you need to create a new Leaf
switch profile. This was created previously, so we use data sources to
read in this info. 
*/
  
/* # Created Leaf Switch Profile
resource "aci_leaf_profile" "cl_lsp_101" {
    name = "cl_leaf_101"
    leaf_selector {
        name = "leaf_101"
        switch_association_type = "range"
        node_block {
            name  = "101"
            from_ = "101"
            to_   = "101"
        }
    }
    relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.cl_lip_101.id]
}

resource "aci_leaf_profile" "cl_lsp_102" {
     name = "cl_leaf_102"
     leaf_selector {
         name = "leaf_102"
         switch_association_type = "range"
         node_block {
             name  = "102"
             from_ = "102"
             to_   = "102"
         }
     }
    relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.cl_lip_102.id]
}
*/

/* 
Read in Leaf Interface Profile information from the APIC
*/

data "aci_leaf_interface_profile" "cl_Leaf101_IntProf" {
  name  = "Leaf101_IntProf"
}

data "aci_leaf_interface_profile" "cl_Leaf102_IntProf" {
  name  = "Leaf102_IntProf"
}

/* Commenting this out, since I'm going to read this information in. You can use the below to create the leaf interface profile. 
# Created a leaf interface profile for Leaf 101
resource "aci_leaf_interface_profile" "cl_lip_101" {
    description = "Created by Terraform"
    name        = "cl_leaf_101_profile"
}

# Created a leaf interface profile for Leaf 101
resource "aci_leaf_interface_profile" "cl_lip_102" {
    description = "Created by Terraform"
    name        = "cl_leaf_102_profile"
}
*/

# Created an access port selector for static path EPG interfaces. Can use variables here.
resource "aci_access_port_selector" "cl_port_selector_101" {
    #leaf_interface_profile_dn = aci_leaf_interface_profile.cl_lip_101.id
    leaf_interface_profile_dn = data.aci_leaf_interface_profile.cl_Leaf101_IntProf.id
    description               = " Created by Terraform"
    name                      = "E1_33"
    access_port_selector_type = "range"
    # Tie this information with info in policy.tf
    relation_infra_rs_acc_base_grp = aci_leaf_access_port_policy_group.cl_access_port_policy_group.id
}

resource "aci_access_port_selector" "cl_port_selector_102" {
    leaf_interface_profile_dn = data.aci_leaf_interface_profile.cl_Leaf102_IntProf.id
    #leaf_interface_profile_dn = aci_leaf_interface_profile.cl_lip_102.id
    description               = " Created by Terraform"
    name                      = "E1_39"
    access_port_selector_type = "range"
    # Tie this information with info in policy.tf
    relation_infra_rs_acc_base_grp = aci_leaf_access_port_policy_group.cl_l3out_access_port_policy_group.id
}

/* This access port block is for the endpoint in an EPG */
resource "aci_access_port_block" "cl_port_block_1_33_node_101" {
  access_port_selector_dn = aci_access_port_selector.cl_port_selector_101.id
  name                    = var.access_port_block_101_name
  #name                    = "cl_port_block_leaf_101"
  description             = "Created by Terraform"
  from_card               = "1"
  from_port               = "33"
  to_card                 = "1"
  to_port                 = "33"
}

/* This access port block is for the L3Out */
resource "aci_access_port_block" "cl_port_block_1_39_node_102" {
   access_port_selector_dn = aci_access_port_selector.cl_port_selector_102.id
   name                    = var.access_port_block_102_name
   #name                    = "cl_port_block_leaf_102"
   description             = "Created by Terraform"
   from_card               = "1"
   from_port               = "39"
   to_card                 = "1"
   to_port                 = "39"
}