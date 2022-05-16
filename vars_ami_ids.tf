# This file contains the AMI Ids of the images used for the various instances

variable "ami_ubuntu" {
  type        = map(string)
  description = "Ubuntu Bionic Beaver AMI by region updated 14/10/20"

  default = {
    us-west-2 = "ami-07e60b7f43b05d68e"
  }
}
