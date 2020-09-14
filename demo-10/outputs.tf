output "instance" {
  description = "The public IP address of the main server instance."
  value = aws_instance.example.public_ip
}

