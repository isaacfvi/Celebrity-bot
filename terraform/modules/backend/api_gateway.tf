resource "aws_apigatewayv2_api" "api_gw" {
  name                       = "celebrity-chatbot"
  protocol_type              = "HTTP"

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
}