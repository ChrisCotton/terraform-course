

################################################################################
#                                                                              #
#   NAT is useful if you need instances on private subnets to access pub inet  #
#   but not the other way around vpc = true                                    #
#                                                                              #
################################################################################

resource "aws_eip" "nat" { # use case : DB which needs to fetch updates but remain private. 
  vpc = true # static IP address 
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main-public-1.id
  depends_on    = [aws_internet_gateway.main-gw]
}

# VPC setup for NAT

################################################################################
#                                                                              #
#   this route table re-routes traffic through the NAT gateway. Then we        #
#   associate this route table to the private instances. Note it you want a    #
#   purely private subnet that never needs to contact internet then no need    #
#   for any route table associations to private                                #
#                                                                              #
################################################################################
resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "main-private-1"
  }
}

# route table associations to private instances 
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.main-private-1.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "main-private-2-a" {
  subnet_id      = aws_subnet.main-private-2.id
  route_table_id = aws_route_table.main-private.id
}

resource "aws_route_table_association" "main-private-3-a" {
  subnet_id      = aws_subnet.main-private-3.id
  route_table_id = aws_route_table.main-private.id
}

