########################################
### Lambda Function ###################
########################################

# eks_audit_logs_bot
####################
resource "aws_lambda_function" "lambda-audit-logs" {
  filename         = data.archive_file.lambda_source.output_path
  source_code_hash = data.archive_file.lambda_source.output_base64sha256

  function_name   = var.eks_bot_name
  role            = aws_iam_role.eks_audit_logs_bot.arn
  handler         = "lambda-audit-logs.lambda_handler"
  runtime         = "python3.9"
  memory_size     = var.memory_limit
  timeout         = var.timeout

  environment {
    variables   = {
      ACCOUNT_ID            = var.account_id
      ACCOUNT_NAME          = var.account_name
      ACCOUNT_ID            = var.account_id
      ACCOUNT_NAME          = var.account_name
      SNS_TOPIC_ARN        = var.sns_topic_arn

  
    }
  }
  depends_on = [
    data.archive_file.lambda_source,
    aws_cloudwatch_log_group.lambda-log-group
  ]

  
}


resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    command = "pip install -r ${var.lambda_root}/requirements.txt -t ${var.lambda_root}/"
  }
  
  triggers = {
    dependencies_versions = filemd5("${var.lambda_root}/requirements.txt")
    source_versions = filemd5("${var.lambda_root}/lambda-audit-logs.py")
  }
}

resource "random_uuid" "lambda_src_hash" {
  keepers = {
    for filename in setunion(
      fileset(var.lambda_root, "lambda-audit-logs.py"),
      fileset(var.lambda_root, "requirements.txt")
    ):
        filename => filemd5("${var.lambda_root}/${filename}")
  }
}

data "archive_file" "lambda_source" {
  depends_on = [null_resource.install_dependencies]
  excludes   = [
    "__pycache__",
    "venv",
  ]

  source_dir  = var.lambda_root
  output_path = "${random_uuid.lambda_src_hash.result}.zip"
  type        = "zip"
}


#
# Logging
#
resource "aws_cloudwatch_log_group" "lambda-log-group" {
  name              = "/aws/lambda/${var.eks_bot_name}"
  retention_in_days = 14
}

resource "aws_lambda_permission" "allow_cloudwatch" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda-audit-logs.function_name
    principal     = "logs.eu-west-1.amazonaws.com"
    source_arn = "arn:aws:logs:eu-west-1:${var.account_id}:log-group:${var.aws_cloudwatch_log_group}:*"
}


resource "aws_cloudwatch_log_subscription_filter" "logging" {
  depends_on      = [aws_lambda_permission.allow_cloudwatch]
  destination_arn = aws_lambda_function.lambda-audit-logs.arn
  filter_pattern  = var.filter_pattern
  log_group_name  = var.aws_cloudwatch_log_group
  name            = var.eks_bot_name
}
