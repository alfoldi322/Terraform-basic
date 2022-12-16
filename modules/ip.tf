# Create an Elastic IP
resource "aws_eip" "alfoldi322" {
  vpc = true

  tags = {
    Name = "alfoldi322-eip"
  }
}