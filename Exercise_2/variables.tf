# TODO: Define the variable for aws_region
variable "aws_region" {
  type        = string
  description = "the aws region to be used in the project"
  default     = "us-east-1"

}
variable "lambda_function_name" {
  type        = string
  description = "udacity 2nd project"
  default     = "greet_lambda"

}
