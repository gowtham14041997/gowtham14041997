#--------------------------------------------------------------------------------
#Subnet group for DB instances
#-----------------------------

resource "aws_db_subnet_group" "epam_db_subnet_group" {
  name       = var.db_group
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = var.db_subnet_group_name
  }
}

#--------------------------------------------------------------------------------
#DB instances
#------------

resource "aws_db_instance" "epam_dbs_instance" {
  count                     = var.db_instance_count
  db_name                   = var.db_name
  allocated_storage         = var.db_storage
  db_subnet_group_name      = aws_db_subnet_group.epam_db_subnet_group.name
  engine                    = var.db_engine
  engine_version            = var.db_engine_version
  instance_class            = var.db_instance_class
  username                  = var.db_user
  password                  = var.db_pass
  vpc_security_group_ids    = var.db_security_group_ids
  multi_az                  = true
}
