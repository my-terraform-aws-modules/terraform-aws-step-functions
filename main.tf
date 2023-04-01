provider "aws" {
  region = var.region 
}
// Create state machine
resource "aws_sfn_state_machine" "sfn_state_machine" {
  count = var.create_sfn ? 1 : 0
  name       = "${var.environment}-${var.state_machine_name}"
  role_arn   = var.create_sfn_role ? aws_iam_role.iam_for_sfn.arn : var.custom_sfn_role 
  definition = var.step_function_defination
  /* example of defination file
  definition = <<EOF
{
  "Comment": "A Hello World example of the Amazon States Language using Pass states",
  "StartAt": "Hello",
  "States": {
    "Hello": {
      "Type": "Pass",
      "Result": "Hello",
      "Next": "World"
    },
    "World": {
      "Type": "Pass",
      "Result": "World",
      "End": true
    }
  }
}
EOF
*/
  type       = upper(var.type)
  logging_configuration {
    log_destination        = "${aws_cloudwatch_log_group.state_machine_log_group.arn}:*"
    include_execution_data = var.include_execution_data
    level                  = upper(var.logging_configuration_level)

  }
  tags = var.state_machine_tags
  tracing_configuration {
    enabled = var.xray_tracing_enabled
  }
}

// Create log group for state machine
resource "aws_cloudwatch_log_group" "state_machine_log_group" {
  name              = var.cloudwatch_log_group_name
  tags              = var.cloudwatch_log_group_tags
  #kms_key_id        = var.enable_sfn_encyption ? var.cloudwatch_log_group_kms_key_arn : 0
  retention_in_days = var.cloudwatch_log_group_retention_days
}

// Create states assume role policy
data "aws_iam_policy_document" "sfn_assume_policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["states.eu-west-1.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

// Create IAM role for state machine
resource "aws_iam_role" "iam_for_sfn" {
  count = var.create_sfn_role ? 1 :0
  name               = "${var.sfn_iam_role_name}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.sfn_assume_policy.json
}

// Create policies for cloudwatch logging and state machine use
resource "aws_iam_policy" "policy_sfn_logging" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogDelivery",
                "logs:GetLogDelivery",
                "logs:UpdateLogDelivery",
                "logs:DeleteLogDelivery",
                "logs:ListLogDeliveries",
                "logs:PutLogEvents",
                "logs:PutResourcePolicy",
                "logs:DescribeResourcePolicies",
                "logs:DescribeLogGroups"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "policy_sfn_statemachine" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "states:StartExecution",
                "states:DescribeExecution",
                "states:StopExecution",
                "states:ListExecution"
            ],
            "Resource": "${aws_sfn_state_machine.sfn_state_machine[0].arn}",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "policy_sfn_xray_tracing" {
  count  = var.xray_tracing_enabled ? 1 : 0
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "xray:PutTraceSegments",
                "xray:PutTelemetryRecords",
                "xray:GetSamplingRules",
                "xray:GetSamplingTargets"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

// Attach policies to IAM Role for Step Function
resource "aws_iam_role_policy_attachment" "iam_for_sfn_attach_policy_cloudwatch" {
  role       = aws_iam_role.iam_for_sfn.name
  policy_arn = aws_iam_policy.policy_sfn_logging.arn
}

resource "aws_iam_role_policy_attachment" "iam_for_sfn_attach_policy_statemachine" {
  role       = aws_iam_role.iam_for_sfn.name
  policy_arn = aws_iam_policy.policy_sfn_statemachine.arn
}

resource "aws_iam_role_policy_attachment" "iam_for_sfn_attach_policy_xray_tracing" {
  count      = var.xray_tracing_enabled ? 1 : 0
  role       = aws_iam_role.iam_for_sfn.name
  policy_arn = aws_iam_policy.policy_sfn_xray_tracing[0].arn
}