variable "machine_count" {
 type = number
 default = 5
}

variable "ssh_public_key" {
 type = string
 default = "~/cloud/tp_devops_rsa.pub"
}

variable "ssh_private_key" {
 type = string
 default = "~/cloud/tp_devops_rsa"
}