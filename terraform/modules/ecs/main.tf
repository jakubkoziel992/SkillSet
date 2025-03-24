resource "aws_service_discovery_http_namespace" "skillset" {
  name        = "${var.project_name}-cluster"
}

resource "aws_ecs_cluster" "skillset-cluster" {
  name = "${var.project_name}-cluster"

  service_connect_defaults {
    namespace = aws_service_discovery_http_namespace.skillset.arn
  }

  tags = {
    Name = "${var.project_name}"
  }

  depends_on = [ aws_service_discovery_http_namespace.skillset ]
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.skillset-cluster.name

  capacity_providers = ["FARGATE"] 
}

resource "aws_ecs_task_definition" "tasks" {
  for_each = var.task_definitions
  family = each.value.name
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn=var.execution_role
  cpu        = each.value.cpu
  memory    = each.value.memory
  container_definitions = jsonencode([
    {
      name      = each.value.name
      image     = each.value.image
      essential = true
      cpu       = each.value.cpu
      memory    = each.value.memory
      portMappings = each.value.port_mapping
      environment = each.value.env_variables
      
      # healthCheck = each.value.name == "web" ? {
      #   command    = each.value.health_check.command
      #   interval   = each.value.health_check.interval
      #   timeout    = each.value.health_check.timeout
      #   retries    = each.value.health_check.retries
      #   startPeriod = each.value.health_check.startPeriod
      # } : null
    }])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
  

resource "aws_ecs_service" "service" {
  for_each = var.service_definitions
  name = each.value.service_name
  cluster = aws_ecs_cluster.skillset-cluster.id
  task_definition = aws_ecs_task_definition.tasks["${each.value.service_name}"].arn
  launch_type = "FARGATE"
  desired_count = each.value.desired_count
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  
  network_configuration {
    subnets = var.service_subnets 
    assign_public_ip = var.assign_public_ip
    security_groups = [var.security_group_id]
  }
  service_connect_configuration {
    enabled = true
    namespace = aws_service_discovery_http_namespace.skillset.arn
    dynamic "service" {
    for_each = each.value.service != null ? [each.value.service] : []
    content {
      port_name = each.value.service.port_name
      client_alias {
        dns_name = each.value.service.client_alias.dns_name
        port = each.value.service.client_alias.port
      }
    }
    }
  }
  dynamic "load_balancer" {
  for_each = each.key == "web" ? [each.value.load_balancer] : []
  content {
    target_group_arn = var.target_group_arn
    container_name = load_balancer.value.container_name
    container_port = load_balancer.value.container_port
  }
  }
  depends_on =  [aws_ecs_cluster.skillset-cluster, aws_ecs_task_definition.tasks, aws_ecs_service.service["database"]]

}


