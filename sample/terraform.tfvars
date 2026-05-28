# =============================================================================
# Valores de Variables para el Ejemplo
# PC-IAC-026: Configuración declarativa sin IDs hardcodeados
# =============================================================================

# -----------------------------------------------------------------------------
# Variables de Gobernanza
# -----------------------------------------------------------------------------

client      = "pragma"
project     = "ecommerce"
environment = "dev"
region      = "us-east-1"

# -----------------------------------------------------------------------------
# Tags Comunes (PC-IAC-004)
# -----------------------------------------------------------------------------

common_tags = {
  Client      = "pragma"
  Project     = "ecommerce"
  Environment = "dev"
  Owner       = "cloudops-team"
  CostCenter  = "CC-001"
}

# -----------------------------------------------------------------------------
# Configuración de Transit Gateways
# PC-IAC-026: Configuración base sin nombres hardcodeados
# Los nombres se construyen dinámicamente en locals.tf
# -----------------------------------------------------------------------------

transit_gateway_config = {
  "main" = {
    description                     = "Transit Gateway principal para conectividad hub-and-spoke"
    amazon_side_asn                 = 64512
    auto_accept_shared_attachments  = "disable"
    default_route_table_association = "enable"
    default_route_table_propagation = "enable"
    dns_support                     = "enable"
    vpn_ecmp_support                = "enable"
    multicast_support               = "disable"
    transit_gateway_cidr_blocks     = []
    additional_tags = {
      Purpose = "hub-connectivity"
      Tier    = "network"
    }
  }

  "secondary" = {
    description                     = "Transit Gateway secundario para segmentación"
    amazon_side_asn                 = 64513
    auto_accept_shared_attachments  = "disable"
    default_route_table_association = "enable"
    default_route_table_propagation = "enable"
    dns_support                     = "enable"
    vpn_ecmp_support                = "enable"
    multicast_support               = "disable"
    transit_gateway_cidr_blocks     = []
    additional_tags = {
      Purpose = "segmentation"
      Tier    = "network"
    }
  }
}
