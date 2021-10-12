# Random String Resource

resource "random_string" "myrandom" {
  length = 6
  upper = false
  number = false
  special = false
  
}