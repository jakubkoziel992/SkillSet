resource "aws_service_discovery_http_namespace" "skillset" {
  name = "${var.project_name}-${var.environment}-ECS-cluster"

}

resource "aws_ecs_cluster" "skillset-cluster" {
  name = "${var.project_name}-${var.environment}-ECS-cluster"

  service_connect_defaults {
    namespace = aws_service_discovery_http_namespace.skillset.arn
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-ECS-cluster"
  }

  depends_on = [aws_service_discovery_http_namespace.skillset]
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.skillset-cluster.name

  capacity_providers = ["FARGATE"]
}

resource "aws_ecs_task_definition" "web" {
  family                   = var.web_task_definition.name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role
  cpu                      = var.database_task_definition.cpu
  memory                   = var.database_task_definition.memory
  container_definitions = jsonencode([
    {
      name         = var.web_task_definition.name
      image        = var.web_task_definition.image
      essential    = true
      cpu          = var.web_task_definition.cpu
      memory       = var.web_task_definition.memory
      portMappings = var.web_task_definition.port_mapping
      environment = [
        { name = "DB_NAME", value = var.project_name },
        { name = "DB_HOST", value = "mysql" },
        { name = "FLASK_ENV", value = "prod" },
      ]
      secrets = [
        { name = "DB_PASSWORD", valueFrom = var.password },
        { name = "DB_USER", valueFrom = var.username },
        { name = "SECRET_KEY", valueFrom = var.app_secret_key }
      ]
      healthCheck = var.web_task_definition.health_check
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_task_definition" "database" {
  family                   = var.database_task_definition.name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role
  cpu                      = var.database_task_definition.cpu
  memory                   = var.database_task_definition.memory
  container_definitions = jsonencode([
    {
      name         = var.database_task_definition.name
      image        = var.database_task_definition.image
      essential    = true
      cpu          = var.database_task_definition.cpu
      memory       = var.database_task_definition.memory
      portMappings = var.database_task_definition.port_mapping
      environment = [
        { name = "MYSQL_DATABASE", value = var.project_name }
      ]
      secrets = [
        { name = "MYSQL_PASSWORD", valueFrom = var.password },
        { name = "MYSQL_ROOT_PASSWORD", valueFrom = var.password },
        { name = "MYSQL_USER", valueFrom = var.username }
      ]
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

}

resource "aws_ecs_service" "service" {
  for_each        = var.service_definitions
  name            = each.value.service_name
  cluster         = aws_ecs_cluster.skillset-cluster.id
  task_definition = each.key == "web" ? aws_ecs_task_definition.web.arn : aws_ecs_task_definition.database.arn
  launch_type     = "FARGATE"
  desired_count   = each.value.desired_count
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  force_new_deployment = true

  network_configuration {
    subnets          = var.service_subnets
    assign_public_ip = var.assign_public_ip
    security_groups  = [var.security_group_id]
  }
  service_connect_configuration {
    enabled   = true
    namespace = aws_service_discovery_http_namespace.skillset.arn
    dynamic "service" {
      for_each = each.value.service != null ? [each.value.service] : []
      content {
        port_name = each.value.service.port_name
        client_alias {
          dns_name = each.value.service.client_alias.dns_name
          port     = each.value.service.client_alias.port
        }
      }
    }
  }
  dynamic "load_balancer" {
    for_each = each.key == "web" ? [each.value.load_balancer] : []
    content {
      target_group_arn = var.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }
  depends_on = [aws_ecs_cluster.skillset-cluster, aws_ecs_task_definition.database, aws_ecs_service.service["database"]]

}


