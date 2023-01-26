output "java_instance_ip" {
    value = aws_instance.java.public_ip
}
output "java_sg_id" {
  value = aws_security_group.java.id
}