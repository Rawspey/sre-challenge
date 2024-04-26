variable "workers_ami" {
    type    = string
    default = "ami-0eb199b995e2bc4e3"
}

variable "security_groups" {
    type = list(string)
    default = ["sg-0c38630af0afc6df0"]
}

variable "name" {
    type = string
}

variable "min_size" {
    type = number
    default = 1
}

variable "max_size" {
    type = number
    default = 1
}

variable "desired_capacity" {
  type = number
  default = 1
}

variable "instance_type" {
    type = string
    default = "t3.nano"
}

variable "cpuscale" {
    type = number
    default = 40.0
}

variable "cpu_credits" {
    type = string
    default = "unlimited"
}

variable "extra_tags" {
  type = map(string)
  default = {
    Type        = "worker"
    Environment = "production"
    Owner       = "software"
  }
}