variable "pool_name" {
  type = string
}

variable "provider_name" {
  type = string
}

variable "random_pool_name" {
  description = "Adds a suffix of 4 random characters to the `pool_name`."
  type        = bool
  default     = false
}

variable "random_provider_name" {
  description = "Adds a suffix of 4 random characters to the `provider_name`."
  type        = bool
  default     = false
}

variable "project_id" {
  type = string
}

variable "attribute_condition" {
  type = string
}
