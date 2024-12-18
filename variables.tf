###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}
variable "secret_key" {
  type        = string
  default     = ""
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}
variable "access_key" {
  type        = string
  default     = ""
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

# infrastructure
variable "account_id" {
  type        = string
  default     = ""
  description = "VM image Ubuntu"
}

variable "vpc_name" {
  type        = string
  default     = "net"
  description = "VPC network name"
}
variable "vm_compute_image" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "VM image Ubuntu"
}