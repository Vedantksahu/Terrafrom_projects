# Terrafrom_projects
How They Work Together
-When you create an EC2 instance:

1.VPC provides the network environment.
2.Subnet defines where in the network the instance is placed.
3.Security Group ensures the instance is accessible only through allowed protocols and IP ranges.1. Create a VPC
--------------------------------------------------------------------------------------------------------------------


A VPC provides an isolated network environment for your instance.

--CREATION OF VCP--

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # A large network range for your VPC
  tags = {
    Name = "My_VPC"
  }
}
--------------------------------------------------------------------------------------------------------------------

Create a Subnet

A subnet is created within the VPC. In this example, we create a public subnet.

--CREATION OF SUBNET--

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id  # Associate with the VPC
  cidr_block = "10.0.1.0/24"      # Subdivide the VPC range into a smaller segment
  map_public_ip_on_launch = true  # Ensure instances launched here get a public IP
  tags = {
    Name = "My_Public_Subnet"
  }
}
---------------------------------------------------------------------------------------------------------------------

Create a Security Group

A security group defines the firewall rules for your EC2 instance.

--CREATION OF SECURITY GROUP--


resource "aws_security_group" "my_sg" {
  name   = "my_security_group"
  vpc_id = aws_vpc.my_vpc.id     # Associate with the VPC

  ingress {                      # Allow incoming traffic
    from_port   = 22             # Allow SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all IPs (for testing; restrict in production)
  }

  ingress {
    from_port   = 80             # Allow HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {                       # Allow outgoing traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My_Security_Group"
  }
}

----------------------------------------------------------------------------------------------------

 Launch an EC2 Instance

 Place the instance in the subnet and secure it with the security group.

 --LAUNCH OF EC2--

 resource "aws_instance" "my_instance" {
  ami           = "ami-053b12d3152c0cc71" # Replace with your desired AMI ID
  instance_type = "t2.micro"              # Free-tier eligible
  subnet_id     = aws_subnet.my_subnet.id # Place the instance in the subnet
  vpc_security_group_ids = [aws_security_group.my_sg.id] # Attach the security group

  tags = {
    Name = "My_Test_Instance"
  }
}

------------------------------------------------------------------------------------------------------------

--OUTPUT FILES--

output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.my_subnet.id
}





