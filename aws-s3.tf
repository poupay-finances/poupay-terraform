module "bucket_desestruturados" {
  source     = "./modules/S3"
  bucketName = format("%s-bucket-desestruturados", var.projectName)
}

module "bucket_semi_estruturado" {
  source     = "./modules/S3"
  bucketName = format("%s-bucket-semi-estruturados", var.projectName)
}

module "bucket_estruturados" {
  source     = "./modules/S3"
  bucketName = format("%s-bucket-estruturados", var.projectName)
}