# proyecto-nexshop
## Descripción del proyecto

Este repositorio contiene el diseño y la implementación de la base de datos de NexShop Group S.A., una empresa de distribución y venta al por menor que opera una tienda online nexshop.es y tres tiendas físicas en Valencia, Madrid y Barcelona, compartiendo un mismo catálogo de productos. El modelo cubre catálogo de productos (categorías, subcategorías, precios y promociones), proveedores, gestión de stock y transferencias, clientes y direcciones, pedidos online, ventas presenciales, devoluciones, tickets de atención al cliente, sistema de valoraciones y programa de fidelización.

## Estructura del repositorio

```text
proyecto-nexshop/
├── README.md
├── docs/
│   ├── memoria.md            <- Memoria de análisis y preguntas de reflexión
│   ├── diagrama_er.mmd       <- Diagrama Entidad-Relación (formato Mermaid)
│   └── modelo_relacional.md  <- Modelo relacional (PKs, FKs, restricciones)
├── sql/
│   ├── schema.sql            <- CREATE TABLE, restricciones y FKs
│   └── datos.sql             <- INSERT con datos de prueba
└── consultas/
    └── consultas.sql         <- Las 14 consultas comentadas (+ extras)
