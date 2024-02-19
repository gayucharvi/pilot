output "lambda_functions" {
  value = { for n, a in aws_lambda_function.lambda_function : n => a.invoke_arn }
}


