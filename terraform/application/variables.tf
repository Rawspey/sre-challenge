variable "application_ami" {
    type    = string
    default = "ami-08f7912c15ca96832"
}

variable "security_groups" {
    type = list(string)
    default = ["sg-0c38630af0afc6df0"]
}

variable "alb_security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "min_size" {
    type = number
    default = 1
}

variable "desired_capacity" {
  type = number
  default = 2
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "max_size" {
    type = number
    default = 4
}

variable "cpuscale" {
    type = number
    default = 60.0
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
