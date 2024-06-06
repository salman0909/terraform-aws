output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.kubectl-server.public_ip
}
