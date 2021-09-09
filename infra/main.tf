provider "aws" {
  region = var.region
  profile = var.aws_profile
}

terraform {
  required_version = ">= 1.0.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.57"
    }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<-EOF
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

resource "aws_lambda_function" "rust_lambda" {
  function_name = "rust_lambda"
  filename      = "../lambda.zip"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "doesnt.matter"
  source_code_hash = filebase64sha256("../lambda.zip")
  runtime = "provided"

  environment {
    variables = {
      RUST_BACKTRACE = "1"
    }
  }
}
