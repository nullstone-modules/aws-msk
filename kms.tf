resource "aws_kms_key" "this" {
  description             = "KMS key for MSK cluster encryption (${local.resource_name})"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  tags                    = local.tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${local.resource_name}"
  target_key_id = aws_kms_key.this.id
}
