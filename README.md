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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | git::https://git.takeaway.com/sre-public/terraform-modules/core/aws-tag?ref=v0.1.24 |  |

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
| <a name="input_appId"></a> [appId](#input\_appId) | Unique id mapping to the application present in the inventory/service catalog. Syntax: `JET<ddddd>` | `string` | `null` | no |
| <a name="input_appInstance"></a> [appInstance](#input\_appInstance) | AppInstance can be any additional piece of information you want to label your cluster or server group with. | `string` | `null` | no |
| <a name="input_appVersion"></a> [appVersion](#input\_appVersion) | AppVersion is can be used to define the version of an application that is deployed. | `string` | `null` | no |
| <a name="input_application"></a> [application](#input\_application) | The name of the application for which the resource was provisioned, e.g. 'kafka', 'telegraf' or 'tconnect' | `string` | `null` | no |
| <a name="input_aws_cloudwatch_log_group"></a> [aws\_cloudwatch\_log\_group](#input\_aws\_cloudwatch\_log\_group) | cloudwatch audit logs groups of EKS cluster | `string` | `""` | no |
| <a name="input_cia"></a> [cia](#input\_cia) | Shows CIA( Compliance, Integrity and Availability) rating (0-5) for the application. Defaults to 555(lowest), meaning application is not assessed by security team | `number` | `null` | no |
| <a name="input_compliant"></a> [compliant](#input\_compliant) | `true`, if the resources being provisioned is compliant as per compliance rules check of AWS Config(in future), else it should automatically be set to false and avoided update by Terraform. Defaults to `true`, until Config checks are in place. | `bool` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables below for details.<br>Leave string and numeric variables as null to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "appId": null,<br>  "appInstance": null,<br>  "appVersion": null,<br>  "application": null,<br>  "cia": null,<br>  "compliant": null,<br>  "description": null,<br>  "drEnabled": null,<br>  "drEnvironment": null,<br>  "enableRetirementRemediation": null,<br>  "enabled": null,<br>  "environment": null,<br>  "exception": null,<br>  "extra_tags": {},<br>  "managedBy": null,<br>  "map_project_id": null,<br>  "map_tag": null,<br>  "name": null,<br>  "offhours": null,<br>  "patchWindow": null,<br>  "pii": null,<br>  "requestLink": null,<br>  "service": null,<br>  "sharedResponsibility": null,<br>  "suppressAlerts": null,<br>  "tagVersion": null,<br>  "team": null<br>}</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | Describes the intended purpose of the application | `string` | `null` | no |
| <a name="input_drEnabled"></a> [drEnabled](#input\_drEnabled) | If `true`, the resource will be flagged by AWS backup for backing up and copying to the secure account for disaster recovery | `bool` | `null` | no |
| <a name="input_drEnvironment"></a> [drEnvironment](#input\_drEnvironment) | Can be used to set up additional environments to copy the snapshot to. By default if drEnabled=true, the snapshot is copied to the SECURE\_ONLY account only. Set this to SECURE\_AND\_RECOVERY and it will be copied to recovery too. Can be turned OFF too (default when drEnabled=false) to only store backup in the local account AWS Backup Vault. | `string` | `null` | no |
| <a name="input_eks_bot_name"></a> [eks\_bot\_name](#input\_eks\_bot\_name) | n/a | `string` | `"eks_audit_bot"` | no |
| <a name="input_enableRetirementRemediation"></a> [enableRetirementRemediation](#input\_enableRetirementRemediation) | If `true`, SSM Automation will be allowed to restart the instance in case of its retirement being scheduled. | `bool` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any tags. `true` by default | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Type of environment, allowed values 'dev', 'development, 'beta', 'stage', 'staging', 'prod' or 'production' | `string` | `null` | no |
| <a name="input_exception"></a> [exception](#input\_exception) | If `true`, compliance services/tools would ignore the resource for policy violations/checks. Defaults to `false` | `bool` | `null` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to append to the generated tags | `map(string)` | `{}` | no |
| <a name="input_filter_pattern"></a> [filter\_pattern](#input\_filter\_pattern) | cloudwatch  logs filter pattern | `string` | `""` | no |
| <a name="input_lambda_root"></a> [lambda\_root](#input\_lambda\_root) | The relative path to the source of the lambda | `string` | `"./function"` | no |
| <a name="input_managedBy"></a> [managedBy](#input\_managedBy) | Means by which the resources are provisioned, i.e 'terraform', 'manual' or 'kubernetes'. Defaults to `terraform` | `string` | `null` | no |
| <a name="input_map_project_id"></a> [map\_project\_id](#input\_map\_project\_id) | The project ID to use for map tag generation. Defaults to `MPE16156` | `string` | `null` | no |
| <a name="input_map_tag"></a> [map\_tag](#input\_map\_tag) | `true` to create a map tag based on the Name tag. Defaults to `false` | `bool` | `null` | no |
| <a name="input_memory_limit"></a> [memory\_limit](#input\_memory\_limit) | memory limit of the lambda | `number` | `256` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the the resource(if this variable is not specified, the name tag defaults to <team>-<application>-<environment>-<account\_identifier>, where account identifier are the lart four digits of the account id) | `string` | `null` | no |
| <a name="input_offhours"></a> [offhours](#input\_offhours) | Applicable for ASGs and EC2 instances. Contains a string specifying the time period within which the resource won’t be used and can be safely shut down. For example to shutdown a resource monday to friday from 7am-7pm: offhours=`off=(M-F,19);on=(M-F,7)` | `string` | `null` | no |
| <a name="input_patchWindow"></a> [patchWindow](#input\_patchWindow) | CRON based string denoting the period to apply the patches/suppress the alerts. Example: `(0 7 * * 1),(0 9 * * 1)` would mean patch window is every Monday from 7 AM to 9 AM | `string` | `null` | no |
| <a name="input_pii"></a> [pii](#input\_pii) | PII(Personal Identifiable Information) – `true`, if the resources holds data which is sensitive as per GDPR | `bool` | `null` | no |
| <a name="input_requestLink"></a> [requestLink](#input\_requestLink) | Contains the url pointing to the request, story, issue for which the resource was created. | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | Comma separated list of services the application is responsible for ( Eg ['logging','analytics','reporting']) | `list(string)` | `null` | no |
| <a name="input_sharedResponsibility"></a> [sharedResponsibility](#input\_sharedResponsibility) | Holds comma separated list of teams who are also responsible for the application/resource | `list(string)` | `null` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | SNS topic | `string` | `""` | no |
| <a name="input_suppressAlerts"></a> [suppressAlerts](#input\_suppressAlerts) | If `true`, the monitoring alerts coming from the resource would be disabled. Defaults to `false` | `bool` | `null` | no |
| <a name="input_tagVersion"></a> [tagVersion](#input\_tagVersion) | The current tagging strategy version being implemented on the resource. Defaults to `v1.1` | `string` | `null` | no |
| <a name="input_team"></a> [team](#input\_team) | The name of the team that owns the application, e.g. 'penl', 'renl', 'infra' | `string` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Timeout of the lambda | `number` | `60` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->