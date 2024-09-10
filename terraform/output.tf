output "website_url" {
  value       = module.frontend.website_url
  description = "URL para celebrity-bot"
}

output "api_url" {
  value       = module.backend.api_url
  description = "URL para celebrity-bot-api"
}