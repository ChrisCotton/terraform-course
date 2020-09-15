provider "aws" { 

}


variable "AWS_REGION" {
  type = string
  description = "describe your variable"
  default = "us-east-2"
}

variable "AMIS" {
  type = map(string)
  description = "describe your variable"
  default = {
    us-east-2 = "my-ami-for-us-east-2"
    us-east-1 = "my-ami-for-us-east-1"
  }
}

######################################################
#                                                    #
#   All resources must have an associated provider   #
#                                                    #
######################################################

resource "aws_instance" "example" { # Properties below are pre-defined
    ami             = var.AMIS[var.AWS_REGION] # Map lookup going on here for image id by region
    instance_type   = "ts.micro" 
}
