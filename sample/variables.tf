# =============================================================================
# Variables del Ejemplo
# PC-IAC-026: Patrón de Transformación en sample/
# =============================================================================

# -----------------------------------------------------------------------------
# Variables de Gobernanza
# -----------------------------------------------------------------------------

variable "client" {
  description = "Nombre del cliente o unidad de negocio."
  type        = string

  validation {
    condition     = length(var.client) > 0 && length(var.client) <= 10
    error_message = "La variable 'client' debe tener entre 1 y 10 caracteres."
  }
}

variable "project" {
  description = "Nombre del proyecto."
  type        = string

  validation {
    condition     = length(var.project) > 0 && length(var.project) <= 15
    error_message = "La variable 'project' debe tener entre 1 y 15 caracteres."
  }
}

variable "environment" {
  description = "Entorno de despliegue."
  type        = string

  validation {
    condition     = contains(["dev", "qa", "pdn", "stg", "uat", "prod"], var.environment)
    error_message = "La variable 'environment' debe ser uno de: dev, qa, pdn, stg, uat, prod."
  }
}

variable "region" {
  description = "Región de AWS donde se desplegará la infraestructura."
  type        = string
  default     = "us-east-1"
}

# -----------------------------------------------------------------------------
# Variables de Configuración del Transit Gateway
# PC-IAC-026: Configuración declarativa sin IDs hardcodeados
# -----------------------------------------------------------------------------

variable "transit_gateway_config" {
  description = <<-EOT
    Mapa de configuración para Transit Gateways.
    Los nombres se construirán dinámicamente en locals.tf.
  EOT

  type = map(object({
    description                     = optional(string, "Transit Gateway managed by Terraform")
    amazon_side_asn                 = optional(number, 64512)
    auto_accept_shared_attachments  = optional(string, "disable")
    default_route_table_association = optional(string, "enable")
    default_route_table_propagation = optional(string, "enable")
    dns_support                     = optional(string, "enable")
    vpn_ecmp_support                = optional(string, "enable")
    multicast_support               = optional(string, "disable")
    transit_gateway_cidr_blocks     = optional(list(string), [])
    additional_tags                 = optional(map(string), {})
  }))

  default = {}
}

# -----------------------------------------------------------------------------
# Tags Comunes
# PC-IAC-004: Etiquetas Transversales
# -----------------------------------------------------------------------------

variable "common_tags" {
  description = "Tags comunes aplicados a todos los recursos."
  type        = map(string)
  default     = {}
}
