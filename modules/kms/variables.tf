variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "location" {
  type = string
}

variable "owners" {
  description = "IAM-style members e.g. `serviceAccount:acc@example.com`"
  type        = list(string)
}
