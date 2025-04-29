data "aws_region" "current" {}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.public.id,
  ]
}

resource "aws_security_group" "endpoint_sg" {
  name        = "endpoint-sg-${aws_vpc.this.id}"
  description = "Allow ECS tasks in private subnets to reach VPC endpoints"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.private[*].id
  security_group_ids = [aws_security_group.endpoint_sg.id]
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.private[*].id
  security_group_ids = [aws_security_group.endpoint_sg.id]
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.private[*].id
  security_group_ids = [aws_security_group.endpoint_sg.id]
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.private[*].id
  security_group_ids = [aws_security_group.endpoint_sg.id]
}

resource "aws_security_group" "vpc_endpoints_sg" {
  name   = "vpc-endpoints-sg"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [ aws_security_group.task_sg.id ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}