-- V2: categorías fijas, comunes para todos los usuarios.
-- Ni se crean, ni se editan, ni se borran desde la aplicación.
-- Se listan por ID, orden en que aparecen: alfabético y con "Otros" al final.
INSERT INTO CATEGORIAS (NOMBRE) VALUES
	('Alimentación'),
	('Educación'),
	('Facturas'),	-- Luz, agua, gas, internet y móvil.
	('Ocio'),
	('Restaurantes'),	-- Restaurantes, bares y comida a domicilio.
	('Ropa'),
	('Salud'),
	('Transporte'),
	('Vivienda'),	-- Alquiler o hipoteca, comunidad y reparaciones.
	('Otros');	-- Categoría preseleccionada en el formulario.
