provider "aws" {
  region = var.aws-region
}

locals {

#name of ASAvs from config for config file generation
asav_names = flatten([for asa_key, asa in var.asa-instances: [{
    name = asa_key
}]])

  vpc_private_subnets = {
      a = var.private-cidr-a,
      b = var.private-cidr-b
  }

}

#config file creation
data "template_file" "template" {
for_each = {for asa_key, asa in var.asa-instances: asa_key => asa}

template = "${file("asav_config_template_v2.txt")}"
  vars = {
  hostname = each.key
  idtoken = "${lookup(lookup(var.asa-instances, each.key),"token")}"
  license_throughput = var.asa-license-throughput
  vpn_pool_from = "${lookup(lookup(var.asa-instances, each.key),"vpn-pool-from")}"
  vpn_pool_to = "${lookup(lookup(var.asa-instances, each.key),"vpn-pool-to")}"
  vpn_pool_mask =  "${lookup(lookup(var.asa-instances, each.key),"vpn-pool-mask")}"
  vpc_cidr = replace(var.vpc1-cidr, "//.*/", "")
  on_prem_cidr = replace(var.on-prem-cidr, "//.*/", "")
  on_prem_pool = var.on-prem-pool
  on_prem_netmask = var.on-prem-netmask
  private_subnet_gw = replace(lookup(local.vpc_private_subnets,each.value.availability-zone), "/.0/.*/", ".1")
  }
}


#just a null resource which calls terraform outputs to generate the json render of the config files and save them into individual configurations
resource "null_resource" "asa_templates" {

for_each = {for asa_key, asa in var.asa-instances: asa_key => asa}

  provisioner "local-exec" {  

    command = "terraform output -json | jq -r '.render.value.${each.key}' > ${each.key}.txt"
  }

  triggers = {timestamp = timestamp()}

depends_on = [data.template_file.template]

}