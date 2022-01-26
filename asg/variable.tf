#############################
# Region
#############################

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

#############################
# ASG
#############################

variable "asg_config" {
  description = "ASG Launch Configuration"
  default = {
    "Env1" = {
      name                  = "env-web"
      image_id              = "ami-xxxxxxx"
      instance_type         = "t3.small"
      security_groups       = ["sg-xxxxxxx"]
      vpc_zone_identifier   = ["subnet-xxxxxxxx", "subnet-xxxx"]
      iam_instance_profile  = "env-webapp"
      delete_on_termination = true
      key_name              = "env-web"
      min_size              = 1
      max_size              = 2
      root_block_device = {
        volume_type           = "gp2"
        volume_size           = "8"
        delete_on_termination = true
      }
      #	ebs_block_device = {
      #	      	volume_type           = ""
      #		volume_size           = ""
      #      		delete_on_termination = true
      #	}
      tags = {
        name        = "env-web"
        environment = "Internal Production"
        department  = "Dev"
        deployment  = "Terraform"
      }
   }, 
   "env-worker" = {
      name                  = "env-worker"
      image_id              = "ami-xxxxxxx"
      instance_type         = "t3.small"
      security_groups       = ["sg-xxxxxxx"]
      vpc_zone_identifier   = ["subnet-xxxxxxx", "subnet-xxxxxxx"]
      iam_instance_profile  = "env-webapp"
      delete_on_termination = true
      key_name              = "env-worker"
      min_size              = 2
      max_size              = 2
      root_block_device = {
        volume_type           = "gp2"
        volume_size           = "8"
        delete_on_termination = true
      }
      # ebs_block_device = {
      #         volume_type           = ""
      #         volume_size           = ""
      #                 delete_on_termination = true
      # }
      tags = {
        name        = "env-worker"
        environment = "Internal Production"
        department  = "Dev"
        deployment  = "Terraform"
      }
    }
  }
}
