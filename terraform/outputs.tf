output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.app_repo.repository_url
  sensitive   = true
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.public[*].id
}

output "security_group_id" {
  description = "ID of the ECS security group"
  value       = aws_security_group.ecs_tasks.id
  sensitive   = true
}

locals {
  timestamp = formatdate("YYYY-MM-DD-hh-mm", timestamp())
}

resource "null_resource" "output_generator" {
  triggers = {
    always_run = local.timestamp
  }

  provisioner "local-exec" {
    command = <<-EOT
      mkdir -p ${path.root}/outputs
      cat << EOF > ${path.root}/outputs/infrastructure-${local.timestamp}.txt
Infrastructure Details (Generated at ${local.timestamp})
====================================================

VPC ID: ${aws_vpc.main.id}
ECS Cluster: ${aws_ecs_cluster.main.name}
Region: ${var.aws_region}
Environment: ${var.environment}

For sensitive values, please check AWS Console or use:
terraform output -json

EOF
    EOT
  }
}

resource "local_file" "sensitive_outputs" {
  filename = "${path.root}/outputs/sensitive-${local.timestamp}.txt"
  content = templatefile("${path.root}/templates/sensitive.tpl", {
    ecr_url         = aws_ecr_repository.app_repo.repository_url
    security_group  = aws_security_group.ecs_tasks.id
    cluster_name    = aws_ecs_cluster.main.name
    timestamp       = local.timestamp
  })
  file_permission = "0600"  # Restrictive permissions
}

data "aws_availability_zones" "available" {
  state = "available"
}
