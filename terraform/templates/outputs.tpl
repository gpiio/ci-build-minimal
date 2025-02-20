Infrastructure Details (Generated at ${timestamp})
====================================================

VPC ID: ${vpc_id}
ECS Cluster: ${cluster_name}
Region: ${aws_region}
Environment: ${environment}
ECR Repository URL: ${ecr_url}

Quick Commands:
--------------
Build: podman build -t ${app_name}:latest .
Tag:   podman tag ${app_name}:latest ${ecr_url}:latest
Push:  podman push ${ecr_url}:latest

Application URL: http://${alb_dns}
