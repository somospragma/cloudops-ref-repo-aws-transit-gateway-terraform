# Changelog

Todos los cambios notables de este módulo serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2026-05-19

### Changed (BREAKING)
- `default_route_table_association` default cambiado de `"enable"` a `"disable"` para soportar routing centralizado con múltiples TGW Route Tables
- `default_route_table_propagation` default cambiado de `"enable"` a `"disable"` para control explícito de propagaciones
- `auto_accept_shared_attachments` default cambiado de `"disable"` a `"enable"` para flujo automatizado con RAM Share dentro de la Organization

### Migration
- Si usas los defaults anteriores, pasa explícitamente `default_route_table_association = "enable"` y `default_route_table_propagation = "enable"` en tu configuración

## [1.0.0] - 2026-05-19

### Added
- Creación inicial del módulo de Transit Gateway
- Soporte para múltiples Transit Gateways mediante `for_each`
- Configuración de Route Tables asociadas
- Soporte para VPC Attachments
- Configuración de Auto Accept Shared Attachments
- Soporte para DNS y ECMP
- Tags de gobernanza según PC-IAC-004
- Nomenclatura estándar según PC-IAC-003
- Hardenizado de seguridad según PC-IAC-020
