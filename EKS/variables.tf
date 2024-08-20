variable "eks_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnets" {
  description = "public subnets cidr"
  type        = list(string)
}

variable "private_subnets" {
  description = "private subnets cidr"
  type        = list(string)
}

variable "instances_types" {
  description = "Node instances"
  type        = list(string)
}