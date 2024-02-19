provider "aws" {
    region = "us-east-1"
}

module "iam_role" {
  source = "./modules/IAM"
}

module "lambda" {
  source = "./modules/lambda"
  lambda_execution_role = module.iam_role.lambda_execution_role
  depends_on = [
    module.iam_role
  ]
}

module "api_gateway" {
  source = "./modules/api-gateway"
  lambda_functions = module.lambda.lambda_functions 
  depends_on = [
    module.lambda
  ]
}

module "Cloudwatch" {
  source = "./modules/Cloudwatch"
}
