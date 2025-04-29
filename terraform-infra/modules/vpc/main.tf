resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "vpc-${var.cidr_block}" }
}

resource "aws_subnet" "public" {
  for_each              = zipmap(var.azs, var.public_subnet_cidrs)
  vpc_id                = aws_vpc.this.id
  cidr_block            = each.value
  availability_zone     = each.key
  map_public_ip_on_launch = true
  tags = { Name = "public-${each.key}" }
}

resource "aws_subnet" "private" {
  for_each          = zipmap(var.azs, var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key
  tags = { Name = "private-${each.key}" }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "igw-${var.cidr_block}" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = { Name = "public-rt" }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
