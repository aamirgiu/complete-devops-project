variable "web_container_name" {
  description = "Web container ka naam"
  default     = "terraform-devops-app"
}

variable "web_port" {
  description = "Web ka external port"
  default     = 8092
}

variable "db_container_name" {
  description = "Database container ka naam"
  default     = "terraform-devops-db"
}

variable "db_port" {
  description = "Database ka external port"
  default     = 5434
}

variable "db_password" {
  description = "Database password"
  default     = "secret123"
  sensitive   = true
}

