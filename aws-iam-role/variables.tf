variable "policy_document" {
  type    = bool
  default = false
}

variable "project" {
  type    = string
  default = ""
}

variable "assume_role_policy" {
  type    = string
  default = ""
}

variable "service_principals" {
  type    = list(string)
  default = []
}

variable "aws_principals" {
  type    = list(string)
  default = []
}

variable "managed_policies" {
  type    = list(string)
  default = []
}

variable "max_session_duration" {
  description = "The maximum session duration (in seconds) that you want to set for the specified role. This setting can have a value from 1 hour to 12 hours"
  type        = number
  default     = 3600
}
