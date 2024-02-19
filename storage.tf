terraform {
  backend "s3" {
    bucket           = "devops-accel-lambda-state3"
    key              = "terraform.tfstate"
    region           = "us-east-1"
    encrypt           = true
    dynamodb_table   = "devops-accel-lambda-dynamodb"
  }
}

