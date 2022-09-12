resource "aws_iam_role" "default" {
  name                  = var.role_name
  assume_role_policy    = var.assume_role_policy == "" ? data.aws_iam_policy_document.assume_role_policy.json : var.assume_role_policy
  tags                  = module.tags.tags
  force_detach_policies = true
  max_session_duration  = var.max_session_duration
}