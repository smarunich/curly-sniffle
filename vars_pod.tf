# This file contains various variables that affect the deployment itself
#

# The following variables should be defined via a seperate mechanism to avoid distribution
# For example the file terraform.tfvars


variable "aws_region" {
  default = "us-west-2"
}

variable "pod_count" {
  description = "The pod size. Each pod is own k8s clsuter"
  default     = 1
}

variable "lab_timezone" {
  description = "Lab Timezone: PST, EST, GMT or SGT"
  default     = "EST"
}

variable "server_count" {
  description = "K8S Workers count per pod"
  default     = 3
}

variable "master_count" {
  description = "K8S Masters count per pod"
  default     = 1
}

variable "id" {
  description = "A prefix for the naming of the objects / instances"
  default     = "smk8sdemo"
}

variable "owner" {
  description = "Sets the AWS Owner tag appropriateliy"
  default     = "sergey@tetrate.io"
}


