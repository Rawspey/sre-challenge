


resource "aws_launch_template" "workers" {
    name                   = "workers_${var.name}"
    image_id               = "${var.workers_ami}"
    key_name               = "Devops Primary"
    instance_type          = "${var.instance_type}"
    vpc_security_group_ids = "${var.security_groups}"
    tag_specifications {
        resource_type = "instance"

        tags = merge(            
            {
                Name = "workers_${var.name}"
            },
            var.extra_tags,
            )
    }    

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
        volume_size = 20
        volume_type = "gp3"
      }
  }
    
}

resource "aws_autoscaling_group" "workers" {
    name = "workers_${var.name}"
    min_size = "${var.min_size}"
    desired_capacity = "${var.desired_capacity}"
    max_size = "${var.max_size}"
    vpc_zone_identifier = ["subnet-056e052ec65ff2bf2", "subnet-0fe317b6ad2fff63b"]
 
    launch_template {
      id        = "${aws_launch_template.workers.id}"
      version   = "$Latest"
    }
}

resource "aws_autoscaling_policy" "workers_cpu" {
    name                   = "cpu-autoscaling"
    adjustment_type        = "ChangeInCapacity"
    policy_type            = "TargetTrackingScaling"
    autoscaling_group_name = "${aws_autoscaling_group.workers.name}"
    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = "${var.cpuscale}"
    }
    depends_on = [aws_autoscaling_group.workers]
}


