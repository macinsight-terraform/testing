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

resource "openstack_networking_floatingip_v2" "fip" {
  pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "fip_association" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  instance_id = openstack_compute_instance_v2.k3s-master.id
}

resource "cloudflare_record" "k3s_master" {
  zone_id = var.cf_zone_id 
  name = var.cf_domain 
  type = "A"
  value = openstack_networking_floatingip_v2.fip.address
  ttl = 300
  proxied = false
}

output "k3s_master_accessip" {
  value = openstack_compute_instance_v2.k3s-master.access_ip_v4
  description = "Assigned access-ip of node"
}


output "floating_ip" {
  value = openstack_networking_floatingip_v2.fip.address
  description = "Floating IP of k3s master"
}
