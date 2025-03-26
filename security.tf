resource "aws_security_group" "this" {
  name        = local.resource_name
  description = "MSK Security Group for ${local.resource_name}"
  vpc_id      = local.vpc_id
  tags        = local.tags
}

resource "aws_security_group_rule" "msk-to-world" {
  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

locals {
  brokers_port = var.enable_tls ? 9094 : 9092 // Plaintext => 9092, TLS => 9094
}

// Kafka needs access to itself so that Kafka connectors will work
// Kafka connectors inherit the security groups from the Kafka cluster
// This allows communication between the Kafka cluster and its Kafka connectors
resource "aws_security_group_rule" "msk-from-self" {
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  from_port         = local.brokers_port
  to_port           = local.brokers_port
  protocol          = "tcp"
  self              = true
}

resource "aws_security_group_rule" "msk-to-self" {
  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = local.brokers_port
  to_port           = local.brokers_port
  protocol          = "tcp"
  self              = true
}
