data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}
resource "aws_launch_template" "launch_template" {
  name          = "eoc-launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_security_group.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eoc-autoscaling-ec2"
    }
  }
  user_data = base64encode("${var.ec2_user_data}")
}
