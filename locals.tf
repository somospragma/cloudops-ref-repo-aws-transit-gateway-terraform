# =============================================================================
# Valores Locales y Transformaciones
# PC-IAC-003: Nomenclatura Estándar
# PC-IAC-012: Estructuras de Datos y Reutilización en Locals
# PC-IAC-009: Tipos de Datos, Conversiones y Lógica en Locals
# =============================================================================

locals {
  # ---------------------------------------------------------------------------
  # Prefijo de Gobernanza
  # PC-IAC-003: Construcción centralizada del prefijo base
  # ---------------------------------------------------------------------------
  governance_prefix = "${var.client}-${var.project}-${var.environment}"

  # ---------------------------------------------------------------------------
  # Tags Base del Módulo
  # PC-IAC-004: Etiquetas Obligatorias
  # ---------------------------------------------------------------------------
  base_module_tags = {
    "managed-by" = "terraform"
    "module"     = "transit-gateway"
  }

  # ---------------------------------------------------------------------------
  # Configuración Procesada de Transit Gateways
  # PC-IAC-012: Transformación de estructuras de datos
  # ---------------------------------------------------------------------------
  transit_gateways_processed = {
    for key, config in var.transit_gateway_config : key => {
      name                            = config.name
      description                     = config.description
      amazon_side_asn                 = config.amazon_side_asn
      auto_accept_shared_attachments  = config.auto_accept_shared_attachments
      default_route_table_association = config.default_route_table_association
      default_route_table_propagation = config.default_route_table_propagation
      dns_support                     = config.dns_support
      vpn_ecmp_support                = config.vpn_ecmp_support
      multicast_support               = config.multicast_support
      transit_gateway_cidr_blocks     = config.transit_gateway_cidr_blocks

      # Merge de tags: Name + base_module_tags + additional_tags
      tags = merge(
        { Name = config.name },
        local.base_module_tags,
        config.additional_tags
      )
    }
  }
}
