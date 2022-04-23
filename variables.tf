variable "name" {
  description = "(Required) Name of the capacity provider."
  type        = string
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags. "
  type        = map(string)
  default     = {}
}

variable "auto_scaling_group_arn" {
  description = "(Required) - ARN of the associated auto scaling group."
  type        = string
}

variable "managed_termination_protection" {
  description = "(Optional) - Enables or disables container-aware termination of instances in the auto scaling group when scale-in happens. Valid values are ENABLED and DISABLED."
  type        = string
  default     = "DISABLED"
}

variable "instance_warmup_period" {
  description = "(Optional) Period of time, in seconds, after a newly launched Amazon EC2 instance can contribute to CloudWatch metrics for Auto Scaling group"
  type        = number
  default     = 300
}

variable "maximum_scaling_step_size" {
  description = "(Optional) Maximum step adjustment size. A number between 1 and 10,000."
  type        = number
  default     = null
}

variable "minimum_scaling_step_size" {
  description = "(Optional) Minimum step adjustment size. A number between 1 and 10,000."
  type        = number
  default     = null
}

variable "status" {
  description = "(Optional) Whether auto scaling is managed by ECS. Valid values are ENABLED and DISABLED."
  type        = string
  default     = "ENABLED"
}

variable "target_capacity" {
  description = "(Optional) Target utilization for the capacity provider. A number between 1 and 100."
  type        = number
  default     = null
}
