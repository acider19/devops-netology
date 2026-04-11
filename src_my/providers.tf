terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.129.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.1.0"
    }
  }

  required_version = ">=0.13"
}

provider "yandex" {
  # token                    = "do not use!!!"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = file("~/.authorized_key.json")
}

provider "docker" {
  host = "ssh://${var.vm_user}@${yandex_compute_instance.test.network_interface[0].nat_ip_address}"
}
