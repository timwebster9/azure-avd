provider "azure" {
  tenant_id = "d8d82719-a4e3-4922-8d10-be2b4a616bcd"

  // uncomment if using SP
  //client_id = ""
  //client_secret = ""
}

provider "azurerm" {
  features {}

  subscription_id = "5b3b6b87-0c84-4cc0-ac99-75797863d447"

  // uncomment if using SP
  //tenant_id = "d8d82719-a4e3-4922-8d10-be2b4a616bcd"
  //client_id = ""
  //client_secret = ""
}