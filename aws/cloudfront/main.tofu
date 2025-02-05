module "common" {
  source = "git@github.com:evoteum/tofu-modules.git//common/vars?ref=main"
}

resource "aws_cloudfront_distribution" "main" {
  enabled     = true
  price_class = var.price_class

  tags = {
    Name        = "${var.project_name}-${var.environment}-distribution"
    Environment = var.environment
  }

  origin {
    domain_name = replace(var.origin_url, "https://", "")
    origin_id   = "primary"

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
    allowed_methods        = var.cloudfront_allowed_methods
    cached_methods         = var.cloudfront_cached_methods
    target_origin_id       = "primary"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
    compress               = true # Enable gzip/Brotli compression
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    # Failover to S3 if App Runner returns 5xx errors
    origin_request_policy_id = aws_cloudfront_origin_request_policy.all_viewer.id

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

    cookies {
      forwarded_values {
        query_string = false
        cookies {
          forward = "none"
        }
      }
    }

    restriction_type = "none"
    restrictions {
      geo_restriction {
        restriction_type = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  name = "${var.project_name}-${var.environment}-all-viewer"
}

resource "aws_cloudfront_origin_request_policy" "all_viewer" {
  name = "${var.project_name}-${var.environment}-all-viewer"

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
  name    = "${var.project_name}-${var.environment}-failover"
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

# Static fallback site
resource "aws_s3_bucket" "static_fallback" {
  bucket = "${var.project_name}-${var.environment}-static-fallback"
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