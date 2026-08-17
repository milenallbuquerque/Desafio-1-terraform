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
resource "aws_s3_object" "desafio1_index" {
  bucket       = aws_s3_bucket.frontend_buckets[0].id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "desafio1_script" {
  bucket       = aws_s3_bucket.frontend_buckets[0].id
  key          = "script.js"
  source       = "${path.module}/script.js"
  content_type = "application/javascript"
}

resource "aws_s3_object" "desafio1_style" {
  bucket       = aws_s3_bucket.frontend_buckets[0].id
  key          = "style.css"
  source       = "${path.module}/style.css"
  content_type = "text/css"
}

resource "aws_s3_object" "desafio2_index" {
  bucket       = aws_s3_bucket.frontend_buckets[1].id
  key          = "index.html"
  source       = "${path.module}/../Desafio 2/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "desafio2_style" {
  bucket       = aws_s3_bucket.frontend_buckets[1].id
  key          = "style.css"
  source       = "${path.module}/../Desafio 2/style.css"
  content_type = "text/css"
}

resource "aws_s3_object" "desafio3_index" {
  bucket       = aws_s3_bucket.frontend_buckets[2].id
  key          = "index.html"
  source       = "${path.module}/../Desafio 3/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "desafio3_script" {
  bucket       = aws_s3_bucket.frontend_buckets[2].id
  key          = "script.js"
  source       = "${path.module}/../Desafio 3/script.js"
  content_type = "application/javascript"
}

resource "aws_s3_object" "desafio3_style" {
  bucket       = aws_s3_bucket.frontend_buckets[2].id
  key          = "style.css"
  source       = "${path.module}/../Desafio 3/style.css"
  content_type = "text/css"
}