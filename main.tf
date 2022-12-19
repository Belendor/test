terraform {
  required_providers {
    dominos = {
      source  = "terraform.local/local/dominos"
      version = "1.0"
    }
  }
}

provider "dominos" {
  first_name    = "My"
  last_name     = "Name"
  email_address = "my@name.com"
  phone_number  = "15555555555"

  credit_card {
    number = 123456789101112
    cvv    = 1314
    date   = "1516"
    zip    = 18192
  }
}

data "dominos_address" "addr" {
  street      = "6199 NE Alber st"
  city        = "Hillsboro"
  state       = "OR"
  zip         = "97124"
}

output "OrderOutput" {
  value = data.dominos_address.addr.url_object
}

data "dominos_store" "store" {
  address_url_object = data.dominos_address.addr.url_object
}

# data "dominos_menu_item" "item" {
#   store_id     = data.dominos_store.store.store_id
#   query_string = ["philly", "medium"]
# }

# resource "dominos_order" "order" {
#   address_api_object = data.dominos_address.addr.api_object
#   item_codes         = ["${data.dominos_menu_item.item.matches.0.code}"]
#   store_id           = data.dominos_store.store.store_id
# }
