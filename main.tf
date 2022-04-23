resource "aws_ecs_capacity_provider" "this" {
  name = var.name
  tags = var.tags
  auto_scaling_group_provider {
    auto_scaling_group_arn = var.auto_scaling_group_arn
    managed_scaling {
      status                    = var.status
      instance_warmup_period    = var.instance_warmup_period
      target_capacity           = var.target_capacity
      maximum_scaling_step_size = var.maximum_scaling_step_size
      minimum_scaling_step_size = var.minimum_scaling_step_size
    }
  }
}
