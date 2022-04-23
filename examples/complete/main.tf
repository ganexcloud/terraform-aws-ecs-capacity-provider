provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon_linux_ecs" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

module "security_group_ecs_cluster" {
  source              = "terraform-aws-modules/security-group/aws"
  version             = "~> 4.9.0"
  name                = "ecs-cluster"
  description         = "ecs-cluster"
  vpc_id              = module.vpc_ecs_production.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  use_name_prefix     = false
  ingress_with_cidr_blocks = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "iam_assumable_role_production_ecsinstancerole" {
  source                  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version                 = "~> 4"
  role_name               = "production-ECSInstanceRole"
  create_role             = true
  create_instance_profile = true
  role_requires_mfa       = false
  trusted_role_services = [
    "ec2.amazonaws.com"
  ]
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
}

module "vpc_ecs-production" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "3.14.0"
  name                 = "ecs-production"
  cidr                 = "10.100.0.0/16"
  azs                  = ["us-east-1a", "us-east-1c", "us-east-1d"]
  public_subnets       = ["10.100.0.0/20", "10.100.16.0/20", "10.100.32.0/20"]
  private_subnets      = ["10.100.48.0/20", "10.100.64.0/20", "10.100.80.0/20"]
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_ipv6          = true
}

module "autoscalinggroup_nodes_staging" {
  source                    = "terraform-aws-modules/autoscaling/aws"
  version                   = "~> 4.4.0"
  name                      = "nodes-staging"
  lc_name                   = "nodes-staging"
  use_lc                    = true
  create_lc                 = true
  image_id                  = data.aws_ami.amazon_linux_ecs.id
  instance_type             = "t3.micro"
  key_name                  = "vpn"
  security_groups           = [module.security_group_ecs_cluster.security_group_id]
  iam_instance_profile_name = module.iam_assumable_role_production_ecsinstancerole.iam_instance_profile_id
  user_data                 = <<-EOT
  #!/bin/bash
  echo "ECS_CLUSTER=${"production"}" >> /etc/ecs/ecs.config
  EOT
  vpc_zone_identifier       = module.vpc_ecs_production.public_subnets
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  default_cooldown          = 60
  wait_for_capacity_timeout = 0
  tags = [
    {
      key                 = "Cluster"
      value               = "production"
      propagate_at_launch = true
    },
  ]
}

module "ecs_capacity_provider" {
  source                    = "ganexcloud/ecs-capacity-provider/aws"
  version                   = "0.0.1"
  name                      = "nodes-staging"
  auto_scaling_group_arn    = module.autoscalinggroup_nodes_staging.autoscaling_group_arn
  target_capacity           = 100
  maximum_scaling_step_size = 4
  minimum_scaling_step_size = 1
  instance_warmup_period    = 60
}
