resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.medium"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}


################################################################################
#                                                                              #
#   Add persistent storage in preparation for DB. EBS storage added with       #
#   tform resourece then attached to instance.                                 #
#                                                                              #
################################################################################


resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "${var.AWS_REGION}a"
  size              = 20  # 20 Gigs 
  type              = "gp2" # this is SSD but not provisioned. 8 Gb root bvlock increased aws_instance.example.root_block_device
  tags = {                  # Note: root block devices are ephemeral volumes
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.example.id
}

