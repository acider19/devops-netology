#создаем облачную сеть
resource "yandex_vpc_network" "test" {
  name = "test-vpc"
}

#создаем подсеть zone A
resource "yandex_vpc_subnet" "test_a" {
  name           = "test-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.test.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu_2204_lts" {
  family = "ubuntu-2204-lts"
}

# ВМ
resource "yandex_compute_instance" "test" {
  name        = "test" #Имя ВМ в облачной консоли
  hostname    = "test" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-a" #зона ВМ должна совпадать с зоной subnet!!!

  resources {
    cores         = var.comp_res.cores
    memory        = var.comp_res.memory
    core_fraction = var.comp_res.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.test_a.id #зона ВМ должна совпадать с зоной subnet!!!
    nat       = true
  }
}

resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = true
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "test"
  ports {
    internal = 3306
    external = 3306
    ip       = "127.0.0.1"
  }
  env = ["MYSQL_ROOT_PASSWORD = ${random_password.random_string1.result}",
    "MYSQL_DATABASE  = wordpress",
    "MYSQL_USER      = wordpress",
    "MYSQL_PASSWORD  = ${random_password.random_string2.result}",
    "MYSQL_ROOT_HOST = '%'"
  ]
}

resource "random_password" "random_string1" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "random_string2" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}
