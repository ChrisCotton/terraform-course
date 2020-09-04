variable "AWS_REGION" {
  #default = "eu-west-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "tfkey3"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "tfkey3.pub"
}


variable "AWS_PROFILE" {
  #default = "mykey.pub"
}

variable "this-cluster" {
  type = string
  description = "Used to prepend and append resources"
  # default = "default_value" 
}

variable "cluster-name" {
  type = string
  description = "Used to prepend and append resources"
  #default = "${var.this-cluster}-cluster"
}


variable "AMIS" {
  type = map(string)
  default = {
    eu-central-1  = "ami-de486035"
    us-west-2     = "ami-06b94666"
    eu-west-1     = "ami-844e0bf7"
  }
}

variable "RDS_PASSWORD" { # most secure way is to pass this on cli: tf apply -var RDS_PASSWORD=myrandomPW

}

