resource "aws_ecs_task_definition" "ecs_task" {
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
        ]
    }
  ]
  DEFINITION
}
