SQL
use nexshop;

-- crear tabla de sedes
create table sedes (
    id_sede int auto_increment primary key,
    nombre varchar(100) not null,
    tipo varchar(50) not null, -- aqui usamos varchar normal en vez de cosas raras
    ciudad varchar(100) not null,
    direccion varchar(255)
);

-- crear tabla de empleados
create table empleados (
    id_empleado int auto_increment primary key,
    nombre varchar(100) not null,
    apellidos varchar(100) not null,
    dni varchar(20) not null unique,
    email_corporativo varchar(100) not null unique,
    fecha_incorporacion date not null,
    puesto varchar(100) not null,
    id_sede int,
    foreign key (id_sede) references sedes(id_sede) -- los join basicos de clase
);

-- crear tabla de proveedores
create table proveedores (
    id_proveedor int auto_increment primary key,
    nombre varchar(100) not null,
    email_contacto varchar(100),
    telefono varchar(20),
    id_empleado_representante int,
    foreign key (id_empleado_representante) references empleados(id_empleado)
);
