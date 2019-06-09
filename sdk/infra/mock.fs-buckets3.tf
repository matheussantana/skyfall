module "buckets3-backend" {
  source = "../modules/fileserver/core/bucket-s3"

  namespace = var.namespace
  partition-key = "s3-fileserver-mock"
  tags = var.tags

}

output "buckets3"{
  value = module.buckets3-backend
}