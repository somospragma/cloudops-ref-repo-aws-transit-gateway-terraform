# =============================================================================
# Transformaciones del Ejemplo
# PC-IAC-026: Patrón de Transformación en sample/
# PC-IAC-025: Procesamiento Obligatorio de Gobernanza en el Root
# PC-IAC-009: Tipos de Datos, Conversiones y Lógica en Locals
# =============================================================================

locals {
  # ---------------------------------------------------------------------------
  # Prefijo de Gobernanza
  # PC-IAC-003: Construcción del prefijo base de nomenclatura
  # PC-IAC-025: El Root construye la nomenclatura FINAL
  # ---------------------------------------------------------------------------
  governance_prefix = "${var.client}-${var.project}-${var.environment}"

  # ---------------------------------------------------------------------------
  # Transformación de Configuración de Transit Gateways
  # PC-IAC-026: Inyección de nombres construidos dinámicamente
  # PC-IAC-009: Uso de merge para combinar configuración base con valores dinámicos
  # ---------------------------------------------------------------------------
  transit_gateway_config_transformed = {
    for key, config in var.transit_gateway_config : key => merge(config, {
      # PC-IAC-025: Inyección del nombre FINAL construido en el Root
      # Patrón: {client}-{project}-{environment}-tgw-{key}
      name = "${local.governance_prefix}-tgw-${key}"
    })
  }

  # ---------------------------------------------------------------------------
  # Información de Contexto (para debugging o logging)
  # ---------------------------------------------------------------------------
  context_info = {
    region     = data.aws_region.current.id
    account_id = data.aws_caller_identity.current.account_id
  }
}
