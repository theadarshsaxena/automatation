variable "configuration_set" {
  default = "matterworkx-cfg"
  type = string
}

variable "domains" {
  type    = list(string)
  default = ["mnc.com", "xyz.com"]  # Add your list of domains here
}


variable "mail_from_domains" {
  type    = list(string)
  default = ["mnc.com"]  # Add your list of domains here
}