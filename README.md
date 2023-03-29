# terraform-module-template
A template to be used with Terraform modules containing base CI config and GH actions

## Example Usage:

```hcl
```

## Run validation locally

The module's terraform validation can be run with [act](https://github.com/nektos/act). Version `v0.2.41` or above (support for reusable workflows)

Instructions for validating the module's code locally 
- install `act` if not installed already `brew install act`
- Create read-only [token](https://github.com/settings/tokens) and store it in a local file `~/act-secrets.txt`. Secrets file format is the same as .env format `GITHUB_TOKEN=<your_token>`
- Run validation workflow at root level `act pull_request --secret-file ~/act-secrets.txt`

## Documentation

The documentation below is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs/). Do not make manual changes

Instructions for updating the module's documentation 
- install `terraform-docs` if not installed already `brew install terraform-docs`
- Process update at root level `terraform-docs markdown table --output-file README.md --output-mode inject ./`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.state_machine_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.policy_sfn_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.policy_sfn_statemachine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.policy_sfn_xray_tracing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_for_sfn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.iam_for_sfn_attach_policy_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.iam_for_sfn_attach_policy_statemachine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.iam_for_sfn_attach_policy_xray_tracing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_sfn_state_machine.sfn_state_machine](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine) | resource |
| [aws_iam_policy_document.sfn_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [local_file.iam_policy](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.state_machine_definition](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_log_group_kms_key_arn"></a> [cloudwatch\_log\_group\_kms\_key\_arn](#input\_cloudwatch\_log\_group\_kms\_key\_arn) | The ARN of the KMS Key to use when encrypting log data. | `string` | n/a | yes |
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | The name of the Cloudwatch log group. | `string` | n/a | yes |
| <a name="input_cloudwatch_log_group_retention_days"></a> [cloudwatch\_log\_group\_retention\_days](#input\_cloudwatch\_log\_group\_retention\_days) | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. | `number` | n/a | yes |
| <a name="input_cloudwatch_log_group_tags"></a> [cloudwatch\_log\_group\_tags](#input\_cloudwatch\_log\_group\_tags) | The tags provided by the client module. To be merged with internal tags | `map(string)` | `{}` | no |
| <a name="input_definition_file_name"></a> [definition\_file\_name](#input\_definition\_file\_name) | The name of the file that contains the state machine definition. File should be in JSON format. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to deploy to. | `string` | `"dev"` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name given to the iam role used by the state machine. | `string` | n/a | yes |
| <a name="input_include_execution_data"></a> [include\_execution\_data](#input\_include\_execution\_data) | Determines whether execution data is included in your log. When set to false, data is excluded. | `bool` | n/a | yes |
| <a name="input_logging_configuration_level"></a> [logging\_configuration\_level](#input\_logging\_configuration\_level) | Defines which category of execution history events are logged. Valid values: ALL, ERROR, FATAL, OFF | `string` | n/a | yes |
| <a name="input_policy_file_name"></a> [policy\_file\_name](#input\_policy\_file\_name) | The name of the file that contains the iam policy. File should be in JSON format. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name to be used as a reference in names/tags. | `string` | n/a | yes |
| <a name="input_state_machine_name"></a> [state\_machine\_name](#input\_state\_machine\_name) | The name of the state machine. | `string` | n/a | yes |
| <a name="input_state_machine_tags"></a> [state\_machine\_tags](#input\_state\_machine\_tags) | The tags provided by the client module. To be merged with internal tags | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Determines whether a Standard or Express state machine is created. | `string` | n/a | yes |
| <a name="input_xray_tracing_enabled"></a> [xray\_tracing\_enabled](#input\_xray\_tracing\_enabled) | When set to true, AWS X-Ray tracing is enabled. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->