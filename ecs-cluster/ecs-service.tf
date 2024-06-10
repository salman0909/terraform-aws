resource "aws_ecs_service" "service" {
  name = "service"
  cluster = aws_ecs_cluster.eoc_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.id
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
