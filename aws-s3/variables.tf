variable "environment" {
  description = "The project environment to be used for naming"
  type        = string
}

variable "acl" {
  description = "The s3 acl whether private or public"
  type        = string
}

variable "bucket_name" {
  description = "name of s3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Whether to destroy s3 bucket even if it got objects in it"
  type        = bool
}
