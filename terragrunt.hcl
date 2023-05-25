# Indicate where to source the terraform module from.
# The URL used here is a shorthand for
# "tfr://registry.terraform.io/terraform-aws-modules/vpc/aws?version=3.5.0".
# Note the extra `/` after the protocol is required for the shorthand
# notation.
terraform {
  source = "tfr:///Azure/vnet/azurerm?version=4.0.0"
}

# Indicate what region to deploy the resources into
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "azure" {
  region = "eastus"
}
EOF
}

# Indicate the input values to use for the variables of the module.
inputs = {
  resource_group_name = ansibleTesting
  use_for_each = false
  vnet_location = eastus

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
