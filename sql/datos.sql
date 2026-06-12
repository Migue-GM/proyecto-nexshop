-- crear tabla de categorias
create table categorias (
    id_categoria int auto_increment primary key,
    nombre varchar(100) not null unique
);

-- crear tabla de subcategorias
create table subcategorias (
    id_subcategoria int auto_increment primary key,
    nombre varchar(100) not null,
    id_categoria int,
    foreign key (id_categoria) references categorias(id_categoria)
);

-- crear tabla de productos
create table productos (
    id_producto int auto_increment primary key,
    nombre varchar(150) not null,
    descripcion text,
    pvp_actual decimal(10,2) not null,
    id_subcategoria int,
    foreign key (id_subcategoria) references subcategorias(id_subcategoria)
);

-- crear tabla de historico_precios
create table historico_precios (
    id_historico_precio int auto_increment primary key,
    id_producto int,
    precio decimal(10,2) not null,
    fecha_inicio date not null,
    fecha_fin date,
    foreign key (id_producto) references productos(id_producto)
);

-- crear tabla de promociones
create table promociones (
    id_promocion int auto_increment primary key,
    nombre varchar(100) not null,
    descuento_porcentaje decimal(5,2) not null,
    fecha_inicio date not null,
    fecha_fin date not null
);

-- tabla intermedia producto_promocion
create table producto_promocion (
    id_producto int,
    id_promocion int,
    primary key (id_producto, id_promocion),
    foreign key (id_producto) references productos(id_producto),
    foreign key (id_promocion) references promociones(id_promocion)
);

-- tabla intermedia producto_proveedor
create table producto_proveedor (
    id_producto_proveedor int auto_increment primary key,
    id_producto int,
    id_proveedor int,
    precio_coste decimal(10,2) not null,
    plazo_entrega_dias int not null,
    fecha_inicio date not null,
    fecha_fin date,
    foreign key (id_producto) references productos(id_producto),
    foreign key (id_proveedor) references proveedores(id_proveedor)
);

-- tabla intermedia de stock
create table stock (
    id_producto int,
    id_sede int,
    cantidad int default 0,
    primary key (id_producto, id_sede),
    foreign key (id_producto) references productos(id_producto),
    foreign key (id_sede) references sedes(id_sede)
);

-- crear tabla de transferencias_stock
create table transferencias_stock (
    id_transferencia int auto_increment primary key,
    id_producto int,
    id_sede_origen int,
    id_sede_destino int,
    cantidad int not null,
    fecha datetime not null,
    id_empleado_autoriza int,
    foreign key (id_producto) references productos(id_producto),
    foreign key (id_sede_origen) references sedes(id_sede),
    foreign key (id_sede_destino) references sedes(id_sede),
    foreign key (id_empleado_autoriza) references empleados(id_empleado)
);

-- crear tabla de clientes
create table clientes (
    id_cliente int auto_increment primary key,
    nombre varchar(100) not null,
    apellidos varchar(100) not null,
    email varchar(100) not null unique,
    contrasena_hash varchar(255) not null,
    fecha_nacimiento date,
    fecha_registro datetime not null
);

-- crear tabla de direcciones
create table direcciones (
    id_direccion int auto_increment primary key,
    id_cliente int,
    tipo varchar(50) default 'otra',
    calle varchar(150) not null,
    numero varchar(10) not null,
    piso varchar(10),
    codigo_postal varchar(10) not null,
    ciudad varchar(100) not null,
    pais varchar(100) default 'España',
    foreign key (id_cliente) references clientes(id_cliente)
);

-- crear tabla de pedidos_online
create table pedidos_online (
    id_pedido int auto_increment primary key,
    id_cliente int,
    id_direccion_envio int,
    fecha_pedido datetime not null,
    estado varchar(50) default 'pendiente',
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_direccion_envio) references direcciones(id_direccion)
);

-- crear tabla de lineas_pedido_online
create table lineas_pedido_online (
    id_linea_pedido int auto_increment primary key,
    id_pedido int,
    id_producto int,
    cantidad int not null,
    precio_unitario decimal(10,2) not null,
    foreign key (id_pedido) references pedidos_online(id_pedido),
    foreign key (id_producto) references productos(id_producto)
);

-- crear tabla de envios
create table envios (
    id_envio int auto_increment primary key,
    id_pedido int,
    id_sede_origen int,
    numero_seguimiento varchar(100) not null unique,
    transportista varchar(100) not null,
    fecha_estimada_entrega date,
    fecha_envio datetime,
    estado varchar(50) default 'preparando',
    foreign key (id_pedido) references pedidos_online(id_pedido),
    foreign key (id_sede_origen) references sedes(id_sede)
);

-- crear tabla de lineas_envio
create table lineas_envio (
    id_linea_envio int auto_increment primary key,
    id_envio int,
    id_linea_pedido int,
    cantidad int not null,
    foreign key (id_envio) references envios(id_envio),
    foreign key (id_linea_pedido) references lineas_pedido_online(id_linea_pedido)
);

-- crear tabla de ventas_tienda
create table ventas_tienda (
    id_venta int auto_increment primary key,
    id_sede int,
    id_empleado int,
    id_cliente int,
    fecha_venta datetime not null,
    foreign key (id_sede) references sedes(id_sede),
    foreign key (id_empleado) references empleados(id_empleado),
    foreign key (id_cliente) references clientes(id_cliente)
);

-- crear tabla de lineas_venta_tienda
create table lineas_venta_tienda (
    id_linea_venta int auto_increment primary key,
    id_venta int,
    id_producto int,
    cantidad int not null,
    precio_unitario decimal(10,2) not null,
    foreign key (id_venta) references ventas_tienda(id_venta),
    foreign key (id_producto) references productos(id_producto)
);

-- crear tabla de devoluciones_tienda
create table devoluciones_tienda (
    id_devolucion int auto_increment primary key,
    id_venta int,
    id_linea_venta int,
    cantidad int not null,
    fecha_devolucion datetime not null,
    motivo varchar(255),
    foreign key (id_venta) references ventas_tienda(id_venta),
    foreign key (id_linea_venta) references lineas_venta_tienda(id_linea_venta)
);

-- crear tabla de tickets_incidencia
create table tickets_incidencia (
    id_ticket int auto_increment primary key,
    id_cliente int,
    id_pedido int,
    id_empleado_agent int,
    asunto varchar(150) not null,
    descripcion text not null,
    tipo varchar(50) default 'consulta',
    estado varchar(50) default 'abierto',
    fecha_apertura datetime not null,
    fecha_cierre datetime,
    nota_resolucion text,
    id_envio_recogida int,
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_pedido) references pedidos_online(id_pedido),
    foreign key (id_empleado_agent) references empleados(id_empleado),
    foreign key (id_envio_recogida) references envios(id_envio)
);

-- crear tabla de valoraciones
create table valoraciones (
    id_valoracion int auto_increment primary key,
    id_cliente int,
    id_producto int,
    puntuacion int not null,
    comentario text,
    fecha datetime not null,
    verificada boolean default true,
    unique (id_cliente, id_producto),
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_producto) references productos(id_producto)
);

-- crear tabla de movimientos_puntos
create table movimientos_puntos (
    id_movimiento int auto_increment primary key,
    id_cliente int,
    id_pedido int,
    tipo varchar(50) not null,
    puntos int not null,
    fecha datetime not null,
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_pedido) references pedidos_online(id_pedido)
);
