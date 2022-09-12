variable "name" {
  description = "The name for the resource"
}

variable "environment" {
  description = "Used to distinguish between dev and prod infrastructure"
  default     = "XXXX"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be merged with the default tag map"
  default = {
  }
}
