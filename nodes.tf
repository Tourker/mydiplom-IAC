data "yandex_compute_image" "ubuntu" {
  family = var.vm_compute_image
}

resource "yandex_compute_instance_group" "workers-nodes" {
  name                = "workers-nodes"
  folder_id           = var.folder_id
  service_account_id  = var.account_id
  deletion_protection = false
  instance_template {
    name = "worker-{instance.index}"
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "${data.yandex_compute_image.ubuntu.id}"
        size     = 10
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.net.id}"
      subnet_ids = ["${yandex_vpc_subnet.private-a.id}","${yandex_vpc_subnet.private-b.id}","${yandex_vpc_subnet.private-d.id}"]
      nat = "true"
    }
    metadata = {
      user-data = "${file("cloud-init.yaml")}"
    }

    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
  }
  deploy_policy {
    max_creating = 3
    max_unavailable = 1
    max_expansion = 1
   }
}

resource "yandex_compute_instance_group" "master-nodes" {
  name                = "master-nodes"
  folder_id           = var.folder_id
  service_account_id  = var.account_id
  deletion_protection = false
  instance_template {
    platform_id = "standard-v3"
    name = "master-{instance.index}"
    resources {
      memory = 4
      cores  = 4
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "${data.yandex_compute_image.ubuntu.id}"
        size     = 10
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.net.id}"
      subnet_ids = ["${yandex_vpc_subnet.private-a.id}","${yandex_vpc_subnet.private-b.id}","${yandex_vpc_subnet.private-d.id}"]
      nat = "true"
    }
    metadata = {
      user-data = "${file("cloud-init.yaml")}"
     }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    zones = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
  }

  deploy_policy {
    max_creating = 2
    max_unavailable = 1
    max_expansion = 1
   }

   load_balancer {
    target_group_name        = "target-masters-group"
    target_group_description = "Network Load Balancer"
  }
}