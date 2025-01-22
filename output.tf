output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}

output "instance_public_ip" {
  value = aws_instance.mera_instance.public_ip
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
