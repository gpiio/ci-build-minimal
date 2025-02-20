variable "aws_region" {
  type        = string
}

variable "app_name" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "container_port" {
  type        = number
  default     = 8000
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}
