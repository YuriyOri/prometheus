###
#
# Build Prometheus server on Ubuntu 20.04
#
###

resource "aws_instance" "prometheus" {
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [data.aws_security_group.name.id]

  subnet_id = data.aws_subnets.subnets.ids[0]

  #Add AIM Role to Prometheus Server so that it can access other hosts
  iam_instance_profile = aws_iam_role.ec2_readonly_role.name

  tags = {
    Name = var.prometheus_server_name
    OS   = "Ubuntu"
  }
  user_data = filebase64("install_prometheus_server_ubuntu.sh")

  depends_on = [aws_iam_role.ec2_readonly_role]

}
