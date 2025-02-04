resource "aws_apprunner_service" "service" {
  service_name = "${var.project_name}-service"

  source_configuration {
    image_repository {
      image_configuration {
        port = "8080"
        runtime_environment_variables = {
          "AWS_REGION" = var.aws_region
        }
      }
      image_identifier      = var.container_image
      image_repository_type = "ECR_PUBLIC"
    }
    auto_deployments_enabled = true
  }

  instance_configuration {
    cpu               = "1024"
    memory            = "2048"
    instance_role_arn = aws_iam_role.app_runner.arn
  }

  health_check_configuration {
    path = "/health"
  }
}

# Static fallback site
resource "aws_s3_bucket" "static_fallback" {
  bucket = "${var.project_name}-static-fallback"
}

resource "aws_s3_bucket_website_configuration" "static_fallback" {
  bucket = aws_s3_bucket.static_fallback.id

  index_document {
    suffix = "loading.html"
  }
}

resource "aws_s3_object" "loading_page" {
  bucket       = aws_s3_bucket.static_fallback.id
  key          = "loading.html"
  source       = "${path.module}/static/loading.html"
  content_type = "text/html"
}

resource "aws_cloudfront_distribution" "app" {
  enabled = true

  origin {
    domain_name = replace(aws_apprunner_service.service.service_url, "https://", "")
    origin_id   = "apprunner"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  origin {
    domain_name = aws_s3_bucket.static_fallback.bucket_regional_domain_name
    origin_id   = "s3-fallback"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "apprunner"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    origin_request_policy_id = aws_cloudfront_origin_request_policy.all_viewer.id

    # Failover to S3 if App Runner returns 5xx errors
    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.failover.arn
    }
  }

  # Fallback behavior for S3
  ordered_cache_behavior {
    path_pattern           = "/static/*"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "s3-fallback"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_request_policy" "all_viewer" {
  name = "${var.project_name}-all-viewer"

  cookies_config {
    cookie_behavior = "all"
  }
  headers_config {
    header_behavior = "allViewer"
  }
  query_strings_config {
    query_string_behavior = "all"
  }
}

resource "aws_cloudfront_function" "failover" {
  name    = "${var.project_name}-failover"
  runtime = "cloudfront-js-1.0"
  code    = <<-EOT
    function handler(event) {
      var response = event.response;
      if (response.statusCode >= 500) {
        var request = event.request;
        request.origin = {
          s3: {
            domainName: "${aws_s3_bucket.static_fallback.bucket_regional_domain_name}",
            path: "/loading.html"
          }
        };
        return request;
      }
      return response;
    }
  EOT
}

# IAM role for App Runner
resource "aws_iam_role" "app_runner" {
  name = "${var.project_name}-app-runner-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "tasks.apprunner.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "dynamodb" {
  name = "${var.project_name}-dynamodb-policy"
  role = aws_iam_role_policy.app_runner.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem",
        "dynamodb:Scan",
        "dynamodb:Query"
      ]
      Resource = [
        var.events_table_arn,
        var.questions_table_arn
      ]
    }]
  })
}