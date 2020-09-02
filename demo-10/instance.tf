resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.medium"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

 ################################################################################
 #                                                                              #
 #   Run cloud init for disk mounting and configuration at startup. Template    #
 #   is loaded up here and then cloudinit is used to execute the commands to    #
 #   mount the disk and create an entry in /etc/fstab                           #
 #                                                                              #
 ################################################################################
       
  
  # user data
  user_data = data.template_cloudinit_config.cloudinit-example.rendered 
}


    ################################################################################
    #                                                                              #
    #   Add persistent storage in preparation for DB. EBS storage added with       #
    #   tform resourece then attached to instance.                                 #
    #                                                                              #
    ################################################################################


################################################################################
#                                                                              #
#   this volume needs to be attached at spinup. If it is not formatted then    #
#   we should do that as well. the end result being that we should be able to  #
#   use the volume right away and access whatever data resides on it           #
#                                                                              #
################################################################################

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "${var.AWS_REGION}a"
  size              = 20  # 20 Gigs 
  type              = "gp2" # this is SSD but not provisioned. 8 Gb root block increased aws_instance.example.root_block_device
  tags = {                  # Note: root block devices are ephemeral volumes
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name  = var.INSTANCE_DEVICE_NAME  # this variable defined in cloudinit file
  volume_id    = aws_ebs_volume.ebs-volume-1.id
  instance_id  = aws_instance.example.id
  skip_destroy = true                            # skip destroy to avoid issues with terraform destroy
}

