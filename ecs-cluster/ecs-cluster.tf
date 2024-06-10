resource "aws_ecs_cluster" "eoc_cluster" {
  name = var.ecs_cluster_name
  setting {
    name = "containerInsights"
    value = "enabled"
  }
}
