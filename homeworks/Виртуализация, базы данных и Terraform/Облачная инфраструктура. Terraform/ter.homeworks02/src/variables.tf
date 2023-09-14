###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDU5NJanEnPlzRamjK6/9toOeOKedcoy3QCtQSZt1HSydEwPTyNbYtwppTfwz12VKqoyhO5OtdxJhauh/M8Nn5/p7IXmk1KW3TrUKuPczGJ0ZSe9xW8tIIR0kYbRKnwZ4BncqGWA3s7hsJob/e0NRQ+sML1Hd8Yd+7lm4AlGS3IBZv04B6LRFUIEqUmP9ldXlRfjWlveh0+cV/+NYux/st6bp8dtpLk40YhvDeRIf/4Md7xTtuxjyUjQUaxoNJb5pZxto/Fh+QDijQNC2x4s5rrxannQI/x9XDBx+Gyt7YQNeyS+ZZjhsJnaDsA20q8HUCy1H2wCHhEGXHzPtRxj7xt7UfijQrXXs4OMvhgqnyldPhPJGsxxaw0Q3wXwfJQTailLqNcvJTPbUKn/pyTfIJjmFnrMcGmqRx/epNIphG/u4JpHnVDFptfkMi7XK40rduQSu8votBmOoL3H0/24lZxhfmSl9xhUPQjXC0Voww4S8rjqRf7T9RTvyGYTibx8V5/4C3MV0Dhu5PCbU7EQ0mcMof01qcUY6oVeQ22vWoSkesN4qLEQbZr/ehORd4EQOJ5lrEAl85LjTXjB/9HXn0N9EGNJAfYJaSRJOeu29GOQzARKNCmV5+PVfNUTj9RKUsiQqB6TLtjn5OBJYXjCAw1gwEMMoSz+Z1oPBU/MO0+/Q== Job_PC"
  description = "ssh-keygen -t ed25519"
}

variable "vm_web_platform" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
}

variable "vm_web_server" {
  type        = string
  default     = "standard-v1"
}

# variable "vm_web_core" {
#   type        = number
#   default     = 2
# }

# variable "vm_web_memory" {
#   type        = number
#   default     = 2
# }

# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 5
# }

variable "vm_resources" {
  type            = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default= {
    web             = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    db              = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}