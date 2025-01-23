resource "openstack_compute_instance_v2" "k3s-master" {
  name            = "hergemoeller-k3s-master"
  image_name      = "Ubuntu 22.04"
  flavor_name     = "SCS-8V-16-50"
  key_pair        = "Hergemoeller"
  security_groups = ["default", "ssh", "http/s"]
  config_drive    = true
  user_data = file("k3s.yaml")
  network {
    name = "hergemoeller_net"
  }
}
