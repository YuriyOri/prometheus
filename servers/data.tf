data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_ami" "latest_ubuntu" {
  owners      = [var.owner]
  most_recent = true
  filter {
    name   = "name"
    values = [var.ubuntu_url]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_network_name]
  }
}

data "aws_security_group" "name" {
  filter {
    name   = "group-name"
    values = [var.security_group_name]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

# instances of "auto scaling groups" 
data "aws_instances" "all_instances" {
  depends_on = [aws_autoscaling_group.autoscale]
}

data "aws_instances" "filtered_by_asg_instance_name" {
    filter {
        name = "tag:Name"
        values = [for k in var.auto_scaling_group: k.tags["Name"]]
    }

    depends_on = [aws_autoscaling_group.autoscale]
}
