resource "openstack_networking_floatingip_v2" "k3s_master" {
  count = length(var.nodes) > 0 ? 1 : 0 # Ensure at least one node exists

  pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "fip_association" {
  count = length(var.nodes) > 0 ? 1 : 0 # Ensure only one association is created

  floating_ip = openstack_networking_floatingip_v2.k3s_master[0].address
  instance_id = openstack_compute_instance_v2.nodes[var.nodes[0]].id
}