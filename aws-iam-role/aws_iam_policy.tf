resource "aws_iam_policy" "default" {
  count       = var.policy_document == false ? 0 : 1
  name        = var.policy_name
  path        = "/"
  description = "Policy for ${var.project} ${var.environment} ${var.service}"
  policy      = var.policy_document
  tags        = merge(module.tags.tags, { "Name" : var.policy_name })
}