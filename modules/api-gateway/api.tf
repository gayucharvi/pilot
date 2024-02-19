resource "aws_api_gateway_rest_api" "rest_api"{
    name = var.rest_api_name
}

resource "aws_api_gateway_resource" "rest_api_apps" {
  for_each = var.lambda_functions
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part = each.key
}

resource "aws_api_gateway_method" "rest_api_get_method_apps"{
  for_each = var.lambda_functions
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_apps[each.key].id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "rest_api_get_method_integration_apps" {
  for_each = var.lambda_functions
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.rest_api_apps[each.key].id
  http_method             = aws_api_gateway_method.rest_api_get_method_apps[each.key].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = each.value
}

resource "aws_api_gateway_method_response" "rest_api_get_method_response_200" {
  for_each = var.lambda_functions
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.rest_api_apps[each.key].id
  http_method = aws_api_gateway_method.rest_api_get_method_apps[each.key].http_method
  status_code = "200"
}

//  Creating a lambda resource based policy to allow API gateway to invoke the lambda function:
resource "aws_lambda_permission" "api_gateway_lambda_apps" {
  for_each = var.lambda_functions
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = each.key
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.api_gateway_region}:${var.api_gateway_account_id}:${aws_api_gateway_rest_api.rest_api.id}/*/${aws_api_gateway_method.rest_api_get_method_apps[each.key].http_method}${aws_api_gateway_resource.rest_api_apps[each.key].path}"
}

resource "aws_api_gateway_deployment" "rest_api_deployment_apps" {
  for_each = var.lambda_functions
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name    = var.rest_api_stage_name
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.rest_api_apps[each.key].id,
      aws_api_gateway_method.rest_api_get_method_apps[each.key].id,
      aws_api_gateway_integration.rest_api_get_method_integration_apps[each.key].id
    ]))
  }
}


