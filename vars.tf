variable "project_name" {
  default = "PROJECT_NAME" # Change this to your project name
}
variable "environments" {
  default = {
    dev = {
      location = "LOCATION" # Change this to your desired location. e.g. westus, eastus, etc.
    }
    # Uncomment the below lines to add more environments.
    # Obs: you may need to create keyvault secrets for the new environments
    # Obs2: you may need setup some resources manually, like synapse workspace
    # hml = {
    #   location = "LOCATION"
    # }
    # prod = {
    #   location = "LOCATION"
    # }
  }
}
