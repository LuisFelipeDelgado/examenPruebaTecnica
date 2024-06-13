CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(255)
);

CREATE TABLE cuentas (
    id_cuenta INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    saldo DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE cheques (
    id_cheque INTEGER PRIMARY KEY,
    id_cuenta INTEGER,
    monto DECIMAL(10, 2),
    fecha_emision DATE,
    beneficiario VARCHAR(255),
    FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta)
);

CREATE TABLE prestamos (
    id_prestamo INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    monto DECIMAL(10, 2),
    fecha_otorgamiento DATE,
    plazo_meses INTEGER,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Primera consulta
SELECT 
    clientes.nombre, 
    clientes.direccion, 
    clientes.telefono, 
    cuentas.id_cuenta, 
    cuentas.saldo 
FROM 
    clientes 
JOIN 
    cuentas ON clientes.id_cliente = cuentas.id_cliente 
ORDER BY 
    clientes.nombre;

-- Segunda consulta
SELECT SUM(saldo) AS saldo_total FROM cuentas;

-- Tercera consulta
select clientes.nombre, cuentas.id_cuenta, cuentas.saldo
FROM
    clientes
JOIN
    cuentas ON clientes.id_cliente = cuentas.id_cliente
order by cuentas.saldo desc
limit 5;

-- Cuarta consulta

select cheques.id_cheque, clientes.nombre, cheques.monto, cheques.fecha_emision, cheques.beneficiario
from
    cheques
JOIN
    clientes ON cheques.id_cuenta = cuentas.id_cuenta
where
    cheques.fecha_emision >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Quinta consulta
SELECT 
    clientes.nombre, 
    SUM(cheques.monto) AS monto_total_cheques 
FROM 
    cheques 
JOIN 
    cuentas ON cheques.id_cuenta = cuentas.id_cuenta 
JOIN 
    clientes ON cuentas.id_cliente = clientes.id_cliente 
WHERE 
    cheques.fecha_emision >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY 
    clientes.nombre 
ORDER BY 
    monto_total_cheques DESC;

-- Sexta consulta
SELECT SUM(monto) AS monto_total_prestamos 
FROM prestamos 
WHERE fecha_otorgamiento >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Séptima consulta
SELECT 
    clientes.nombre, 
    SUM(prestamos.monto) AS monto_total_prestamos 
FROM 
    prestamos 
JOIN 
    clientes ON prestamos.id_cliente = clientes.id_cliente 
WHERE 
    MONTH(prestamos.fecha_otorgamiento) BETWEEN 1 AND 4 
    AND YEAR(prestamos.fecha_otorgamiento) = YEAR(CURDATE())
GROUP BY 
    clientes.nombre 
ORDER BY 
    monto_total_prestamos DESC 
LIMIT 10;