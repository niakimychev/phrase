output "vpc_id" {
  value = aws_vpc.phrase_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets.*.id
}
