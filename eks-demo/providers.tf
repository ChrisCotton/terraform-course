
################################################################################
#                                                                              #
#   Note: EKS costs average about 20 cents per hour    plus the ec2 instance   #
#   costs for all the worker nodes.                                            #
#                                                                              #
################################################################################


variable "region" {
  type = string
  description = "AWS Region"
}

variable "profile" {
  type = string
  description = "Profile Used for this Deploy"
}

variable "this-cluster" {
  type = string
  description = "append or prepend cluster name to resouces and tags"
}

provider "aws" {
  region    = var.region
  profile   = var.profile
}


################################################################################
#                                                                              #
#   Data sources allow data to be fetched or computed for use elsewhere in     #
#   Terraform configuration. Use of data sources allows a Terraform            #
#   configuration to make use of information defined outside of Terraform, or  #
#   defined by another separate Terraform configuration. ie: notice how        #
#   availability_zones data source is defined in vpc.tf where it returns the   #
#   names of the first 3 azs used after they are computed.                     #
#                                                                              #
################################################################################


data "aws_region" "current" {
}

data "aws_availability_zones" "available" {
}

provider "http" {
}


