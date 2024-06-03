resource "aws_ecs_cluster" "eoc_cluster" {
  name = "eoc_cluster"
  setting {
    name = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "name" {
  family = "service"
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE", "EC2" ]
  cpu = 512
  memory = 2048
  container_definitions = <<DEFINITION
  [
    {
        "name"  : "nginx",
        "image"     : "nginx:1.23.1",
        "cpu"       : 512,
        "memory"    : 2048,
        "essential" : true,
        "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort"      : 80
        }
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "service" {
  name = "service"
  cluster = aws_ecs_cluster.eoc_cluster.id
  task_definition = aws_ecs_task_definition.id
  desired_count = 1
  launch_type = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true 
    security_groups = [aws_security_group.sg.id]
    subnets = [aws_subnet.public_subnet.id]
  }
  lifecycle {
    ignore_changes = [ task_definition ]
  }
}