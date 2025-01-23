resource "openstack_compute_instance_v2" "k3s_master" {
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


resource "null_resource" "configure_kubeconfig" {
  depends_on = [openstack_compute_instance_v2.k3s_master]

  provisioner "remote-exec" {
    inline = [
      "sudo cp /etc/rancher/k3s/k3s.yaml /home/jh/k3s.yaml",
      "sudo chown jh:jh /home/jh/k3s.yaml",
      "sed -i 's/127.0.0.1/${openstack_networking_floatingip_v2.fip.address}/g' /home/jh/k3s.yaml"
    ]

    connection {
      type        = "ssh"
      host        = openstack_networking_floatingip_v2.fip.address
      user        = "jh"
      private_key = file("~/.ssh/b1systems")
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
      scp -i ~/.ssh/b1systems jh@${openstack_networking_floatingip_v2.fip.address}:/home/jh/k3s.yaml ~/.kube/config
    EOT
  }
}



resource "openstack_networking_floatingip_v2" "fip" {
  pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "fip_association" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  instance_id = openstack_compute_instance_v2.k3s_master.id
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
  value = openstack_compute_instance_v2.k3s_master.access_ip_v4
  description = "Assigned access-ip of master"
}


output "floating_ip" {
  value = openstack_networking_floatingip_v2.fip.address
  description = "Floating IP of k3s master"
}
