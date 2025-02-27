resource "openstack_compute_instance_v2" "nodes" {
  for_each = toset(var.nodes)
  name            = format("hergemoeller-%s", each.value) # Add prefix to name
  image_name      = "Ubuntu 22.04"
  flavor_name     = "SCS-8V-16-50"
  key_pair        = "Hergemoeller"
  security_groups = ["default", "ssh", "http/s"]
  config_drive    = true
  force_delete    = true
  user_data = file("cloudconfig/root.yaml")
  network {
    name = "hergemoeller_net"
  }
}
