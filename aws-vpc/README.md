<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_role_vpc_flow_log"></a> [iam\_role\_vpc\_flow\_log](#module\_iam\_role\_vpc\_flow\_log) | ../aws-iam-role | n/a |
| <a name="module_tags"></a> [tags](#module\_tags) | ../aws-tags | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.flow_log_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_default_route_table.default_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_flow_log.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_network_acl.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_route53_resolver_rule_association.rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.private_dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.private_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_iam_policy_document.flow_log_cloudwatch_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpc_flow_log_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_resolver_rules.ruledetails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_rules) | data source |
| [aws_subnet.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc_endpoint_service.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |
| [aws_vpc_endpoint_service.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |
| [aws_vpc_endpoint_service.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | The availability zones that demo VPC should create subnets in. | `list(string)` | n/a | yes |
| <a name="input_disable_serverless_nacl"></a> [disable\_serverless\_nacl](#input\_disable\_serverless\_nacl) | Disable creation of NACL with serverless rules. | `bool` | `true` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable DNS hostname support in demo VPC. | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support in demo VPC. | `bool` | `true` | no |
| <a name="input_enable_dynamodb_vpc_endpoint"></a> [enable\_dynamodb\_vpc\_endpoint](#input\_enable\_dynamodb\_vpc\_endpoint) | Enable gateway endpoint for AWS Dynamo DB service. | `bool` | `false` | no |
| <a name="input_enable_s3_vpc_endpoint"></a> [enable\_s3\_vpc\_endpoint](#input\_enable\_s3\_vpc\_endpoint) | Enable gateway endpoint for AWS S3 service. | `bool` | `false` | no |
| <a name="input_enable_ssm_vpc_endpoint"></a> [enable\_ssm\_vpc\_endpoint](#input\_enable\_ssm\_vpc\_endpoint) | Enable interface endpoint for AWS Systems Manager service. | `bool` | `false` | no |
| <a name="input_enable_ssm_vpc_endpoint_private_dns"></a> [enable\_ssm\_vpc\_endpoint\_private\_dns](#input\_enable\_ssm\_vpc\_endpoint\_private\_dns) | Enable private DNS for the interface endpoint for AWS Systems Manager service. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The project environment to be used for naming | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnet CIDR ranges. | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project to be used for naming | `string` | n/a | yes |
| <a name="input_ssm_vpc_endpoint_security_group_ids"></a> [ssm\_vpc\_endpoint\_security\_group\_ids](#input\_ssm\_vpc\_endpoint\_security\_group\_ids) | The ID's of security groups that should be associated with network interface for the interface endpoint | `list(string)` | `[]` | no |
| <a name="input_tags_override"></a> [tags\_override](#input\_tags\_override) | A custom map of tags to override default tags. | `map(string)` | `{}` | no |
| <a name="input_transit_account_id"></a> [transit\_account\_id](#input\_transit\_account\_id) | Transit Gateway ID, used for creating R53 resolver rules | `string` | `""` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block of the VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_vpc_endpoint_dynamodb"></a> [aws\_vpc\_endpoint\_dynamodb](#output\_aws\_vpc\_endpoint\_dynamodb) | ID of the dynamodb VPC endpoint |
| <a name="output_aws_vpc_endpoint_s3"></a> [aws\_vpc\_endpoint\_s3](#output\_aws\_vpc\_endpoint\_s3) | ID of the S3 VPC endpoint |
| <a name="output_aws_vpc_endpoint_ssm"></a> [aws\_vpc\_endpoint\_ssm](#output\_aws\_vpc\_endpoint\_ssm) | ID of the SSM VPC endpoint |
| <a name="output_private_route_table"></a> [private\_route\_table](#output\_private\_route\_table) | ID of the private route table |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of private subnets |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The VPC ARN |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
