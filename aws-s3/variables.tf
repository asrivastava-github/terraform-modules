variable "environment" {
  description = "The project environment to be used for naming"
  type        = string
}

variable "acl" {
  description = "The s3 acl whether private or public"
  type        = string
}
