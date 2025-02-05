output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "Map of CIDR blocks to private subnet IDs"
  value       = { for cidr, subnet in aws_subnet.private : cidr => subnet.id }
}

output "public_subnet_ids" {
  description = "Map of CIDR blocks to public subnet IDs"
  value       = { for cidr, subnet in aws_subnet.public : cidr => subnet.id }
}

output "nat_gateway_ids" {
  description = "Map of CIDR blocks to NAT Gateway IDs"
  value       = { for cidr, nat in aws_nat_gateway.main : cidr => nat.id }
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  value       = keys(aws_subnet.private)
}

output "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  value       = keys(aws_subnet.public)
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Map of CIDR blocks to private route table IDs"
  value       = { for cidr, rt in aws_route_table.private : cidr => rt.id }
}
