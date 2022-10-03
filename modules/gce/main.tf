resource "google_compute_address" "staticip" {
  name = var.hostname
}

resource "google_compute_instance" "host" {
  name              = var.hostname
  machine_type      = var.machine_type
  zone              = var.zone
  resource_policies = [var.stop-instances-policy]

  boot_disk {
    device_name = var.hostname

    initialize_params {
      image = var.image
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }
  }

  network_interface {
    network = var.network
    access_config {
      nat_ip = google_compute_address.staticip.address
    }
  }

  metadata_startup_script = <<EOT
apt update && apt upgrade
sed -i 's/^#Port 22/Port ${var.ssh_port}/' /etc/ssh/sshd_config
systemctl restart sshd
timedatectl set-timezone ${var.timezone}
EOT
}
