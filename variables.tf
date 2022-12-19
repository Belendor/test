variable "card" {
  type = map(any)
  default = {
    number = "123456789101112"
    cvv    = "1314"
    date   = "15/16",
    zip    = "18192"
  }
}

variable "address" {
  type = map(any)
  default = {
    street = "6199 NE Alber st"
    city   = "Hillsboro"
    state  = "OR"
    zip    = "97124"
  }
}
