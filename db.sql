

SELECT * FROM detalle_facturas;
SELECT * FROM existencias;
SELECT * FROM facturas;
SELECT * FROM productos;


DROP TABLE IF EXISTS detalle_facturas;
DROP TABLE IF EXISTS existencias;
DROP TABLE IF EXISTS facturas;
DROP TABLE IF EXISTS productos;

CREATE TABLE facturas (
    id SERIAL PRIMARY KEY,
    rut_comprador VARCHAR(12),
    rut_vendedor VARCHAR(12)
);

CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion VARCHAR(255)
);

CREATE TABLE detalle_facturas (
    id SERIAL PRIMARY KEY,
    id_producto INTEGER,
    id_factura INTEGER,
    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id),
    CONSTRAINT fk_detalle_factura
        FOREIGN KEY (id_factura)
        REFERENCES facturas(id)
);

CREATE TABLE existencias (
    id SERIAL PRIMARY KEY,
    id_producto INTEGER,
    cantidad INTEGER,
    precio INTEGER,
    pesoKg INTEGER,
    CONSTRAINT fk_existencias_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id)
);


INSERT INTO productos (nombre, descripcion) VALUES
('Arroz', 'Arroz grano largo'),
('Fideos', 'Fideos spaghetti'),
('Azúcar', 'Azúcar blanca'),
('Sal', 'Sal fina'),
('Aceite', 'Aceite vegetal'),
('Leche', 'Leche entera'),
('Pan', 'Pan corriente'),
('Queso', 'Queso gouda'),
('Jamón', 'Jamón de pavo'),
('Mantequilla', 'Mantequilla sin sal');

-- =====================================
-- P3. INSERTAR EXISTENCIAS
-- =====================================

INSERT INTO existencias (id_producto, cantidad, precio, pesoKg) VALUES
(1, 20, 1200, 1),
(2, 20, 900, 1),
(3, 20, 1100, 1),
(4, 20, 500, 1),
(5, 20, 2500, 1),
(6, 20, 1000, 1),
(7, 20, 800, 1),
(8, 20, 3200, 1),
(9, 20, 2800, 1),
(10, 20, 2100, 1);


INSERT INTO facturas (rut_comprador, rut_vendedor) VALUES
('11111111-1', '22222222-2'),
('33333333-3', '22222222-2'),
('44444444-4', '55555555-5'),
('66666666-6', '77777777-7'),
('88888888-8', '99999999-9');

-- =====================================
-- P5. DETALLE FACTURAS
-- =====================================

INSERT INTO detalle_facturas (id_factura, id_producto) VALUES
(1, 1),
(1, 3),
(1, 5),

(2, 2),
(2, 4),
(2, 6),
(2, 7),

(3, 1),
(3, 8),
(3, 9),

(4, 3),
(4, 5),
(4, 10),
(4, 6),

(5, 2),
(5, 4),
(5, 7);

UPDATE existencias
SET cantidad = 10;

ALTER TABLE facturas
ADD COLUMN fecha DATE;

UPDATE facturas SET fecha = '2025-01-01' WHERE id = 1;
UPDATE facturas SET fecha = '2025-01-02' WHERE id = 2;
UPDATE facturas SET fecha = '2025-01-03' WHERE id = 3;
UPDATE facturas SET fecha = '2025-01-04' WHERE id = 4;
UPDATE facturas SET fecha = '2025-01-05' WHERE id = 5;

ALTER TABLE existencias
DROP COLUMN pesoKg;

SELECT
    f.id AS factura,
    f.rut_comprador,
    p.nombre,
    e.precio
FROM facturas f
JOIN detalle_facturas d ON f.id = d.id_factura
JOIN productos p ON d.id_producto = p.id
JOIN existencias e ON p.id = e.id_producto
WHERE f.id = 1;

SELECT
    f.id AS factura,
    SUM(e.precio) AS total
FROM facturas f
JOIN detalle_facturas d ON f.id = d.id_factura
JOIN existencias e ON d.id_producto = e.id_producto
WHERE f.id = 1
GROUP BY f.id;

DELETE FROM detalle_facturas;
DELETE FROM existencias;
DELETE FROM productos;