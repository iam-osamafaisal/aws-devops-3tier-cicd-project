resource "aws_db_subnet_group" "db" {
  name = "${var.project}-db-subnet"
  subnet_ids = aws_subnet.priv[*].id
}

resource "aws_db_instance" "db" {
  identifier = "${var.project}-rds"
  allocated_storage = 20
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  name = var.db_name
  username = var.db_username
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot = true
}
