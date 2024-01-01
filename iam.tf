########################################
### IAM Policies #######################
########################################

resource "aws_iam_policy" "eks_audit_logs_bot" {
  name   = var.eks_bot_name
  path   = "/"
  policy = <<-POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource": "arn:aws:logs:*:*:*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "sns:Publish"
          ],
          "Resource": "*"
        }
      ]
    }
  POLICY

}




########################################
### IAM Roles ##########################
########################################

resource "aws_iam_role" "eks_audit_logs_bot" {
    name = var.eks_bot_name

    assume_role_policy = <<-POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "lambda.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    POLICY
}

########################################
### IAM Policy Attachments #############
########################################

resource "aws_iam_role_policy_attachment" "eks_audit_logs_bot" {
    role        = aws_iam_role.eks_audit_logs_bot.name
    policy_arn  = aws_iam_policy.eks_audit_logs_bot.arn
}

