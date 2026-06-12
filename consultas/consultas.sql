use nexshop;

-- consulta 1: mostrar todos los empleados
select * from empleados;

-- consulta 2: mostrar solo el nombre y el email de los clientes
select nombre, email from clientes;

-- consulta 3: mostrar los pedidos que estan pendientes
select * from pedidos_online where estado = 'pendiente';

-- consulta 4: buscar productos que tengan la palabra portatil en el nombre
select * from productos where nombre like '%portatil%';

-- consulta 5: buscar clientes que su nombre empiece por la letra a
select * from clientes where nombre like 'a%';

-- consulta 6: ver los pedidos realizados entre estas dos fechas
select * from pedidos_online where fecha_pedido between '2026-04-01' and '2026-04-30';

-- consulta 7: productos con un precio entre 50 y 200 euros
select * from productos where pvp_actual between 50 and 200;

-- consulta 8: ver las lineas de pedido con cantidad mayor que 1
select * from lineas_pedido_online where cantidad > 1;

-- consulta 9: ordenar los pedidos del mas viejo al mas nuevo
select * from pedidos_online order by fecha_pedido asc;

-- consulta 10: ordenar los productos del mas caro al mas barato
select * from productos order by pvp_actual desc;

-- consulta 11: ordenar a los clientes por su nombre de la a a la z
select * from clientes order by nombre asc;

-- consulta 12: cambiar el estado de un pedido concreto a entregado
update pedidos_online set estado = 'entregado' where id_pedido = 3;

-- consulta 13: cambiar el telefono de un cliente usando su id
update clientes set telefono = '600123456' where id_cliente = 2;

-- consulta 14: juntar la tabla clientes y pedidos para ver los datos de ambos
select clientes.nombre, pedidos_online.id_pedido, pedidos_online.fecha_pedido
from clientes 
join pedidos_online on clientes.id_cliente = pedidos_online.id_cliente;
