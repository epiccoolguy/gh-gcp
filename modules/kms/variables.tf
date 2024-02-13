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

variable "owner" {
  description = "IAM-style members e.g. `serviceAccount:acc@example.com`"
  type        = string
}
