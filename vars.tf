variable "project_name" {
  default = "sample"
}
variable "environments" {
  default = {
    dev = {
      location = "eastus"
    }
    qa = {
      location = "eastus"
    }
    hml = {
      location = "eastus"
    }
    prod = {
      location = "eastus"
    }
  }
}
