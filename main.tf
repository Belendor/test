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
    number = var.card["number"]
    cvv    = var.card["cvv"]
    date   = var.card["date"]
    zip    = var.card["zip"]
  }
}

data "dominos_address" "addr" {
  street = var.address["street"]
  city   = var.address["city"]
  state  = var.address["state"]
  zip    = var.address["zip"]
}

output "AddressData" {
  value = data.dominos_address.addr
}

data "dominos_store" "store" {
  address_url_object = data.dominos_address.addr.url_object
}

data "dominos_menu_item" "item" {
  store_id     = data.dominos_store.store.store_id
  query_string = ["philly", "medium"]
}

resource "dominos_order" "order" {

  for_each = {
    0 = data.dominos_menu_item.item.matches.0.code
    1 = data.dominos_menu_item.item.matches.1.code
  }

  address_api_object = data.dominos_address.addr.api_object
  item_codes         = [each.value]
  store_id           = data.dominos_store.store.store_id
}
