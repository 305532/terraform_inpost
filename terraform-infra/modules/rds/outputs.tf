resource "random_password" "db" {
  length           = 16
  override_special = false
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.username}-db-subnets"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg-${var.db_name}"
  description = "Allow MySQL from ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "this" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.instance_class
  name                   = var.db_name
  username               = var.username
  password               = random_password.db.result
  parameter_group_name   = "default.mysql8.0"
  multi_az               = true
  publicly_accessible    = false
  storage_encrypted      = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.this.name
  skip_final_snapshot    = true
}

resource "aws_secretsmanager_secret" "db_secret" {
  name        = "${var.db_name}-credentials"
  description = "RDS credentials for ${var.db_name}"
}

resource "aws_secretsmanager_secret_version" "version" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.username
    password = random_password.db.result
    host     = aws_db_instance.this.address
    port     = aws_db_instance.this.port
    database = var.db_name
  })
}
