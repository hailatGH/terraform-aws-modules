variable "aws_access_key" {
  type = string
  sensitive = true
}

variable "aws_secret_key" {
  type = string
  sensitive = true
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "allow_public_access" {
  type = bool
  default = false
}

variable "source_dest_check" {
  type = bool
  default = false
}

variable "public_key" {
  type = list(string)
}

variable "volume_size" {
  type = number
}

variable "volume_type" {
  type = string
}