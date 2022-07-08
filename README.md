## Customize

Search for "sample" in the code and change it to your own name.

## Authentication

- Login on Azure

```bash
az login
```

- List account to get correct subscription

```bash
az account list
```

- Set subscription

```bash
az account set --subscription="SUBSCRIPTION_ID"
```

## First time setup

```bash
SUBSCRIPTION_ID=<SUBSCRIPTION_ID>
LOCATION=<LOCATION>
PROJECT_NAME=<PROJECT_NAME>
RESOURCE_GROUP_NAME="${PROJECT_NAME}tfstate"
STORAGE_ACCOUNT_NAME="${PROJECT_NAME}tfstate"
CONTAINER_NAME="tfstate"

# Create resource group
az group create --location $LOCATION \
	--name $RESOURCE_GROUP_NAME \
	--subscription $SUBSCRIPTION_ID

# Create storage account
az storage account create --name $STORAGE_ACCOUNT_NAME \
	--location $LOCATION \
	--sku Standard_LRS \
	--encryption-services blob \
	--resource-group $RESOURCE_GROUP_NAME

# Create blob container
az storage container create --name $CONTAINER_NAME \
	--account-name $STORAGE_ACCOUNT_NAME \
	--fail-on-exist
```

## Using Terraform

- Init modules

```bash
terraform init
```

- Check changes

```bash
terraform plan
```

- Apply changes

```bash
terraform apply
```

## Tools

- [Azure Terraform Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform)

## Examples

- [Using Terraform's Azure Provider to provision resources in Azure](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples)

## Official Docs

- [Terraform on Azure documentation - docs.microsoft.com](https://docs.microsoft.com/en-us/azure/developer/terraform/)

- [azurerm provider - registry.terraform.io](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
