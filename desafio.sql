-- 1. Cargar el respaldo de la base de datos unidad2.sql. (2 Puntos)

CREATE DATABASE unidad02;

psql -U postgres -d unidad02 -f unidad2.sql

-- -d entrar basedatos 
-- -f directorio 

psql -U postgres -d unidad02

-- 2. El cliente usuario01 ha realizado la siguiente compra:

-- ● producto: producto9.
-- ● cantidad: 5.
-- ● fecha: fecha del sistema.

-- Mediante el uso de transacciones, realiza las consultas correspondientes para este
-- requerimiento y luego consulta la tabla producto para validar si fue efectivamente
-- descontado en el stock. (3 Puntos)

BEGIN;
INSERT INTO compra (id, cliente_id, fecha) VALUES(33, 1, now());

INSERT INTO detalle_compra(id, producto_id, compra_id, cantidad) VALUES(43, 9, 33, 5);
UPDATE producto SET stock = stock - 5 WHERE id = 9;
SELECT stock FROM producto WHERE id=9;
COMMIT;


-- 3. El cliente usuario02 ha realizado la siguiente compra:
    -- ● producto: producto1, producto 2, producto 8.
    -- ● cantidad: 3 de cada producto.
    -- ● fecha: fecha del sistema.

    -- Mediante el uso de transacciones, realiza las consultas correspondientes para este
    -- requerimiento y luego consulta la tabla producto para validar que si alguno de ellos
    -- se queda sin stock, no se realice la compra. (3 Puntos)


BEGIN;
INSERT INTO compra (id, cliente_id, fecha) VALUES (34, 2, now());
INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad) VALUES (44, 1, 34, 3);
UPDATE producto SET stock = stock - 3 WHERE id = 1;
SELECT stock FROM producto WHERE id = 1;
SAVEPOINT producto1;

INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad) VALUES (45, 2, 34, 3);
UPDATE producto SET stock = stock - 3 WHERE id = 2;
SELECT stock FROM producto WHERE id = 2;
SAVEPOINT producto2;

INSERT INTO detalle_compra (id, producto_id, compra_id, cantidad) VALUES (46, 8, 34, 3);
SELECT stock FROM producto WHERE id = 8;

ROLLBACK;



-- 4. Realizar las siguientes consultas (2 Puntos):
    -- a. Deshabilitar el AUTOCOMMIT .

    \set AUTOCOMMIT off

    -- b. Insertar un nuevo cliente.

    INSERT INTO cliente (id, nombre, email) VALUES (11, 'usuario011',	'usuario011@hotmail.com') ;

    -- c. Confirmar que fue agregado en la tabla cliente.

    SELECT * FROM cliente;

    -- d. Realizar un ROLLBACK.

    ROLLBACK;

    -- e. Confirmar que se restauró la información, sin considerar la inserción del punto b.

    SELECT * FROM cliente;

    -- f. Habilitar de nuevo el AUTOCOMMIT.

    \set AUTOCOMMIT on

