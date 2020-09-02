################################################################################
#                                                                              #
#   We are working with an init script, a shell script and a 2-part rendered   #
#   cloudinit template                                                         #
#                                                                              #
################################################################################


data "template_file" "init-script" { # this init script is different than the shell script below
  template = file("scripts/init.cfg")
  vars = {
    REGION = var.AWS_REGION
  }
}

data "template_file" "shell-script" {
  template = file("scripts/volumes.sh")
  vars = {
    DEVICE = var.INSTANCE_DEVICE_NAME # We pass DEVICE as a varianble to scripts/volumes.sh 
  }
}



data "template_cloudinit_config" "cloudinit-example" { 
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init-script.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script.rendered
  }
}

