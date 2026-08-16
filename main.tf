terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://s3.localhost.localstack.cloud:4566"
  }
}

locals {
  frontends = [
    "app-frontend-vendas",
    "app-frontend-admin",
    "app-frontend-cliente"
  ]
}

resource "aws_s3_bucket" "frontend_buckets" {
  count  = length(local.frontends)
  bucket = local.frontends[count.index]
}

resource "aws_s3_bucket_website_configuration" "frontend_website" {
  count  = length(local.frontends)
  bucket = aws_s3_bucket.frontend_buckets[count.index].id

  index_document {
    suffix = "index.html"
  }
}