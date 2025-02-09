# Repository Terraform code/configuration for Cisco Live breakout session BRKDCN-2607

This repository is built to support the Cisco Live breakout session BRKDCN-2607. This repository contains 3 separate projects

- 1 `ACCESS_POLICIES` which configures ACI Fabric access policies for both end points (and EPGs) in our Tenant `PROD` as well as for an L3Out which will be used to connect to an upstream NX-OS device

- 2 `PROD` which provisions a ACI Tenant and associated child policies (VRF, Bridge-Domain, BD Subnet, etc.). It also contains a file (l3out.tf) which provisions infrastructure for L3Outs from ACI.

This was developed and tested with Terraform version 1.9.3 and latest version of the Terraform ACI provider (2.15.0 at the time this was developed)

Terraform treats each of these as a separate project, which means you will need to initialize Terraform in each directory so that the ACI plugins can be installed.

## Installing Terraform

Installing Terraform is very easy and there is support for a multitude of platforms in which you can run it on. To install Terraform, please visit the [repository site](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). 


## Clone this git repository

You will need to have Git installed on your system. If you don't have it installed, you can download it from [here](https://git-scm.com/downloads). To clone the repository, run the following command:

```bash
git clone https://github.com/trenzy/BRKDCN-2607
```

## Running Terraform (init, plan, & apply)

You will need to initialize Terraform in each of the project folders. 

Terraform init to download the ACI provider plugin:

```bash
terraform init
```

You can then validate your Terraform configurations using:

```bash
terraform validate
```

See what Terraform is going to do with Terraform plan:

```bash
terraform plan
```

Then apply your configurations:

```bash
terraform apply -auto-approve
```
