resource "aws_api_gateway_rest_api" "api" {
  name               = "api-azure-aws"
  description        = "Integração entre azure e aws"
  binary_media_types = ["application/json"]
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "resource_bucket" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "{bucket}"

  depends_on = [
    aws_api_gateway_rest_api.api
  ]
}

resource "aws_api_gateway_resource" "resource_filename" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.resource_bucket.id
  path_part   = "{filename}"

  depends_on = [
    aws_api_gateway_resource.resource_bucket
  ]
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_filename.id
  http_method   = "PUT"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.bucket" : true,
    "method.request.path.filename" : true
  }

  depends_on = [
    aws_api_gateway_resource.resource_filename
  ]
}

resource "aws_api_gateway_method_response" "method_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource_filename.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"
  response_models = {
    "application/json" : "Empty"
  }

  depends_on = [
    aws_api_gateway_method.method
  ]
}

data "aws_iam_role" "iam_role" {
  name = "LabRole"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource_filename.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "PUT"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.AVAILABILITY_ZONE}:s3:path/{bucket}/{key}"
  credentials             = data.aws_iam_role.iam_role.arn

  request_parameters = {
    "integration.request.path.bucket" : "method.request.path.bucket",
    "integration.request.path.key" : "method.request.path.filename"
  }

  depends_on = [
    aws_api_gateway_method.method
  ]
}

resource "aws_api_gateway_integration_response" "integration_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource_filename.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"

  depends_on = [
    aws_api_gateway_method.method
  ]
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  depends_on = [
    aws_api_gateway_method.method
  ]
}

resource "aws_api_gateway_stage" "stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "dev"
  deployment_id = aws_api_gateway_deployment.deployment.id

  depends_on = [
    aws_api_gateway_deployment.deployment
  ]
}