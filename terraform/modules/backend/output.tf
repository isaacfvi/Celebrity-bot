output "api_url" {
  value       = aws_apigatewayv2_stage.api_gw.invoke_url
  description = "URL para celebrity-bot-api"
}