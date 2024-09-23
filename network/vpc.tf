###
#
# Create a new VPS
#
###

resource "aws_vpc" "main" {
  cidr_block           = var.default_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_network_name
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = local.subnet_map

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.zone

  tags = {
    Name = each.value.name
  }
}


# Set up Internet Gateway to provide access to the internet in the given VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Prometheus VPC IG"
  }
}

# Create a Second Route Table and associate it with the same VPC 
#To make the subnets named "Public", we have to create routes using IGW which will enable the traffic from the Internet to access these subnets.
resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Prometheus - 2nd Route Table"
  }
}

# #Associate Public Subnets with the Second Route Table
resource "aws_route_table_association" "public_subnet_asso" {

  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.second_rt.id
}