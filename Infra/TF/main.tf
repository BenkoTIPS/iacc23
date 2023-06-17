
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 2.0"
        }
    }
    required_version = ">= 0.14.9"
}

provider "azurerm" {
    features {}
}

data "azurerm_client_config" "current" {}

variable envName {}
variable appName {}

locals {
    prefix = "${var.envName}-${var.appName}"
}  


resource "azurerm_resource_group" "rg" {
    name = "${local.prefix}-rg"
    location = "centralus"
}

resource "azurerm_app_service_plan" "plan" {
    name                = "${local.prefix}-plan"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    kind                = "Linux"
    reserved            = true
    sku {
      tier = "Standard"
      size = "S1"
    }
}

resource "azurerm_app_service" "myApp" {
    name                = "${local.prefix}-site"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_app_service_plan.plan.id
    
    site_config {
        linux_fx_version = "DOTNETCORE|7.0"
        app_command_line = "dotnet iaccWeb.dll"
    }
    
    app_settings = {
        "Key" = "Value"
        "Key" = "Value"
    }
    identity {
        type = "SystemAssigned"
    }
}