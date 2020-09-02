
################################################################################
#                                                                              #
#   is is best practice to allow only work/home/office IPs. This security      #
#   group allows ingress port 22 on IP addy range 0.0.0.0/0 (all IPs) Allows   #
#   all outgoing traffic from the instance to 0.0.0.0/0 ( all IPs again... so  #
#   ... everywhere )                                                           #
#                                                                              #
################################################################################


resource "aws_security_group" "allow-ssh" {
  vpc_id      = aws_vpc.main.id # tied to a vpc
  name        = "allow-ssh" # why put  "allow-ssh here and above ??"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0  # this from-to t=range = all ports 
    protocol    = "-1" # all protocols 
    cidr_blocks = ["0.0.0.0/0"] # all IPs
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp" # tcp is more restrictive cuz ssh only needs tcp. Common setting here is "-1" 
    cidr_blocks = ["0.0.0.0/0"] # All IPS. Best practice = make it home or office IPs only. 
  }
  tags = {
    Name = "allow-ssh"
  }
}

