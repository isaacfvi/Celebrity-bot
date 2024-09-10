resource "aws_apigatewayv2_api" "api_gw" {
  name                       = "celebrity-chatbot"
  protocol_type              = "HTTP"

  cors_configuration {
    allow_origins = ["https://${var.website_name}.s3-website-us-east-1.amazonaws.com"]  
    allow_methods = ["POST"]
    allow_headers = ["Content-Type", "Authorization"] 
  }

  tags = var.comum_tags
}

resource "aws_apigatewayv2_integration" "api_gw" {
  api_id           = aws_apigatewayv2_api.api_gw.id
  integration_type = "AWS_PROXY"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.lambda.invoke_arn
    payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "api_gw" {
  api_id    = aws_apigatewayv2_api.api_gw.id
  route_key = "POST /"
  target = "integrations/${aws_apigatewayv2_integration.api_gw.id}"
}

resource "aws_apigatewayv2_stage" "api_gw" {
  api_id = aws_apigatewayv2_api.api_gw.id
  name   = "fun-fact"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn
    
    format = jsonencode({
      requestId        = "$context.requestId",
      httpMethod       = "$context.httpMethod",
      resourcePath     = "$context.resourcePath",
      status           = "$context.status",
      responseLength   = "$context.responseLength",
      integrationError = "$context.integrationErrorMessage"
    })
  }
}