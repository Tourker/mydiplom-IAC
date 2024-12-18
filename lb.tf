resource "yandex_lb_target_group" "workers-group" {
  name       = "workers-group"
  depends_on = [yandex_compute_instance_group.workers-nodes]
  dynamic "target" {
    for_each = yandex_compute_instance_group.workers-nodes.instances
    content { 
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "nlb-workers" {
  name = "nlb-workes"
  listener {
    name        = "app-listener"
    port        = 80
    target_port = 31080
    external_address_spec {
      ip_version = "ipv4"
    }
  } 

  listener {
    name        = "grafana-listener"
    port        = 3000
    target_port = 31000
    external_address_spec {
      ip_version = "ipv4"
    }
  }


  attached_target_group {
    target_group_id = yandex_lb_target_group.workers-group.id
    healthcheck {
      name = "healthcheck-workers"
      tcp_options {
        port = 31080
      }
    }
  }
}


resource "yandex_lb_network_load_balancer" "nlb-masters" {
  name = "nlb-masters"
  listener {
    name        = "masters-listener"
    port        = 16443
    target_port = 6443
    external_address_spec {
      ip_version = "ipv4"
    }
  }


  attached_target_group {
    target_group_id = yandex_compute_instance_group.master-nodes.load_balancer.0.target_group_id
    healthcheck {
      name = "healthcheck-workers"
      tcp_options {
        port = 6443
      }
    }
  }
}