resource "aws_security_group" "this" {
  name        = local.resource_name
  description = "MSK Security Group for ${local.resource_name}"
  vpc_id      = local.vpc_id
}
