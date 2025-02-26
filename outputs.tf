output "region" {
  value       = local.region
  description = "string ||| The AWS Region that this instance is deployed"
}

output "cluster_arn" {
  value       = aws_msk_cluster.this.arn
  description = "string ||| The ARN of the MSK Cluster"
}

output "cluster_name" {
  value       = aws_msk_cluster.this.cluster_name
  description = "string ||| The name of the MSK Cluster"
}

output "bootstrap_brokers_tls" {
  value       = aws_msk_cluster.this.bootstrap_brokers_tls
  description = "list(string) ||| The TLS-enabled Bootstrap Brokers of the MSK Cluster"
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "string ||| The ID of the security group attached to the Kafka cluster."
}
