variable "project" {
  default = "your_project"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "ssh_port" {
  default = "12368"
}

variable "ssh_key" {
  default = "your_name:ssh-ed25519 AAAAXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_network" "gce" {
  name                    = "gce"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "default" {
  name    = "default"
  network = google_compute_network.gce.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = [var.ssh_port]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_project_metadata" "ssh_key" {
  metadata = {
    ssh-keys = <<EOF
      ${var.ssh_key}
    EOF
  }
}

resource "google_compute_resource_policy" "stop-instances" {
  name        = "stop-instances"
  region      = var.region
  description = "stop instances every day at 21:00 JST"
  instance_schedule_policy {
    vm_stop_schedule {
      schedule = "0 21 * * *"
    }
    time_zone = "Asia/Tokyo"
  }
}

data "google_project" "project" {
}

resource "google_project_iam_custom_role" "compute_instances_stop" {
  role_id     = "computeInstancesStop"
  title       = "compute instances stop"
  description = "for Instance Schedule"
  permissions = ["compute.instances.stop"]
}

resource "google_project_iam_member" "compute_instances_stop" {
  project = var.project
  role    = google_project_iam_custom_role.compute_instances_stop.id
  member  = "serviceAccount:service-${data.google_project.project.number}@compute-system.iam.gserviceaccount.com"
}
