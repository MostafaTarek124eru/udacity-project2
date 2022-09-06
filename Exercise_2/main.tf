provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["C:/Users/mosta/.aws/credentials"]

}

resource "aws_iam_role" "iam_lambda" {
  name               = "iam_lambda"
  assume_role_policy = <<EOF
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
EOF


}

resource "aws_iam_policy" "lambda_log" {
  name        = "lambda_log"
  path        = "/"
  description = "IAM policy to log from lambda"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_lambda.name
  policy_arn = aws_iam_policy.lambda_log.arn


}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 3

}


resource "aws_lambda_function" "lambda_greet" {
  description      = "simple greeting from lambda from tf"
  role             = aws_iam_role.iam_lambda.arn
  filename         = "code.zip"
  function_name    = var.lambda_function_name
  handler          = "${var.lambda_function_name}.lambda_handler"
  source_code_hash = filebase64sha256("code.zip")
  runtime          = "python3.9"
  environment {
    variables = {
      greeting = "HEY"
    }
  }
  depends_on = [
    aws_cloudwatch_log_group.lambda_log_group, aws_iam_role_policy_attachment.lambda_logs
  ]
}
