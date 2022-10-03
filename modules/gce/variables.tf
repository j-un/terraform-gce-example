variable "hostname" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "stop-instances-policy" {
  type = string
}

variable "image" {
  type = string
}

variable "boot_disk_size" {
  type    = number
  default = 30
}

variable "boot_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "network" {
  type = string
}

variable "ssh_port" {
  type = string
}

variable "timezone" {
  type    = string
  default = "Asia/Tokyo"
}
