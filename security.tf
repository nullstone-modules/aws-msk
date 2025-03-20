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
