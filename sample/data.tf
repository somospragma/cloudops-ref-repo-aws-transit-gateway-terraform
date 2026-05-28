# =============================================================================
# Data Sources del Ejemplo
# PC-IAC-026: Consulta de recursos existentes para inyección dinámica
# PC-IAC-011: Data Sources para obtener IDs dinámicos
# =============================================================================

# -----------------------------------------------------------------------------
# Data Sources para obtener información de la cuenta y región
# Estos data sources son permitidos en el ejemplo para demostrar el patrón
# -----------------------------------------------------------------------------

data "aws_region" "current" {
  provider = aws.principal
}

data "aws_caller_identity" "current" {
  provider = aws.principal
}

# -----------------------------------------------------------------------------
# Ejemplo de Data Source para VPC (si se necesitara para attachments)
# PC-IAC-017: Búsqueda por nomenclatura estándar
# -----------------------------------------------------------------------------

# Descomentar si se necesita obtener una VPC existente:
#
# data "aws_vpc" "selected" {
#   provider = aws.principal
#
#   filter {
#     name   = "tag:Name"
#     values = ["${var.client}-${var.project}-${var.environment}-vpc"]
#   }
# }

# -----------------------------------------------------------------------------
# Ejemplo de Data Source para Subnets (si se necesitara para attachments)
# -----------------------------------------------------------------------------

# Descomentar si se necesitan subnets para VPC attachments:
#
# data "aws_subnets" "private" {
#   provider = aws.principal
#
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.selected.id]
#   }
#
#   filter {
#     name   = "tag:Type"
#     values = ["private"]
#   }
# }
