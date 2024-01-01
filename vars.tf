variable "eks_bot_name" {
  default = "eks_audit_bot"
}


variable "lambda_root" {
  type        = string
  description = "The relative path to the source of the lambda"
  default     = "./function"
}


variable "memory_limit" {
  type        = number
  default     = 256
  description = "memory limit of the lambda"
}
variable "timeout" {
  type        = number
  default     = 60
  description = "Timeout of the lambda"
}

 variable "aws_cloudwatch_log_group" {
  type        = string
  default     = ""
  description = "cloudwatch audit logs groups of EKS cluster"
   
 }
 
 
variable "filter_pattern" {
  type        = string
  default     = ""
  description = "cloudwatch  logs filter pattern"
}

variable "account_id" {
  type        = string
  default     = ""
  description = "AWS account ID"
  
}
variable "account_name" {
  type        = string
  default     = ""
  description = "AWS account name"
  
}

variable "sns_topic_arn" {
  type        = string
  default     = ""
  description = "SNS topic"
  
}