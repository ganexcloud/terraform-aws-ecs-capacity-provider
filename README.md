<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_capacity_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_capacity_provider) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scaling_group_arn"></a> [auto\_scaling\_group\_arn](#input\_auto\_scaling\_group\_arn) | (Required) - ARN of the associated auto scaling group. | `string` | n/a | yes |
| <a name="input_instance_warmup_period"></a> [instance\_warmup\_period](#input\_instance\_warmup\_period) | (Optional) Period of time, in seconds, after a newly launched Amazon EC2 instance can contribute to CloudWatch metrics for Auto Scaling group | `number` | `300` | no |
| <a name="input_managed_termination_protection"></a> [managed\_termination\_protection](#input\_managed\_termination\_protection) | (Optional) - Enables or disables container-aware termination of instances in the auto scaling group when scale-in happens. Valid values are ENABLED and DISABLED. | `string` | `"DISABLED"` | no |
| <a name="input_maximum_scaling_step_size"></a> [maximum\_scaling\_step\_size](#input\_maximum\_scaling\_step\_size) | (Optional) Maximum step adjustment size. A number between 1 and 10,000. | `number` | `null` | no |
| <a name="input_minimum_scaling_step_size"></a> [minimum\_scaling\_step\_size](#input\_minimum\_scaling\_step\_size) | (Optional) Minimum step adjustment size. A number between 1 and 10,000. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the capacity provider. | `string` | n/a | yes |
| <a name="input_status"></a> [status](#input\_status) | (Optional) Whether auto scaling is managed by ECS. Valid values are ENABLED and DISABLED. | `string` | `"ENABLED"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Key-value map of resource tags. | `map(string)` | `{}` | no |
| <a name="input_target_capacity"></a> [target\_capacity](#input\_target\_capacity) | (Optional) Target utilization for the capacity provider. A number between 1 and 100. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN that identifies the capacity provider. |
| <a name="output_name"></a> [name](#output\_name) | ARN that identifies the capacity provider. |
<!-- END_TF_DOCS -->