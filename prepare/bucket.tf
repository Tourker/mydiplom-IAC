resource "yandex_storage_bucket" "tfstate-bucket-diplom" {
  default_storage_class = "STANDARD"
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = "tfstate-bucket-diplom"
  force_destroy = true
}