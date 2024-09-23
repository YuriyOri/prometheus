locals {
  aws_avail_zones = data.aws_availability_zones.available.names
}

locals {
  subnet_map = {
    for k, v in local.aws_avail_zones : v => {
      name = "${v}${k + 1}"
      zone = v
      #calculates a subnet address within given IP network address prefix
      cidr = cidrsubnet(var.default_vpc_cidr, var.subnet_prefix, k + 1)
    }
  }
}

