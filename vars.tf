variable "project_name" {
  default = "sample"
}
variable "environments" {
  default = {
    dev = {
      location = "eastus2"
    }
    hml = {
      location = "eastus2"
    }
    prod = {
      location = "eastus2"
    }
  }
}
