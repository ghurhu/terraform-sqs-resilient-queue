variable "name" {
  description = "Queue base name; standard queues only."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,60}$", var.name))
    error_message = "Use 1..60 letters, digits, underscores or hyphens."
  }
}
variable "visibility_timeout_seconds" {
  description = "Must exceed normal processing duration; tune with your consumer."
  type        = number
  default     = 60
  validation {
    condition     = var.visibility_timeout_seconds >= 0 && var.visibility_timeout_seconds <= 43200 && floor(var.visibility_timeout_seconds) == var.visibility_timeout_seconds
    error_message = "Visibility timeout must be an integer from 0 to 43200."
  }
}
variable "max_receive_count" {
  description = "Receive attempts before transfer to the DLQ."
  type        = number
  default     = 5
  validation {
    condition     = var.max_receive_count >= 1 && var.max_receive_count <= 1000 && floor(var.max_receive_count) == var.max_receive_count
    error_message = "Receive count must be an integer from 1 to 1000."
  }
}
variable "tags" {
  description = "Additional resource tags."
  type        = map(string)
  default     = {}
}
