-- V1: esquema inicial de Gastos a Raya.
-- Crea las cuatro tablas del MVP. Una vez ejecutada, esta migración no se
-- modifica: cualquier cambio va en una migración nueva (V4, V5...).

-- Usuarios registrados en la aplicación.
CREATE TABLE USUARIOS (

	ID BIGSERIAL PRIMARY KEY,	-- Autoincremental.
	NOMBRE VARCHAR (50) NOT NULL,
	EMAIL VARCHAR (100) NOT NULL,	-- EL servicio lo guarda en minus.
	CONTRASENA VARCHAR (100) NOT NULL,	-- Hash de BCrypt (60 caracteres).
	TEMA VARCHAR (10) NOT NULL DEFAULT 'CLARO',	-- Tema de la interfaz, por defecto, claro.

	CONSTRAINT UK_USUARIOS_EMAIL UNIQUE (EMAIL),	-- No puede haber más de una cuenta con mismo email.
	CONSTRAINT CK_USUARIOS_TEMA CHECK (TEMA IN ('CLARO', 'OSCURO'))	-- Solo admite estos valores.

);

-- Categorías fijas, comunes a todos los usuarios.
-- Se rellenan en la migración V2 y la aplicación solo
-- las lee: no se crean, editan ni borran desde la API.
CREATE TABLE CATEGORIAS (

	ID BIGSERIAL PRIMARY KEY,
	NOMBRE VARCHAR (30) NOT NULL,

	CONSTRAINT UK_CATEGORIAS_NOMBRE UNIQUE (NOMBRE)	-- No puede haber dos categorías con el mismo nombre.

);

-- Gastos de cada usuario. Cada gasto pertenece a un usuario y a una categoría.
-- Borrar un gasto no lo elimina: se marca ELIMINADO = TRUE.
CREATE TABLE GASTOS (

	ID BIGSERIAL PRIMARY KEY,
	USUARIO_ID BIGINT NOT NULL,	-- Dueño del gasto: todas las consultas filtran por esta columna.
	CATEGORIA_ID BIGINT NOT NULL,	-- Obligatoria. El formulario propone «Otros».
	NOMBRE VARCHAR (50) NOT NULL,
	IMPORTE NUMERIC (12, 2) NOT NULL,	-- Decimal exacto con 2 decimales; en Java, BigDecimal.
	FECHA DATE NOT NULL,	-- Solo el día, sin hora; que no sea futura se valida en Java.
	METODO_PAGO VARCHAR (20),	-- Opcional (admite null); en Java, el enum MetodoPago.
	DESCRIPCION VARCHAR (255),	-- Opcional.
	ELIMINADO BOOLEAN NOT NULL DEFAULT FALSE,	-- Borrado lógico: true = el usuario lo ha borrado.

	CONSTRAINT FK_GASTOS_USUARIO FOREIGN KEY (USUARIO_ID) REFERENCES USUARIOS (ID),	-- El usuario tiene que existir.
	CONSTRAINT FK_GASTOS_CATEGORIA FOREIGN KEY (CATEGORIA_ID) REFERENCES CATEGORIAS (ID),	-- La categoría tiene que existir.
	CONSTRAINT CK_GASTOS_IMPORTE CHECK (IMPORTE > 0),	-- El importe siempre es positivo.
	CONSTRAINT CK_GASTOS_METODO_PAGO CHECK (METODO_PAGO IN ('EFECTIVO', 'TARJETA', 'TRANSFERENCIA', 'BIZUM'))	-- Un null también pasa: el check solo rechaza valores no válidos.

);

-- Índice para la consulta más frecuente: los gastos de un usuario
-- por fechas (listado, total del mes y dashboard).
-- PostgreSQL no crea índices solo en las claves foráneas.
CREATE INDEX IDX_GASTOS_USUARIO_FECHA ON GASTOS (USUARIO_ID, FECHA);

-- Presupuesto mensual global de cada usuario.
-- Se fija con PUT /api/presupuestos/{anio}/{mes} (si ya existe, se actualiza) y se quita
-- con DELETE, que borra la fila (borrado físico): un mes sin fila es un mes sin presupuesto.
CREATE TABLE PRESUPUESTOS (

	ID BIGSERIAL PRIMARY KEY,
	USUARIO_ID BIGINT NOT NULL,
	ANIO INTEGER NOT NULL,	-- Integer y no smallint: en Java será Integer e Hibernate valida que coincidan.
	MES INTEGER NOT NULL,	-- 1 = enero, 12 = diciembre.
	IMPORTE NUMERIC (12, 2) NOT NULL,	-- Cantidad máxima que el usuario quiere gastar ese mes.

	CONSTRAINT FK_PRESUPUESTOS_USUARIO FOREIGN KEY (USUARIO_ID) REFERENCES USUARIOS (ID),	-- El usuario tiene que existir
	CONSTRAINT UK_PRESUPUESTOS_USUARIO_ANIO_MES UNIQUE (USUARIO_ID, ANIO, MES),	-- Un solo presupuesto por usuario, año y mes.
	CONSTRAINT CK_PRESUPUESTOS_MES CHECK (MES BETWEEN 1 AND 12),	-- Solo hay 12 meses.
	CONSTRAINT CK_PRESUPUESTOS_IMPORTE CHECK (IMPORTE > 0)	-- El presupuesto siempre es positivo.

);
