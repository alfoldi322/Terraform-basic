output "web_instance_ip" {
    value = aws_instance.web.public_ip
}
output "web_sg_id" {
    value = aws_security_group.web.id
}