## Requirements

- Contributor access to the Azure Subscription of the project
- Contributor access to the Storage Account where the Terraform state is stored
- Azure CLI

## Authentication

- Set the subscription

```bash
az account set --subscription=SUBSCRIPTION_ID # You can get it with az account list
```

More details: [Authenticating using the Azure CLI](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli).

## Setup provider

- Access [provider](./provider.tf) file and follow the comments.

## Using Terraform

- Init back end and modules

```bash
terraform init
```

- (Optional) Validate changes

```bash
terraform validate
```

- (Optional) Check changes

```bash
terraform plan
```

- Apply changes

```bash
terraform apply
```

## Provisioning new resources

The resources that are going to be provisioned are defined in the [app_infra folder](./app_infra/). In the [samples folder](./samples/) you can find some examples of how to provision different resources. For a more detailed explanation, check the links below:

- [Using Terraform's Azure Provider to provision resources in Azure](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples)
- [Terraform on Azure documentation - docs.microsoft.com](https://docs.microsoft.com/en-us/azure/developer/terraform/)
- [azurerm provider - registry.terraform.io](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
