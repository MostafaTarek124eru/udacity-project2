# TODO: Define the output variable for the lambda function.
output "lambda_function_arn" {
  value = aws_lambda_function.lambda_greet.arn

}
output "function_invoke_arn" {
  description = "The Invoke ARN of the Lambda function"
  value       = join("", aws_lambda_function.lambda_greet.*.invoke_arn)
}

output "function_name" {
  description = "The name of the Lambda function"
  value       = join("", aws_lambda_function.lambda_greet.*.function_name)
}

