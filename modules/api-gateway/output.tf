#movielambda
output "rest_api_url_apps" {
  value = {for key, url in aws_api_gateway_deployment.rest_api_deployment_apps : key => "${url.invoke_url}/${key}" }
}




