resource "aws_s3_bucket" "ecs-s3" {
  bucket = var.s3_bucket_name
  tags = {
    Name        = "Name"
    Environment = "devops-accel"
  }
}


resource "aws_s3_bucket_versioning" "enable-version" {
  bucket = aws_s3_bucket.ecs-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}


