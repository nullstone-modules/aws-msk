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

output "brokers" {
  value       = local.brokers
  description = "list(string) ||| The addresses of bootstrap servers for the MSK Cluster"
}

output "brokers_port" {
  value       = local.brokers_port
  description = "number ||| The port of the bootstrap brokers"
}

output "brokers_tls_enabled" {
  value       = var.enable_tls
  description = "bool ||| Whether or not TLS is enabled for the MSK Cluster"
}

output "log_group" {
  value       = local.log_group_name
  description = "string ||| The CloudWatch Log Group that contains logs for the MSK Cluster broker nodes."
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "string ||| The ID of the security group attached to the Kafka cluster."
}
