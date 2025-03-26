variable "kafka_version" {
  type        = string
  default     = "3.7.x"
  description = <<EOF
The version of Apache Kafka.
For available versions, see https://docs.aws.amazon.com/msk/latest/developerguide/supported-kafka-versions.html
EOF
}

variable "instance_type" {
  type        = string
  default     = "kafka.m7g.large"
  description = <<EOF
The instance type to use for the kafka brokers.
It must be a valid Amazon MSK instance type. (e.g. `kafka.*.*`)
See https://docs.aws.amazon.com/msk/latest/developerguide/broker-instance-sizes.html
EOF
}

variable "num_broker_nodes" {
  type        = number
  default     = 2
  description = <<EOF
The desired number of broker nodes in the kafka cluster.
It must be a multiple of the number of specified client subnets.
This module uses all private subnets of the connected network.
EOF
}

variable "storage_size" {
  type        = number
  default     = 100
  description = <<EOF
The size of the EBS volume for each data volume in the broker nodes.
This is measured in GiB with a minimum of 1GiB and a maximum of 16 TiB.
EOF

  validation {
    condition     = var.storage_size >= 1
    error_message = "The storage size must be at least 1 GiB."
  }

  validation {
    condition     = var.storage_size <= 16384
    error_message = "The storage size must be at most 16 TiB."
  }
}

variable "enable_tls" {
  type        = bool
  default     = false
  description = "Enable TLS encryption for client-server connections to the MSK cluster."
}
