resource "aws_msk_configuration" "this" {
  kafka_versions    = [var.kafka_version]
  name              = local.resource_name
  server_properties = <<EOF
auto.create.topics.enable = true
delete.topic.enable = true
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_msk_cluster" "this" {
  cluster_name           = local.resource_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.num_broker_nodes
  tags                   = local.tags

  broker_node_group_info {
    instance_type   = var.instance_type
    client_subnets  = local.private_subnet_ids
    security_groups = [aws_security_group.this.id]

    storage_info {
      ebs_storage_info {
        volume_size = var.storage_size
      }
    }
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.this.arn

    encryption_in_transit {
      client_broker = var.enable_tls ? "TLS" : "PLAINTEXT"
      in_cluster    = var.enable_tls
    }
  }

  configuration_info {
    arn      = aws_msk_configuration.this.arn
    revision = aws_msk_configuration.this.latest_revision
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = local.log_group_name
      }
    }
  }
}
