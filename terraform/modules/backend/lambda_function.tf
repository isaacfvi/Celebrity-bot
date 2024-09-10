data "archive_file" "lambda" {
  type        = "zip"
  source_dir = var.lambda_path
  output_path = "./zip/lambda_function_payload.zip"
}

resource "aws_lambda_function" "lambda" {
  filename      = "./zip/lambda_function_payload.zip"
  function_name = "lambda_celebrity_project"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"

  tags = var.comum_tags

}

resource "aws_lambda_permission" "api_gw" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.api_gw.execution_arn}/*/*"
}