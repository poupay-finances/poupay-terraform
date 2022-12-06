module "bucket_desestruturados" {
  source     = "./modules/S3"
  bucketName = format("%s-bucket-desestruturados", var.PROJECT_NAME)
}

module "bucket_semi_estruturados" {
  source     = "./modules/S3"
  bucketName = format("%s-bucket-semi-estruturados", var.PROJECT_NAME)
}

module "bucket_estruturados" {
  source     = "./modules/S3"
  bucketName = format("%s-bucket-estruturados", var.PROJECT_NAME)
}