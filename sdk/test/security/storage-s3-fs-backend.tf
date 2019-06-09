module "buckets3-backend" {
  source = "../modules/fileserver/core/bucket-s3"

  namespace = var.namespace
  #partition-key = "default-fileserver-bucket-mock-${random_integer.priority.id}"
  partition-key = "default-backend-storage-${random_integer.value.id}"
  tags = var.tags

}

output "buckets3"{
  value = module.buckets3-backend
}