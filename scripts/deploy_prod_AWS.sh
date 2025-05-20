#!/bin/bash
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
cd $EXEC_PATH/app
terraform init
terraform apply -auto-approve
echo "App Deployment Completed"

export LB_URL=$(terraform output -raw elb_address)
echo "Load balancer URL:$LB_URL"



exit 0