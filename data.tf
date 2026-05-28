# =============================================================================
# Data Sources del Módulo
# PC-IAC-011: Data Sources deben estar en el Módulo Raíz (IaC Root)
# =============================================================================

# Los Data Sources para obtener recursos externos (VPCs, Subnets, etc.)
# deben ser declarados en el Módulo Raíz y pasados como variables de entrada.
#
# Este módulo recibe los IDs necesarios a través de:
#   - var.transit_gateway_config[*].vpc_attachments[*].vpc_id
#   - var.transit_gateway_config[*].vpc_attachments[*].subnet_ids
#
# Ejemplo de uso en el Root:
#   data "aws_vpc" "selected" {
#     filter {
#       name   = "tag:Name"
#       values = ["${var.client}-${var.project}-${var.environment}-vpc"]
#     }
#   }

# Data source para obtener la región actual (permitido en módulos)
data "aws_region" "current" {
  provider = aws.project
}

# Data source para obtener la cuenta actual (permitido en módulos)
data "aws_caller_identity" "current" {
  provider = aws.project
}
