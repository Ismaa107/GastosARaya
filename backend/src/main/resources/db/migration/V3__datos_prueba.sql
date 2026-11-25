-- Datos de prueba: un usuario y sus gastos de los últimos 6 meses, para probar la API y que el dashboard tenga datos.
-- Las fechas son relativas al día en que se ejecuta la migración, así que una base de datos nueva siempre tiene datos recientes.

-- Usuario de prueba. Al ser el primero que se crea, tiene el USUARIO_ID 1 (lo usa la Fase 4 mientras no haya seguridad).
-- Contraseña: Prueba1234. Se guarda cifrada con BCrypt, igual que la aplicación al registrar a un usuario en el futuro.
INSERT INTO USUARIOS (NOMBRE, EMAIL, CONTRASENA) VALUES
	('Usuario de prueba', 'prueba@example.com', '$2a$10$ZANhRnC.dGvpZSQBZHH1vO/MAJtr7vHKa5QkxplKDo1Nu0KbLrHLO');

-- Gastos activos del usuario de prueba, ordenados de más reciente a más antiguo.
-- La categoría se busca por su nombre: se lee mejor que un número y, si el nombre está mal escrito, la migración falla.
-- CURRENT_DATE - 3 es la fecha de hace tres días: restar un número a una fecha resta días.
INSERT INTO GASTOS (USUARIO_ID, CATEGORIA_ID, NOMBRE, IMPORTE, FECHA, METODO_PAGO, DESCRIPCION) VALUES
	-- < 1 mes.
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Restaurantes'), 'Café y tostada', 3.20, CURRENT_DATE, 'EFECTIVO', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 54.80, CURRENT_DATE - 2, 'TARJETA', 'Supermercado del barrio.'),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Ocio'), 'Entradas de cine', 15.00, CURRENT_DATE - 4, 'BIZUM', 'Sesión de tarde con amigos.'),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Transporte'), 'Gasolina', 45.00, CURRENT_DATE - 6, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 61.35, CURRENT_DATE - 9, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Facturas'), 'Factura de la luz', 38.62, CURRENT_DATE - 12, 'TRANSFERENCIA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Vivienda'), 'Alquiler', 320.00, CURRENT_DATE - 20, 'TRANSFERENCIA', 'Habitación en piso compartido.'),
	-- > 1 mes, < 2 meses.
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Salud'), 'Farmacia', 12.45, CURRENT_DATE - 31, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 58.10, CURRENT_DATE - 33, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Restaurantes'), 'Cena de cumpleaños', 32.50, CURRENT_DATE - 37, 'BIZUM', 'Pago a medias con un amigo.'),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Facturas'), 'Internet y móvil', 39.90, CURRENT_DATE - 40, 'TRANSFERENCIA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Otros'), 'Regalo de cumpleaños', 25.00, CURRENT_DATE - 44, NULL, NULL),	-- Es opcional Metodo_Pago.
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 47.95, CURRENT_DATE - 48, 'EFECTIVO', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Vivienda'), 'Alquiler', 320.00, CURRENT_DATE - 50, 'TRANSFERENCIA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Educación'), 'Libros del curso', 64.30, CURRENT_DATE - 55, 'TARJETA', 'Dos libros de segunda mano.'),
	-- > 2 meses, < 3 meses.
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Transporte'), 'Abono de autobús', 20.00, CURRENT_DATE - 61, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 66.20, CURRENT_DATE - 64, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Ocio'), 'Suscripción de música', 10.99, CURRENT_DATE - 67, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Facturas'), 'Factura de la luz', 44.18, CURRENT_DATE - 70, 'TRANSFERENCIA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Ropa'), 'Zapatillas', 59.99, CURRENT_DATE - 73, 'TARJETA', 'Compradas en rebajas.'),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 52.40, CURRENT_DATE - 77, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Vivienda'), 'Alquiler', 320.00, CURRENT_DATE - 80, 'TRANSFERENCIA', NULL),
	-- > 3 meses, < 4 meses.
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Restaurantes'), 'Menú del día', 12.50, CURRENT_DATE - 92, 'EFECTIVO', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 49.75, CURRENT_DATE - 95, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Salud'), 'Dentista', 45.00, CURRENT_DATE - 99, 'TARJETA', 'Limpieza dental.'),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Facturas'), 'Internet y móvil', 39.90, CURRENT_DATE - 101, 'TRANSFERENCIA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Ocio'), 'Concierto', 28.00, CURRENT_DATE - 105, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 57.30, CURRENT_DATE - 108, 'BIZUM', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Vivienda'), 'Alquiler', 320.00, CURRENT_DATE - 110, 'TRANSFERENCIA', NULL),
	-- > 4 meses, < 5 meses.
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Educación'), 'Matrícula del curso', 180.00, CURRENT_DATE - 121, 'TRANSFERENCIA', 'Primer plazo.'),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 63.40, CURRENT_DATE - 124, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Transporte'), 'Billete de tren', 23.85, CURRENT_DATE - 128, 'TARJETA', 'Ida y vuelta.'),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Facturas'), 'Factura de la luz', 35.27, CURRENT_DATE - 131, 'TRANSFERENCIA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Ropa'), 'Chaqueta', 42.00, CURRENT_DATE - 135, 'EFECTIVO', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 55.60, CURRENT_DATE - 139, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Vivienda'), 'Alquiler', 320.00, CURRENT_DATE - 140, 'TRANSFERENCIA', NULL),
	-- > 5 meses, < 6 meses.
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Ocio'), 'Suscripción de música', 10.99, CURRENT_DATE - 152, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 50.15, CURRENT_DATE - 155, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Restaurantes'), 'Pizza a domicilio', 18.90, CURRENT_DATE - 159, 'TARJETA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Facturas'), 'Internet y móvil', 39.90, CURRENT_DATE - 162, 'TRANSFERENCIA', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Otros'), 'Corte de pelo', 14.00, CURRENT_DATE - 166, 'EFECTIVO', NULL),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Vivienda'), 'Alquiler', 320.00, CURRENT_DATE - 170, 'TRANSFERENCIA', NULL);

-- Gastos eliminados (borrado lógico): siguen en la tabla, pero los listados y los totales no deben mostrarlos.
INSERT INTO GASTOS (USUARIO_ID, CATEGORIA_ID, NOMBRE, IMPORTE, FECHA, METODO_PAGO, DESCRIPCION, ELIMINADO) VALUES
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Ocio'), 'Videojuego', 39.99, CURRENT_DATE - 3, 'TARJETA', 'Devuelto en la tienda.', TRUE),
	(1, (SELECT ID FROM CATEGORIAS WHERE NOMBRE = 'Alimentación'), 'Compra semanal', 58.10, CURRENT_DATE - 34, 'TARJETA', 'Apuntado dos veces por error.', TRUE);
