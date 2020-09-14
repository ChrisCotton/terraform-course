variable "AWS_REGION" {
  #default = "eu-west-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
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
  # default = "default_value"
}
