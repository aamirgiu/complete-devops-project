terraform {
  required_version = ">= 1.0"
  
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///run/user/1000/podman/podman.sock"
}

# Network
resource "docker_network" "devops_network" {
  name = "terraform-devops-network"
}

# Nginx Image
resource "docker_image" "nginx" {
  name = "nginx:1.25-alpine"
}

# PostgreSQL Image
resource "docker_image" "postgres" {
  name = "postgres:16-alpine"
}

# Volume for Database
resource "docker_volume" "db_data" {
  name = "terraform-db-data"
}

# Web Container
resource "docker_container" "web" {
  name  = "terraform-devops-app"
  image = docker_image.nginx.image_id
  
  ports {
    internal = 80
    external = 8092
  }
  
  networks_advanced {
    name = docker_network.devops_network.name
  }
  
  restart = "unless-stopped"
  
  labels {
    label = "project"
    value = "complete-devops"
  }
  
  labels {
    label = "managed_by"
    value = "terraform"
  }
}

# Database Container
resource "docker_container" "db" {
  name  = "terraform-devops-db"
  image = docker_image.postgres.image_id
  
  env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=secret123",
    "POSTGRES_DB=devopsdb"
  ]
  
  ports {
    internal = 5432
    external = 5434
  }
  
  volumes {
    volume_name    = docker_volume.db_data.name
    container_path = "/var/lib/postgresql/data"
  }
  
  networks_advanced {
    name = docker_network.devops_network.name
  }
  
  restart = "unless-stopped"
}
