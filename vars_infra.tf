# This file contains various variables that affect the configuration of the deployed infrastructure
#

variable "vpc_cidr" {
  description = "Primary CIDR block for VPC"
  default     = "172.20.0.0/16"
}

variable "flavour_master" {
  description = "AWS instance type for servers etc"
  default     = "t2.xlarge"
}

variable "flavour_server" {
  description = "AWS instance type for servers etc"
  default     = "t2.large"
}

variable "flavour_ubuntu" {
  description = "AWS instance type for servers etc"
  default     = "t2.large"
}


variable "vol_size_ubuntu" {
  description = "Volume size for instances in G"
  default     = "60"
}

