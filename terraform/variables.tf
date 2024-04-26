## Application servers varaibles

variable "elb_name" {
    type    = string
    default = "sre-application-alb"    
}

variable "vpc_id" {
    type    = string
    default = "vpc-0792372e93a253e53"    
}

variable "public_subnet_ids" {
    type = list(string)
    default = ["subnet-0c80a127103c7f99e", "subnet-08c1c9049e6629ec4"]
}

variable "sns_topic" {
    type    = string
    default = "arn:aws:sns:us-west-2:639035123345:Admins"
}