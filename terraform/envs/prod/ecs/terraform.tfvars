project_name = "skillset"
environment  = "prod"
database_task_definition = {
  name         = "mysql"
  image        = "320183397498.dkr.ecr.us-east-1.amazonaws.com/kozijakinfo/skillset-db:1.0"
  cpu          = 1024
  memory       = 3072
  port_mapping = [{ name = "mysql", containerPort = 3306, hostPort = 3306, protocol = "tcp" }]
}

web_task_definition = {
  name         = "web"
  image        = "320183397498.dkr.ecr.us-east-1.amazonaws.com/kozijakinfo/skillset-app:2.0"
  cpu          = 512
  memory       = 1024
  port_mapping = [{ name = "web", containerPort = 8000, hostPort = 8000, protocol = "tcp", appProtocol = "http" }]
  # health_check =  {
  #   command    = ["CMD-SHELL", "curl http://localhost:8000 || exit 1"]
  #   interval   = 30
  #   timeout    = 5
  #   retries    = 3
  #   startPeriod = 10
  # }
}



service_definitions = {
  "database" = {
    service_name  = "database"
    desired_count = 1
    service = {
      client_alias = {
        dns_name = "mysql"
        port     = 3306
      }
      port_name = "mysql"
    }
  }
  "web" = {
    service_name  = "web"
    desired_count = 1
    load_balancer = {
      container_name = "web"
      container_port = 8000
    }
  }
}

ingress_rules = {
  "mysql" = {
    description = "Allow communication to mysql"
    port        = 3306
    protocol    = "tcp"
  }

  "app" = {
    description = "Allow communication to app"
    port        = 8000
    protocol    = "tcp"
  }

  "http" = {
    description = "Allow HTTP request from anywhere"
    cidr_ipv4   = "0.0.0.0/0"
    port        = 80
    protocol    = "tcp"
  }
}