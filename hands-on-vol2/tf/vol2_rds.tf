resource "aws_db_instance" "wordpress-instance" {
    identifier = "wordpress"
    allocated_storage = 10
    engine = "mariadb"
    engine_version = "10.0.24"
    instance_class = "${lookup(var.rds_settings, "instance_class")}"
    name = "${lookup(var.rds_settings, "database_name")}"
    username = "${lookup(var.rds_settings, "db_username")}"
    password = "${random_id.rds_password.b64}"
    db_subnet_group_name = "${aws_db_subnet_group.wordpress.name}"
    vpc_security_group_ids = ["${aws_security_group.RDS-SG.id}"]
    parameter_group_name = "${aws_db_parameter_group.wordpress-pg.name}"
    multi_az = "true"
    backup_retention_period = "1"
    backup_window = "03:00-03:30"
    apply_immediately = "true"
    auto_minor_version_upgrade = "true"
}

output "rds_endpoint" {
    value = "${aws_db_instance.wordpress-instance.address}"
}