variable "project" {
  description = "The project to be used for naming"
  type        = string
}

variable "environment" {
  description = "The project environment to be used for naming"
  type        = string
}

variable "transit_account_id" {
  type        = string
  description = "Transit Gateway ID, used for creating R53 resolver rules"
  default     = ""
}

variable "azs" {
  description = "The availability zones that this VPC should create subnets in."
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  type        = string
}

variable "private_subnets" {
  description = "The private subnet CIDR ranges."
  type        = list(string)
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostname support in this VPC."
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in this VPC."
  type        = bool
  default     = true
}

variable "enable_s3_vpc_endpoint" {
  description = "Enable gateway endpoint for AWS S3 service."
  type        = bool
  default     = false
}

variable "enable_dynamodb_vpc_endpoint" {
  description = "Enable gateway endpoint for AWS Dynamo DB service."
  type        = bool
  default     = false
}

variable "enable_ssm_vpc_endpoint" {
  description = "Enable interface endpoint for AWS Systems Manager service."
  type        = bool
  default     = false
}

variable "enable_ssm_vpc_endpoint_private_dns" {
  description = "Enable private DNS for the interface endpoint for AWS Systems Manager service."
  type        = bool
  default     = false
}

variable "disable_serverless_nacl" {
  description = "Disable creation of NACL with serverless rules."
  type        = bool
  default     = true
}

variable "ssm_vpc_endpoint_security_group_ids" {
  description = "The ID's of security groups that should be associated with network interface for the interface endpoint"
  type        = list(string)
  default     = []
}
