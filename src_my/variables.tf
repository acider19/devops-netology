# идентификатор облака в Yandex Cloud
variable "cloud_id" {
  type      = string
  sensitive = true
}

# идентификатор каталога в облаке в Yandex Cloud
variable "folder_id" {
  type      = string
  sensitive = true
}

# набор значений для вычислительных ресурсов для "обычной" ВМ
variable "comp_res" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

variable "vm_user" {
  type      = string
  sensitive = true
}
