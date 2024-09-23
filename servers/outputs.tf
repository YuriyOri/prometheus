# template
output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}
output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "launch_template_id" {
  value = aws_launch_template.node_exporter_template.id
}
output "launch_template_name" {
  value = aws_launch_template.node_exporter_template.name
}

# auto scaling groups
output "autoscaling_group_names" {
    value = [for k in aws_autoscaling_group.autoscale: k.name]
}

# output "autoscaling_instances_ids" {
output "asg_instance_ids" {
  value =  data.aws_instances.filtered_by_asg_instance_name.ids
}

#role
output "aws_iam_role" {
  value = aws_iam_role.ec2_readonly_role.name
}

#prometheus
output "server_prometheus_name" {
  value = aws_instance.prometheus.tags["Name"]
}
output "server_prometheus_id" {
  value = aws_instance.prometheus.id
}

#grafana
output "server_grafana_name" {
  value = aws_instance.grafana.tags["Name"]
}
output "server_grafana_id" {
  value = aws_instance.grafana.id
}

