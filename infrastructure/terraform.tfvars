aws_region      = "eu-west-2"
project_name    = "simpletimeservice"
container_image = "ghcr.io/getsan4u/particle41-time-service:latest"
container_port  = 8080
cpu             = 256
memory          = 512
desired_count   = 1

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
availability_zones   = ["eu-west-2a", "eu-west-2b"]
