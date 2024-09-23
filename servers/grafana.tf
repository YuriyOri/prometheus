###
#
# Build Grafana Server on Ubuntu 20.04
#
###

resource "aws_instance" "grafana" {
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [data.aws_security_group.name.id]

  subnet_id = data.aws_subnets.subnets.ids[0] #select first subnet

  tags = {
    Name = var.grafana_server_name
    OS   = "Ubuntu"
  }

  user_data = templatefile("install_grafana_server_ubuntu.sh.tpl", {
    prom_ip = aws_instance.prometheus.public_ip
  })

  depends_on = [aws_instance.prometheus]

}


