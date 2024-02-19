variable "lambda_function" {
  type        = map(string)
  description = "The name of the Lambda function"
  default = {
    "MovieApp"    = "function_code_movie"
    "LearningApp" = "function_code_learning"
  }
}

variable "runtime" {
  default = "nodejs18.x"
}

variable "handler" {
  default = "index.handler"
}

variable "lambda_execution_role" {
  type        = string
  description = "lambda execution role"
} #value passed from main

