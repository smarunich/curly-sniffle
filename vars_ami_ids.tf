# This file contains the AMI Ids of the images used for the various instances

variable "ami_ubuntu" {
  type        = map(string)
  description = "Ubuntu Bionic Beaver AMI by region updated 14/10/20"

  default = { 
    us-west-2 = "ami-0f846ea6472ae64f0"
  }
}
