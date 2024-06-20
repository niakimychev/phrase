output "vpc_id" {
  value = aws_vpc.phrase_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets.*.id
}

output "private_route_table_id" {
  value = aws_route_table.private_route_table.id
}

output "region" {
  value = var.region
}
