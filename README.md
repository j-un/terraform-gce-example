# terraform-gce-example

This is an example of launching GCE instances and related resources with terraform.<br>
I've written this code to make it easier to launch VSCode Server.

## Overview

- A network with default firewall rule
- Compute Engine instances with
  - custom ssh key
  - custom ssh port
  - static ip address
- Instance Schedule that stop instances at a specified time each day

## Prerequisite

- Execution Environment (which I checked)

  ```terraform.tf
  terraform {
  required_version = "1.3.0"
  required_providers {
      google = {
      source  = "hashicorp/google"
      version = "= 4.38.0"
      }
    }
  }
  ```

- Set appropriate permission for the IAM principal you use.
- Set variables in ./main.tf.

## Usage

```
terraform init
terraform apply
```
