provider "aws" {
  region = var.aws-region
} 


module "ASAv_Instances" {

source = "../../../modules/aws/r53"

dns_name = var.dns-name
# dns_name = var.ciscops.io
vpn_sub_domain = var.vpn-sub-domain
# vpn_sub_domain = var.vpn

}