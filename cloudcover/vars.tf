variable "KEY_BASENAME" {
  type = string
  description = "Keyname set here to avoid key already in use errors"
  
}

variable "AWS_REGION" {
  #default = "eu-west-1"
}

variable "INSTANCE_DEVICE_NAME" {
  #default = "eu-west-1"
  description = "persistent filesystem to mount"
}

# variable "PATH_TO_PRIVATE_KEY" {
#   default = local.common_tags.prvkey_path
# }


# variable "PATH_TO_PUBLIC_KEY" {
#   type    = string
#   default = "tfkey4"
# }

variable "AWS_PROFILE" {
  description = "Profile name from aws config"
}

variable "this-cluster" {
  type = string
  description = "Used to prepend and append resource names"
  # default = "default_value" 
}

variable "cluster-name" {
  type = string
  description = "Used to prepend and append resource names and tags"
  #default = "${var.this-cluster}-cluster" # This doesn't work
}

# variable "this-cluster" {
#   type = string
#   description = "Used to prepend and append resource names and tags"
#   #default = "${var.this-cluster}-cluster" # This doesn't work
# }

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1     = "ami-13be557e"
    us-west-2     = "ami-06b94666"
    eu-west-1     = "ami-844e0bf7"
  }
}

variable "RDS_PASSWORD" { # most secure way is to pass this on cli: tf apply -var RDS_PASSWORD=myrandomPW

}

# locals { # throw no variables errors. 
#   # Common tags to be assigned to all resources
#   common_tags = {
#     Service       = local.service_name
#     Owner         = local.owner
#     pubkey_path   = "${var.KEY_BASENAME}.pub"
#     prvkey_path   = var.KEY_BASENAME

#   }
# }


