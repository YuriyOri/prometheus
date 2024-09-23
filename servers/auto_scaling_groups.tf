###
#
# Build Auto Scaling Groups on Ubuntu 20.04 using "aws_launch_template" template
#
###

resource "aws_autoscaling_group" "autoscale" {

  launch_template {
    id      = aws_launch_template.node_exporter_template.id
    version = "$Latest"
  }

  for_each = { for group in var.auto_scaling_group : group.name => group }

  name = "ASG-server-${each.value.name}"

  vpc_zone_identifier = data.aws_subnets.subnets.ids

  min_size         = each.value.min_size
  max_size         = each.value.max_size
  desired_capacity = each.value.desired_capacity

  dynamic "tag" {
    for_each = each.value.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  depends_on = [aws_launch_template.node_exporter_template]

}


