resource "yandex_vpc_network" "net" {
  name = var.vpc_name
}

#resource "yandex_vpc_subnet" "public" {
#  name           = "public"
#  zone           = "ru-central1-b"
#  network_id     = yandex_vpc_network.net.id
#  v4_cidr_blocks = ["192.168.1.0/24"]
#
#}

resource "yandex_vpc_subnet" "private-a" {
  name           = "private-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.2.0/24"]
#  route_table_id = yandex_vpc_route_table.nat-route.id
}

resource "yandex_vpc_subnet" "private-b" {
  name           = "private-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.3.0/24"]
#  route_table_id = yandex_vpc_route_table.nat-route.id
}

resource "yandex_vpc_subnet" "private-d" {
  name           = "private-d"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.4.0/24"]
#  route_table_id = yandex_vpc_route_table.nat-route.id
}

#resource "yandex_vpc_route_table" "nat-route" {
#  name       = "nat-route"
#  network_id = yandex_vpc_network.net.id
#  static_route {
#    destination_prefix = "0.0.0.0/0"
#    next_hop_address   = "192.168.1.254"
#  }
#}