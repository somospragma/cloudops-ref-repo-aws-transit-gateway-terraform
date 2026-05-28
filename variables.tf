# =============================================================================
# Variables de Entrada del Módulo
# PC-IAC-002: Variables Obligatorias y Buenas Prácticas de Declaración
# PC-IAC-009: Tipos de Datos, Conversiones y Lógica en Locals
# PC-IAC-016: Manejo de Secretos y Datos Sensibles
# =============================================================================

# -----------------------------------------------------------------------------
# Variables de Gobernanza (Obligatorias)
# PC-IAC-002: Variables de Control Globales
# -----------------------------------------------------------------------------

variable "client" {
  description = "Nombre del cliente o unidad de negocio. Usado para nomenclatura y tagging."
  type        = string

  validation {
    condition     = length(var.client) > 0 && length(var.client) <= 10
    error_message = "La variable 'client' debe tener entre 1 y 10 caracteres."
  }

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.client))
    error_message = "La variable 'client' solo puede contener letras minúsculas y números."
  }
}

variable "project" {
  description = "Nombre del proyecto. Usado para nomenclatura y tagging."
  type        = string

  validation {
    condition     = length(var.project) > 0 && length(var.project) <= 15
    error_message = "La variable 'project' debe tener entre 1 y 15 caracteres."
  }

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.project))
    error_message = "La variable 'project' solo puede contener letras minúsculas y números."
  }
}

variable "environment" {
  description = "Entorno de despliegue (dev, qa, pdn)."
  type        = string

  validation {
    condition     = contains(["dev", "qa", "pdn", "stg", "uat", "prod"], var.environment)
    error_message = "La variable 'environment' debe ser uno de: dev, qa, pdn, stg, uat, prod."
  }
}

# -----------------------------------------------------------------------------
# Variable de Configuración Principal
# PC-IAC-002: Estabilidad para for_each con map(object)
# PC-IAC-009: Tipificación Explícita
# -----------------------------------------------------------------------------

variable "transit_gateway_config" {
  description = <<-EOT
    Mapa de configuración para Transit Gateways.
    Cada clave representa un Transit Gateway único.
    
    Atributos:
    - name: Nombre del Transit Gateway (ya construido con nomenclatura estándar desde el Root)
    - description: Descripción del Transit Gateway
    - amazon_side_asn: ASN de Amazon para BGP (64512-65534 o 4200000000-4294967294)
    - auto_accept_shared_attachments: Aceptar automáticamente attachments compartidos
    - default_route_table_association: Asociar attachments a la route table por defecto
    - default_route_table_propagation: Propagar rutas a la route table por defecto
    - dns_support: Habilitar soporte DNS
    - vpn_ecmp_support: Habilitar ECMP para conexiones VPN
    - multicast_support: Habilitar soporte multicast
    - transit_gateway_cidr_blocks: Bloques CIDR para el Transit Gateway
    - additional_tags: Tags adicionales específicos del recurso
  EOT

  type = map(object({
    name                            = string
    description                     = optional(string, "Transit Gateway managed by Terraform")
    amazon_side_asn                 = optional(number, 64512)
    auto_accept_shared_attachments  = optional(string, "enable")
    default_route_table_association = optional(string, "disable")
    default_route_table_propagation = optional(string, "disable")
    dns_support                     = optional(string, "enable")
    vpn_ecmp_support                = optional(string, "enable")
    multicast_support               = optional(string, "disable")
    transit_gateway_cidr_blocks     = optional(list(string), [])
    additional_tags                 = optional(map(string), {})
  }))

  default = {}

  validation {
    condition = alltrue([
      for key, config in var.transit_gateway_config :
      length(config.name) > 0
    ])
    error_message = "Cada Transit Gateway debe tener un nombre definido."
  }

  validation {
    condition = alltrue([
      for key, config in var.transit_gateway_config :
      config.amazon_side_asn >= 64512 && config.amazon_side_asn <= 65534 ||
      config.amazon_side_asn >= 4200000000 && config.amazon_side_asn <= 4294967294
    ])
    error_message = "El ASN debe estar en el rango 64512-65534 o 4200000000-4294967294."
  }

  validation {
    condition = alltrue([
      for key, config in var.transit_gateway_config :
      contains(["enable", "disable"], config.auto_accept_shared_attachments)
    ])
    error_message = "auto_accept_shared_attachments debe ser 'enable' o 'disable'."
  }

  validation {
    condition = alltrue([
      for key, config in var.transit_gateway_config :
      contains(["enable", "disable"], config.dns_support)
    ])
    error_message = "dns_support debe ser 'enable' o 'disable'."
  }

  validation {
    condition = alltrue([
      for key, config in var.transit_gateway_config :
      contains(["enable", "disable"], config.vpn_ecmp_support)
    ])
    error_message = "vpn_ecmp_support debe ser 'enable' o 'disable'."
  }
}
