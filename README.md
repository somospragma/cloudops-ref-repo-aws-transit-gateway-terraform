# Transit Gateway Module

Módulo de Terraform para la creación y gestión de AWS Transit Gateways siguiendo las reglas de gobernanza PC-IAC.

## Descripción

AWS Transit Gateway es un hub de tránsito de red que permite interconectar VPCs y redes on-premises. Este módulo implementa la creación de Transit Gateways con las mejores prácticas de seguridad y gobernanza definidas en las reglas PC-IAC.

## Características

- Creación de múltiples Transit Gateways mediante `for_each`
- Configuración de ASN para BGP
- Soporte para DNS y ECMP
- Control de auto-accept para attachments compartidos
- Route tables por defecto configurables
- Soporte para multicast (opcional)
- Tags de gobernanza automáticos

## Uso

```hcl
module "transit_gateway" {
  source = "git::https://github.com/org/transit-gateway-module.git?ref=v1.0.0"

  providers = {
    aws.project = aws.principal
  }

  # Variables de gobernanza
  client      = var.client
  project     = var.project
  environment = var.environment

  # Configuración de Transit Gateways
  transit_gateway_config = local.transit_gateway_config_transformed
}
```

## Inputs

| Nombre | Descripción | Tipo | Requerido |
|--------|-------------|------|-----------|
| `client` | Nombre del cliente o unidad de negocio | `string` | Sí |
| `project` | Nombre del proyecto | `string` | Sí |
| `environment` | Entorno de despliegue (dev, qa, pdn) | `string` | Sí |
| `transit_gateway_config` | Mapa de configuración de Transit Gateways | `map(object)` | No |

### Estructura de `transit_gateway_config`

```hcl
transit_gateway_config = {
  "main" = {
    name                            = "pragma-ecommerce-dev-tgw-main"
    description                     = "Transit Gateway principal"
    amazon_side_asn                 = 64512
    auto_accept_shared_attachments  = "disable"
    default_route_table_association = "enable"
    default_route_table_propagation = "enable"
    dns_support                     = "enable"
    vpn_ecmp_support                = "enable"
    multicast_support               = "disable"
    transit_gateway_cidr_blocks     = []
    additional_tags                 = {}
  }
}
```

## Outputs

| Nombre | Descripción |
|--------|-------------|
| `transit_gateway_ids` | Mapa de IDs de Transit Gateways |
| `transit_gateway_arns` | Mapa de ARNs de Transit Gateways |
| `transit_gateway_owner_ids` | Mapa de Owner IDs |
| `transit_gateway_association_default_route_table_ids` | IDs de Route Tables de asociación |
| `transit_gateway_propagation_default_route_table_ids` | IDs de Route Tables de propagación |
| `transit_gateway_ids_list` | Lista de IDs |
| `transit_gateway_arns_list` | Lista de ARNs |
| `transit_gateways_summary` | Resumen completo de Transit Gateways |

## Requisitos

| Nombre | Versión |
|--------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.31.0 |

## Cumplimiento de Reglas PC-IAC

| Regla | Descripción | Implementación |
|-------|-------------|----------------|
| PC-IAC-001 | Estructura de Módulo | Estructura completa con todos los archivos obligatorios |
| PC-IAC-002 | Variables | Variables con type, description y validation |
| PC-IAC-003 | Nomenclatura | Nombre construido en el Root e inyectado al módulo |
| PC-IAC-004 | Tagging | Tags base + Name + additional_tags mediante merge |
| PC-IAC-005 | Providers | Alias aws.project con referencia explícita |
| PC-IAC-006 | Versiones | required_version y required_providers definidos |
| PC-IAC-007 | Outputs | Outputs granulares (IDs, ARNs) con description |
| PC-IAC-010 | For_Each | Uso de for_each con map para estabilidad |
| PC-IAC-020 | Hardenizado | auto_accept deshabilitado por defecto |
| PC-IAC-023 | Responsabilidad Única | Solo recursos intrínsecos al Transit Gateway |

## Decisiones de Diseño

### Seguridad (PC-IAC-020)

- **Auto Accept Shared Attachments**: Deshabilitado por defecto (`disable`) para requerir aprobación explícita de attachments compartidos, siguiendo el principio de mínimo privilegio.
- **DNS Support**: Habilitado por defecto para permitir resolución de nombres entre VPCs conectadas.
- **VPN ECMP Support**: Habilitado por defecto para alta disponibilidad en conexiones VPN.

### Responsabilidad Única (PC-IAC-023)

Este módulo solo crea el recurso `aws_ec2_transit_gateway`. Los siguientes recursos deben gestionarse en módulos separados o en el dominio correspondiente:

- **VPC Attachments**: Deben crearse en el dominio Networking
- **VPN Attachments**: Deben crearse en el dominio Networking
- **Route Tables adicionales**: Pueden extenderse en este módulo o crear módulo separado
- **RAM Shares**: Deben gestionarse en el dominio de Seguridad/Gobernanza

### Nomenclatura (PC-IAC-003, PC-IAC-025)

El nombre del Transit Gateway debe ser construido en el Módulo Raíz (Root) siguiendo el patrón:

```
{client}-{project}-{environment}-tgw-{key}
```

Ejemplo: `pragma-ecommerce-dev-tgw-main`

## Ejemplo de Uso Completo

Ver el directorio `sample/` para un ejemplo funcional completo que demuestra:

- Configuración de variables en `terraform.tfvars`
- Transformación de configuración en `locals.tf`
- Invocación del módulo en `main.tf`

## Recursos Creados

- `aws_ec2_transit_gateway` - Transit Gateway principal

## Consideraciones

1. **ASN**: El ASN de Amazon debe estar en el rango 64512-65534 o 4200000000-4294967294
2. **Límites**: Revisar los límites de servicio de Transit Gateway en la región
3. **Costos**: Se cobra por hora de attachment y por GB de datos procesados
4. **Multi-región**: Para conectar Transit Gateways entre regiones, usar Transit Gateway Peering

## Referencias

- [AWS Transit Gateway Documentation](https://docs.aws.amazon.com/vpc/latest/tgw/)
- [Terraform AWS Provider - Transit Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
