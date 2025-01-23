resource "openstack_compute_instance_v2" "nodes" {
  for_each = toset(var.nodes)

  name       = each.value
  image_name      = "Ubuntu 22.04"
  flavor_name     = "SCS-8V-16-50"
  key_pair        = "Hergemoeller"
  security_groups = ["default", "ssh", "http/s"]
  config_drive    = true
  user_data = file("cloudconfig/default.yaml")
  network {
    name = "hergemoeller_net"
  }
}
