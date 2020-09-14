################################################################################
#                                                                              #
#   terraform will goto the url  below to get the IP address of our machine    #
#   which is then used in the populate workstation-external-cidr below         #
#                                                                              #
################################################################################

data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

# Why not use terraform outputs??? 
locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

