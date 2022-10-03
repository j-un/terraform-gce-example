data "google_compute_image" "debian-11" {
  family  = "debian-11"
  project = "debian-cloud"
}

module "testinstance" {
  source = "./modules/gce"

  hostname              = "testinstance"
  stop-instances-policy = google_compute_resource_policy.stop-instances.self_link
  image                 = data.google_compute_image.debian-11.self_link
  network               = google_compute_network.gce.self_link
  ssh_port              = var.ssh_port
}

output "testinstance" {
  value = module.testinstance.ip
}
