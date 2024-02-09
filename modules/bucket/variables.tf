variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "project_number" {
  type = string
}

variable "location" {
  type = string
}

variable "storage_class" {
  type = string
}

variable "admin" {
  description = "IAM-style member e.g. `serviceAccount:acc@example.com`"
  type        = string
}
