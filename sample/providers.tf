# =============================================================================
# Configuración de Providers para el Ejemplo
# PC-IAC-005: Configuración y Alias de Providers
# PC-IAC-004: Etiquetas Transversales mediante default_tags
# =============================================================================

provider "aws" {
  region = var.region
  alias  = "principal"

  # PC-IAC-004: Tags transversales aplicados a todos los recursos
  default_tags {
    tags = var.common_tags
  }
}
