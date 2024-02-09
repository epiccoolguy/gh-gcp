variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "location" {
  type = string
}

variable "owner" {
  description = "IAM-style member e.g. `serviceAccount:acc@example.com`"
  type        = string
}
