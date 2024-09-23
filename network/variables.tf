variable "default_zone" {
  description = "The default zone for Prometheus"
  type        = string
  default     = "eu-central-1"    # Frankfurt region
}

#=========== network ==============
variable "vpc_network_name" {
  description = "The name of main network"
  type        = string
  default     = "prom-net"
}

variable "default_vpc_cidr" {
  description = "The default IPv4 CIDR for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "How much longer the resulting prefix will be in bits for subnets."
  type        = number
  default     = 8
}

variable "security_group_name" {
  description = "The default security group name"
  type        = string
  default     = "allow_all_traffic_sg"
}
