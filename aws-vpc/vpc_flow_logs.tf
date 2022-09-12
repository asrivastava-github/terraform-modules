resource "aws_flow_log" "vpc" {
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.flow_log_vpc.arn
  iam_role_arn         = module.iam_role_vpc_flow_log.arn
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.demo.id
}

resource "aws_cloudwatch_log_group" "flow_log_vpc" {
  name              = "/${aws_vpc.demo.id}/"
  retention_in_days = 365
}

module "iam_role_vpc_flow_log" {
  source               = "../aws-iam-role"
  policy_document      = data.aws_iam_policy_document.vpc_flow_log_cloudwatch.json
  service_principals   = ["vpc-flow-logs.amazonaws.com"]
  assume_role_policy   = data.aws_iam_policy_document.flow_log_cloudwatch_assume_role.json
}

data "aws_iam_policy_document" "flow_log_cloudwatch_assume_role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    effect = "Allow"

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "vpc_flow_log_cloudwatch" {
  statement {
    sid = "AWSVPCFlowLogsPushToCloudWatch"

    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]
    resources = ["*"]
  }
}