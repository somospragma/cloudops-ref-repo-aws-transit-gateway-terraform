# =============================================================================
# Outputs del Ejemplo
# PC-IAC-007: Outputs (Salidas del Módulo)
# =============================================================================

# -----------------------------------------------------------------------------
# Transit Gateway IDs
# -----------------------------------------------------------------------------

output "transit_gateway_ids" {
  description = "Mapa de IDs de los Transit Gateways creados."
  value       = module.transit_gateway.transit_gateway_ids
}

output "transit_gateway_arns" {
  description = "Mapa de ARNs de los Transit Gateways creados."
  value       = module.transit_gateway.transit_gateway_arns
}

# -----------------------------------------------------------------------------
# Route Table IDs
# -----------------------------------------------------------------------------

output "transit_gateway_association_default_route_table_ids" {
  description = "IDs de las Route Tables de asociación por defecto."
  value       = module.transit_gateway.transit_gateway_association_default_route_table_ids
}

output "transit_gateway_propagation_default_route_table_ids" {
  description = "IDs de las Route Tables de propagación por defecto."
  value       = module.transit_gateway.transit_gateway_propagation_default_route_table_ids
}

# -----------------------------------------------------------------------------
# Resumen Completo
# -----------------------------------------------------------------------------

output "transit_gateways_summary" {
  description = "Resumen completo de los Transit Gateways creados."
  value       = module.transit_gateway.transit_gateways_summary
}

# -----------------------------------------------------------------------------
# Información de Contexto
# -----------------------------------------------------------------------------

output "context_info" {
  description = "Información de contexto del despliegue."
  value = {
    region     = data.aws_region.current.id
    account_id = data.aws_caller_identity.current.account_id
  }
}
