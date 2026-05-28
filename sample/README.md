# Ejemplo de Uso del Módulo Transit Gateway

Este directorio contiene un ejemplo funcional de cómo consumir el módulo de Transit Gateway siguiendo las reglas PC-IAC.

## Estructura

```
sample/
├── README.md           # Este archivo
├── data.tf             # Data sources para obtener IDs dinámicos
├── locals.tf           # Transformaciones e inyección de valores
├── main.tf             # Invocación del módulo padre
├── outputs.tf          # Outputs del ejemplo
├── providers.tf        # Configuración del provider
├── terraform.tfvars    # Valores de configuración
└── variables.tf        # Variables de entrada
```

## Patrón de Flujo de Datos (PC-IAC-026)

```
terraform.tfvars → variables.tf → data.tf → locals.tf → main.tf → ../
```

## Ejecución

1. Configurar credenciales de AWS
2. Revisar y ajustar `terraform.tfvars`
3. Ejecutar:

```bash
terraform init
terraform plan
terraform apply
```

## Requisitos Previos

- Terraform >= 1.0.0
- AWS CLI configurado
- Permisos IAM para crear Transit Gateways

## Notas

- Este ejemplo usa estado local (no configurado backend S3)
- Los valores en `terraform.tfvars` son de ejemplo
- Ajustar el ASN según los requisitos de red
