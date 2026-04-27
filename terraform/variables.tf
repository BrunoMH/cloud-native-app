variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Nombre del clúster EKS"
  type        = string
  default     = "cloud-native-cluster"
}

variable "cluster_version" {
  description = "Versión de Kubernetes en EKS"
  type        = string
  default     = "1.32"
}