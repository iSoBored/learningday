variable "project" {
  description = "Name of the project"
  type        = string
}

variable "profile" {
  description = "AWS credentials profile to use"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  type        = string
}

variable "subnet_details" {
  description = "Subnets to be created"
  type        = map(any)
}

variable "ami_id" {
  description = "AMI ID to use for EC2s"
  type        = string
}

variable "instance_type" {
  description = "Instance type to use for EC2s"
  type        = string
  # default = "t2.micro"
  default = "t2.micro"
}