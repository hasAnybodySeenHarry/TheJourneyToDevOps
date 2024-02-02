variable "cluster_name" {
  type        = string

  description = "The unique name for the cluster. It should be between 3 and 10 characters in length."

  validation {
    condition     = length(var.cluster_name) >= 3 && length(var.cluster_name) <= 10
    error_message = "The cluster name must be between 3 and 10 characters in length."
  }
}

variable "service_name" {
  description = "The name of the ECS service. The length of the name must be between 3 and 10 characters."
  type        = string
  validation {
    condition     = length(var.service_name) >= 3 && length(var.service_name) <= 10
    error_message = "Service name must be between 3 and 10 characters."
  }
}

variable "db_username" {
  type        = string
  sensitive   = true
  description = "Database username (4-10 characters)."
  validation {
    condition     = length(var.db_username) >= 4 && length(var.db_username) <= 10
    error_message = "Username must be between 4 and 10 characters long."
  }
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Database password (7-16 characters)."
  validation {
    condition     = length(var.db_password) >= 7 && length(var.db_password) <= 16
    error_message = "Password must be between 7 and 16 characters long."
  }
}
