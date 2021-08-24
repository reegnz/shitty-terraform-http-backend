terraform {
  backend "http" {
    address        = "http://localhost:8080/terraform/state/4a12d6a8-5cd0-4684-bd31-5e56e6fd9121"
    lock_address   = "http://localhost:8080/terraform/lock/state/4a12d6a8-5cd0-4684-bd31-5e56e6fd9121"
    unlock_address = "http://localhost:8080/terraform/lock/state/4a12d6a8-5cd0-4684-bd31-5e56e6fd9121"
    update_method  = "POST"
    lock_method    = "POST"
    unlock_method  = "DELETE"
  }
}
