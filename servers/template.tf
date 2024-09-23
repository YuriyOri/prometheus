###
#
# Build Template for Node Exporter on Ubuntu 20.04
#
###

resource "aws_launch_template" "node_exporter_template" {
  name          = var.template_name
  image_id      = data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  #### for public ip "vpc_security_group_ids" is disabled and "network_interfaces" is enabled
  #### for private ip "vpc_security_group_ids" is enabled  and "network_interfaces" is disabled

  # vpc_security_group_ids	= [data.aws_security_group.name.id]

  #Assigning public IP
  network_interfaces {
    security_groups             = [data.aws_security_group.name.id]
    delete_on_termination       = true
    subnet_id                   = data.aws_subnets.subnets.ids[0]
    description                 = "Primary"
    device_index                = 0
    associate_public_ip_address = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      OS = "Ubuntu"
    }
  }

  user_data = filebase64("install_prometheus_node_exporter.sh")
}

