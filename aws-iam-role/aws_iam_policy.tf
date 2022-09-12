resource "aws_iam_policy" "default" {
  count       = var.policy_document == false ? 0 : 1
  name        = var.project
  path        = "/"
  description = "Policy for ${var.project} ${var.environment}"
  policy      = var.policy_document
}