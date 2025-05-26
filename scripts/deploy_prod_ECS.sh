#!/bin/sh
set -euo pipefail


# terraform execution path
EXEC_PATH="$CI_PROJECT_DIR/infrastructure/terraform/envs/prod"

echo "Terraform execution path: $EXEC_PATH"

# VPC Deployment
echo "Deploying VPC..."
cd $EXEC_PATH/vpc
terraform init
terraform apply -auto-approve
echo "VPC Deployment Completed"

# APP Deployment
echo "Deploying App..."
cd $EXEC_PATH/ecs
terraform init
terraform apply -auto-approve
echo "App Deployment Completed"

exit 0