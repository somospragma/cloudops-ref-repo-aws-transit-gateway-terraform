# =============================================================================
# Invocación del Módulo Padre (Transit Gateway)
# PC-IAC-026: Patrón de Transformación en sample/
# PC-IAC-013: Estructura de Llamada a Módulos (Ordering)
# =============================================================================

# -----------------------------------------------------------------------------
# Invocación del Módulo de Transit Gateway
# PC-IAC-026: Solo invocar módulo con local.* (nunca var.* directos)
# PC-IAC-013: Orden estricto de atributos
# -----------------------------------------------------------------------------

module "transit_gateway" {
  # A. Fuente del Módulo
  source = "../"

  # B. Providers
  # PC-IAC-005: Inyección del provider principal
  providers = {
    aws.project = aws.principal
  }

  # C. Variables de Gobernanza (PC-IAC-003)
  client      = var.client
  project     = var.project
  environment = var.environment

  # E. Variables de Configuración (PC-IAC-002)
  # PC-IAC-026: Consumir local transformado (nunca var.* directo)
  transit_gateway_config = local.transit_gateway_config_transformed
}
