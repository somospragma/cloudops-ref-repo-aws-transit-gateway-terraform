# =============================================================================
# Outputs del Módulo
# PC-IAC-007: Outputs (Salidas del Módulo)
# PC-IAC-014: Bloques Dinámicos y Splat Expressions
# =============================================================================

# -----------------------------------------------------------------------------
# Transit Gateway IDs
# PC-IAC-007: Granularidad estricta - solo IDs necesarios
# -----------------------------------------------------------------------------

output "transit_gateway_ids" {
  description = "Mapa de IDs de los Transit Gateways creados, indexado por la clave de configuración."
  value       = { for key, tgw in aws_ec2_transit_gateway.this : key => tgw.id }
}

output "transit_gateway_arns" {
  description = "Mapa de ARNs de los Transit Gateways creados, indexado por la clave de configuración."
  value       = { for key, tgw in aws_ec2_transit_gateway.this : key => tgw.arn }
}

# -----------------------------------------------------------------------------
# Transit Gateway Owner ID
# -----------------------------------------------------------------------------

output "transit_gateway_owner_ids" {
  description = "Mapa de Owner IDs de los Transit Gateways, indexado por la clave de configuración."
  value       = { for key, tgw in aws_ec2_transit_gateway.this : key => tgw.owner_id }
}

# -----------------------------------------------------------------------------
# Transit Gateway Association Default Route Table IDs
# -----------------------------------------------------------------------------

output "transit_gateway_association_default_route_table_ids" {
  description = "Mapa de IDs de las Route Tables de asociación por defecto de los Transit Gateways."
  value       = { for key, tgw in aws_ec2_transit_gateway.this : key => tgw.association_default_route_table_id }
}

output "transit_gateway_propagation_default_route_table_ids" {
  description = "Mapa de IDs de las Route Tables de propagación por defecto de los Transit Gateways."
  value       = { for key, tgw in aws_ec2_transit_gateway.this : key => tgw.propagation_default_route_table_id }
}

# -----------------------------------------------------------------------------
# Outputs Consolidados
# PC-IAC-014: Splat Expressions para extracción eficiente
# -----------------------------------------------------------------------------

output "transit_gateway_ids_list" {
  description = "Lista de todos los IDs de Transit Gateways creados."
  value       = values(aws_ec2_transit_gateway.this)[*].id
}

output "transit_gateway_arns_list" {
  description = "Lista de todos los ARNs de Transit Gateways creados."
  value       = values(aws_ec2_transit_gateway.this)[*].arn
}

# -----------------------------------------------------------------------------
# Output Completo para Debugging (Solo en desarrollo)
# -----------------------------------------------------------------------------

output "transit_gateways_summary" {
  description = "Resumen de los Transit Gateways creados con información clave."
  value = {
    for key, tgw in aws_ec2_transit_gateway.this : key => {
      id                                 = tgw.id
      arn                                = tgw.arn
      owner_id                           = tgw.owner_id
      association_default_route_table_id = tgw.association_default_route_table_id
      propagation_default_route_table_id = tgw.propagation_default_route_table_id
      amazon_side_asn                    = tgw.amazon_side_asn
      dns_support                        = tgw.dns_support
      vpn_ecmp_support                   = tgw.vpn_ecmp_support
      auto_accept_shared_attachments     = tgw.auto_accept_shared_attachments
    }
  }
}
