resource "aws_msk_cluster" "this" {
  cluster_name           = local.resource_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.num_broker_nodes

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
    encryption_at_rest_kms_key_arn = aws_kms_alias.this.arn

    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  client_authentication {
    iam = true
  }
}
