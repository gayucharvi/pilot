data "archive_file" "lambda_code" {
  for_each    = var.lambda_function
  type        = "zip"
  source_dir  = "${path.module}/${each.value}"
  output_path = "${path.module}/${each.value}.zip"
}

resource "aws_lambda_function" "lambda_function" {
  for_each         = var.lambda_function
  function_name    = each.key
  runtime          = var.runtime
  handler          = var.handler
  source_code_hash = data.archive_file.lambda_code[each.key].output_base64sha256
  role             = var.lambda_execution_role
  filename         = "${path.module}/${each.value}.zip"
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  for_each          = var.lambda_function
  name              = "/aws/lambda/${each.key}/"
  retention_in_days = 30
  tags = {
    name = "devops-accel"
  }
}


