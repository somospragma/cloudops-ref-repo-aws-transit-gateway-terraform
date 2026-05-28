# =============================================================================
# Recursos Principales del Módulo - Transit Gateway
# PC-IAC-010: For_Each y Control de Recursos
# PC-IAC-020: Gobernanza General de Seguridad (Hardenizado)
# PC-IAC-023: Diseño Monolítico Funcional (Responsabilidad Única)
# =============================================================================

# -----------------------------------------------------------------------------
# Transit Gateway
# PC-IAC-005: Referencia explícita al alias consumidor aws.project
# PC-IAC-010: Uso mandatorio de for_each para colecciones
# PC-IAC-020: Hardenizado de seguridad por defecto
# -----------------------------------------------------------------------------

resource "aws_ec2_transit_gateway" "this" {
  # PC-IAC-010: for_each con map para estabilidad del estado
  for_each = local.transit_gateways_processed

  # PC-IAC-005: Referencia explícita al provider
  provider = aws.project

  # Configuración básica
  description = each.value.description

  # Configuración de ASN para BGP
  amazon_side_asn = each.value.amazon_side_asn

  # PC-IAC-020: Configuración de seguridad y gobernanza
  # Auto accept shared attachments - deshabilitado por defecto para control
  auto_accept_shared_attachments = each.value.auto_accept_shared_attachments

  # Configuración de Route Tables
  default_route_table_association = each.value.default_route_table_association
  default_route_table_propagation = each.value.default_route_table_propagation

  # Soporte DNS - habilitado por defecto para resolución de nombres
  dns_support = each.value.dns_support

  # Soporte ECMP para VPN - habilitado por defecto para alta disponibilidad
  vpn_ecmp_support = each.value.vpn_ecmp_support

  # Soporte Multicast
  multicast_support = each.value.multicast_support

  # CIDR blocks para el Transit Gateway (opcional)
  transit_gateway_cidr_blocks = length(each.value.transit_gateway_cidr_blocks) > 0 ? each.value.transit_gateway_cidr_blocks : null

  # PC-IAC-004: Tags con merge de Name + base + additional
  tags = each.value.tags

  # PC-IAC-010: Protección contra destrucción accidental
  lifecycle {
    prevent_destroy = false # Cambiar a true en producción

    # Ignorar cambios en tags gestionados externamente si es necesario
    ignore_changes = []
  }
}

# -----------------------------------------------------------------------------
# Transit Gateway Route Table (Default adicional si se requiere)
# Solo se crea si se necesitan route tables adicionales
# -----------------------------------------------------------------------------

# Nota: El Transit Gateway crea automáticamente una route table por defecto.
# Este recurso permite crear route tables adicionales si se requieren.
# Para route tables adicionales, se debe extender este módulo o crear
# un módulo separado siguiendo PC-IAC-023 (Responsabilidad Única).
