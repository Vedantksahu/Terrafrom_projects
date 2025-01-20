resource "aws_instance" "My_instance" {
  ami = "xyz"
  type = "t2.micro"
  subnet_id
  tag = {
    Name = "Cloud_instance"
    }
