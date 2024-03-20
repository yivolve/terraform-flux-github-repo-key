variable "title" {
  type = string
  description = "(Required) A title."
}

variable "repository" {
  type = string
  description = "(Required) Name of the GitHub repository."
}

variable "description" {
  type = string
  description = "(Optional) Description of the secret."
}

variable "tags" {
  type = map(string)
  default = {}
}
