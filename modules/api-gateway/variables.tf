variable "rest_api_name"{
    type = string
    description = "Name of the API Gateway created"
    default = "terraform-api-gateway"
}

variable "api_gateway_region" {
  type        = string
  description = "The region in which to create/manage resources"
  default = "ap-south-1"
}

variable "api_gateway_account_id" {
 type = string
default = "889796695136"
 }

variable "lambda_functions" {
  type        = map(string)
  description = "List of lambda function"
} //value comes from main.tf

variable "rest_api_stage_name" {
  type        = string
  description = "The name of the API Gateway stage"
  default     = "testing" //add a stage name as per your requirement
}

