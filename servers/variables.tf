variable "default_zone" {
  description = "The default zone for Prometheus"
  type        = string
  default     = "eu-central-1"              # Frankfurt region
}

variable "owner" {
  description = "Ubuntu template owner ID"
  type        = string
  default     = "099720109477"
}

variable "key_name" {
  description = "Key name"
  type        = string
  default     = "Frankfurt_16092024"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "ubuntu_url" {
  description = "Url to Ubuntu image"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-2024*"
}

#=========== network ==============
variable "vpc_network_name" {
  description = "The name of main network"
  type        = string
  default     = "prom-net"
}

variable "security_group_name" {
  description = "The default security group name"
  type        = string
  default     = "allow_all_traffic_sg"
}

variable "aws_iam_role" {
  description = "value"
  type        = string
  default     = "Prometheus-Server-EC2ReadOnly_Role"
}

#=========== servers ==============
variable "template_name" {
  description = "Template name"
  type        = string
  default     = "Ubuntu2204_NodeExporter"
}

variable "auto_scaling_group" {
  description = "Auto scaling group values"

  type = list(object(
    {
      name             = string
      min_size         = number
      max_size         = number
      desired_capacity = number

      tags = optional(map(string))
    }
  ))

  default = [ {
    name             = "DEV",
    min_size         = 1,
    max_size         = 1,
    desired_capacity = 1,

    tags = {
      "Environment" = "dev",
      "Name"        = "App-Server-DEV"
    }
  },
  {
    name             = "PROD",
    min_size         = 2,
    max_size         = 2,
    desired_capacity = 2,
    tags = {
      "Environment" = "prod",
      "Name"        = "App-Server-PROD"
    }
  } ]
}

variable "prometheus_server_name" {
  description = "Prometheus server name"
  type        = string
  default     = "Prometheus-Server"
}

variable "grafana_server_name" {
  description = "Grafana server name"
  type        = string
  default     = "Grafana-Server"
}
