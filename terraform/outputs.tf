output "web_container_name" {
  description = "Web container ka naam"
  value       = docker_container.web.name
}

output "web_url" {
  description = "Website ka URL"
  value       = "http://192.168.77.128:8092"
}

output "db_container_name" {
  description = "Database container ka naam"
  value       = docker_container.db.name
}

output "db_connection" {
  description = "Database connection info"
  value       = "postgresql://admin:secret123@192.168.77.128:5434/devopsdb"
  sensitive   = true
}

output "network_name" {
  description = "Docker network ka naam"
  value       = docker_network.devops_network.name
}

output "deployment_summary" {
  description = "Deployment ka summary"
  value = <<-EOT
  
  ========================================
  TERRAFORM DEPLOYMENT COMPLETE!
  ========================================
  Web Container: ${docker_container.web.name}
  Web URL: http://192.168.77.128:8092
  Database: ${docker_container.db.name}
  Network: ${docker_network.devops_network.name}
  ========================================
  
  EOT
}

