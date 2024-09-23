output "VPC_name" {
  value = aws_vpc.main.tags.Name
}
output "VPC_id" {
  value = aws_vpc.main.id
}


output "subnet_map" {
  value = local.subnet_map
}


output "security_group_name" {
  value = aws_security_group.this.name
}
output "security_group_id" {
  value = aws_security_group.this.id
}


output "aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}