# aws-tags

# Module `./aws-tags`

Core Version Constraints:
* `>= 0.12.3`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# Terraform :: Tags

This repository includes terraform module for tags in order to make tags standardised for all resources that is being created
by terraform.

## Usage

Please refer to [test](tests/) section.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.3 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Used to distinguish between dev and prod infrastructure | `string` | `"XXXX"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be merged with the default tag map | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3objtags"></a> [s3objtags](#output\_s3objtags) | Map of tags |
| <a name="output_tags"></a> [tags](#output\_tags) | Map of tags |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
