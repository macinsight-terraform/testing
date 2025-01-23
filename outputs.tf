output "node_access_ips" {
  value = {
    for name, instance in openstack_compute_instance_v2.nodes :
    name => format("Assigned Access IP of %s is %s", name, instance.access_ip_v4)
  }
}

output "master_floating_ip" {
  value = length(var.nodes) > 0 ? openstack_networking_floatingip_v2.k3s_master[0].address : null
}