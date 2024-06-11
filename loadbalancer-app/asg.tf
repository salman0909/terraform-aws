resource "aws_autoscaling_group" "auto_scaling_group" {
  name             = "eoc-autoscaling-group"
  desired_capacity = 2
  max_size         = 5
  min_size         = 2
  vpc_zone_identifier = flatten([
    aws_subnet.private_subnet.*.id,
  ])
  target_group_arns = [
    aws_lb_target_group.target_group.arn,
  ]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}
