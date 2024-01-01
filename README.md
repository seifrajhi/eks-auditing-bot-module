<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.4 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.52.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lambda-log-group](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_subscription_filter.logging](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_iam_policy.eks_audit_logs_bot](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks_audit_logs_bot](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_audit_logs_bot](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda-audit-logs](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/resources/lambda_permission) | resource |
| [null_resource.install_dependencies](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_uuid.lambda_src_hash](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [archive_file.lambda_source](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_account_alias.current](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/data-sources/iam_account_alias) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/4.52.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS account ID | `string` | `""` | no |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | AWS account name | `string` | `""` | no |
| <a name="input_aws_cloudwatch_log_group"></a> [aws\_cloudwatch\_log\_group](#input\_aws\_cloudwatch\_log\_group) | cloudwatch audit logs groups of EKS cluster | `string` | `""` | no |
| <a name="input_eks_bot_name"></a> [eks\_bot\_name](#input\_eks\_bot\_name) | n/a | `string` | `"eks_audit_bot"` | no |
| <a name="input_filter_pattern"></a> [filter\_pattern](#input\_filter\_pattern) | cloudwatch  logs filter pattern | `string` | `""` | no |
| <a name="input_lambda_root"></a> [lambda\_root](#input\_lambda\_root) | The relative path to the source of the lambda | `string` | `"./function"` | no |
| <a name="input_memory_limit"></a> [memory\_limit](#input\_memory\_limit) | memory limit of the lambda | `number` | `256` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | SNS topic | `string` | `""` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Timeout of the lambda | `number` | `60` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->