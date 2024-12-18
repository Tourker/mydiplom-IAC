resource "local_file" "inventory_yml" {
  depends_on = [
    yandex_compute_instance_group.master-nodes,
    yandex_compute_instance_group.workers-nodes,
  ]
   content = templatefile("${path.module}/inventory.tftpl", { master-nodes = yandex_compute_instance_group.master-nodes.instances, workers-nodes = yandex_compute_instance_group.workers-nodes.instances })
  filename = "${path.module}/ansible/inventory.yml"
}

resource "local_file" "hosts_yml" {
  depends_on = [
    yandex_compute_instance_group.master-nodes,
    yandex_compute_instance_group.workers-nodes,
  ]
   content = templatefile("${path.module}/hosts.tftpl", { master-nodes = yandex_compute_instance_group.master-nodes.instances })  
  filename = "${path.module}/ansible/inventory/hosts.yml"
}