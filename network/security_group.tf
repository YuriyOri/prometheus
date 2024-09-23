###
#
# Create Security Group, it allows all traffic
#
###

resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = "Security Group for Prometheus configuration with all traffic allowed"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Prometheus"
  }
}


