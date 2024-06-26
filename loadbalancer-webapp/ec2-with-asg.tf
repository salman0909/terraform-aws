data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
#ASG with Launch template
resource "aws_launch_template" "ec2_launch_template" {
  name_prefix   = "ec2_launch_template"
  image_id      =  data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data     = filebase64("user_data.sh")

  network_interfaces {

    associate_public_ip_address = false
    subnet_id                   = aws_subnet.sh_subnet_2.id
    security_groups             = [aws_security_group.sg_for_ec2.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eoc-instance"
    }
  }
}

resource "aws_autoscaling_group" "eoc_auto_scaling" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
  # Connect to the target group
  target_group_arns = [aws_lb_target_group.eoc_alb_tg.arn]
  vpc_zone_identifier = [
    aws_subnet.sh_subnet_2.id
  ]
  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }
}
