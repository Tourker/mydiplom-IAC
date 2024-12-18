terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket = "tfstate-bucket-diplom"
    region = "ru-central1"
    key    = "state/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    #skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    #skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = "ru-central1-b"
  service_account_key_file = file("./key.json")
}