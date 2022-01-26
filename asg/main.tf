# asg.tf 
# asg & launch configuration

#############################
# Launch Configuration
#############################

resource "aws_launch_configuration" "asg_config" {
  for_each      = var.asg_config
  name          = each.value.name
  image_id      = each.value.image_id
  instance_type = each.value.instance_type
  security_groups      = each.value.security_groups
  iam_instance_profile = each.value.iam_instance_profile
  key_name      = each.value.key_name
 # user_data = file("${path.module}/userdata/userdata_webserver_management.sh")
  root_block_device {
    volume_type           = each.value.root_block_device.volume_type
    volume_size           = each.value.root_block_device.volume_size
    delete_on_termination = each.value.root_block_device.delete_on_termination

  }
  #  ebs_block_device {
  #    volume_type           = each.value.ebs_block_device.volume_type
  #    volume_size           = each.value.ebs_block_device.volume_size
  #    delete_on_termination = each.value.ebs_block_device.delete_on_termination
  #  }
}

resource "aws_autoscaling_group" "as_launch" {
  for_each             = var.asg_config
  name                 = aws_launch_configuration.asg_config[each.key].name
  launch_configuration = aws_launch_configuration.asg_config[each.key].name
  min_size             = var.asg_config[each.key].min_size
  max_size             = var.asg_config[each.key].max_size
  vpc_zone_identifier  = each.value.vpc_zone_identifier
  tags = [
    {
      key                 = "Name"
      value               = each.value.tags.name
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = each.value.tags.environment
      propagate_at_launch = true
    },
    {
      key                 = "Department"
      value               = each.value.tags.department
      propagate_at_launch = true
    },
    {
      key                 = "Deployed via"
      value               = each.value.tags.deployment
      propagate_at_launch = true
    },
  ]
  lifecycle {
    create_before_destroy = true
  }
}
