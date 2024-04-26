resource "aws_launch_template" "application" {
    name                   = "sre_application"
    image_id               = "${var.application_ami}"
    key_name               = "Devops Primary"
    instance_type          = "${var.instance_type}"
    vpc_security_group_ids = concat(var.security_groups, [var.alb_security_group_id])
    tag_specifications {
        resource_type = "instance"

        tags = merge(            
            {
                Name = "sre_application"
            },
            var.extra_tags,
            )
    }
  
    user_data              = base64encode(templatefile("${path.module}/userdata.tmpl", {}))

    iam_instance_profile {
        name = "CodeDeploy-EC2-Instance-Profile"
    }

    lifecycle {
        create_before_destroy = true
    }

    credit_specification {
        cpu_credits = "${var.cpu_credits}"
    }
    block_device_mappings {
      device_name = "/dev/sda1"

    ebs {
      volume_size = 100
      volume_type = "gp3"
    }
  }
}

resource "aws_autoscaling_group" "application" {
    name = "application"
    min_size = "${var.min_size}"
    desired_capacity = "${var.desired_capacity}"
    max_size = "${var.max_size}"
    vpc_zone_identifier = ["subnet-0c80a127103c7f99e", "subnet-08c1c9049e6629ec4"]

    launch_template {
      id        = "${aws_launch_template.application.id}"
      version   = "$Latest"
    }
    
    target_group_arns = [var.target_group_arn]
}

resource "aws_autoscaling_policy" "application_cpu" {
    name                   = "cpu-autoscaling"
    adjustment_type        = "ChangeInCapacity"
    policy_type            = "TargetTrackingScaling"
    autoscaling_group_name = "${aws_autoscaling_group.application.name}"
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = "${var.cpuscale}"
    }
    depends_on = [aws_autoscaling_group.application]
}


