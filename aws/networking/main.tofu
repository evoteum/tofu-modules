resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  for_each          = { for idx, cidr in var.private_subnets : cidr => var.availability_zones[idx] }
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.key
  availability_zone = each.value

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-${each.key}"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  for_each          = { for idx, cidr in var.public_subnets : cidr => var.availability_zones[idx] }
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.key
  availability_zone = each.value

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-${each.key}"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-${var.environment}-igw"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "main" {
  for_each      = aws_subnet.public
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = {
    Name        = "${var.project_name}-${var.environment}-nat-${each.key}"
    Environment = var.environment
  }
}

resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  vpc      = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-eip-${each.key}"
    Environment = var.environment
  }
}

# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-rt"
    Environment = var.environment
  }
}

# Private route tables (one per AZ for NAT gateway)
resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[each.key].id
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-rt-${each.key}"
    Environment = var.environment
  }
}

# Route table associations
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
} 