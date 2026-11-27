# Requisitos – Gastos a Raya

Versión 1.0 · 19 de noviembre de 2026

Gestor de gastos personales en web, con diseño adaptable a móvil, tablet y escritorio. Cada cuenta pertenece a un solo usuario, solo se registran gastos y la aplicación funciona en español y en euros.

**Prioridades**
- **Imprescindible:** forma parte del MVP (producto mínimo viable) y es obligatoria para la entrega.
- **Deseable:** ampliación que solo se hace con el MVP terminado y probado.
- **Futura:** queda fuera del proyecto y se describe como limitación o mejora futura.

---

## 1. Requisitos funcionales

### 1.1 Usuarios y acceso

| Código | Requisito | Prioridad | Criterio de aceptación |
|---|---|---|---|
| RF-01 | Registrarse con nombre, email y contraseña | Imprescindible | No se puede usar un email ya registrado. La contraseña tiene al menos 8 caracteres y se guarda cifrada. |
| RF-02 | Iniciar sesión con email y contraseña | Imprescindible | Con datos correctos se entra al Dashboard. Con datos incorrectos aparece un mensaje que no indica qué dato ha fallado. |
| RF-03 | Cerrar sesión | Imprescindible | Después de cerrar sesión, cualquier pantalla privada lleva al inicio de sesión. |
| RF-04 | Ver y editar el perfil | Imprescindible | Se puede cambiar el nombre. El email se muestra, pero no se puede cambiar. |
| RF-05 | Elegir tema claro u oscuro | Imprescindible | El tema se aplica al momento y se mantiene en el siguiente inicio de sesión. |
| RF-06 | Acceder solo a los datos propios | Imprescindible | Un usuario no puede ver, editar ni borrar los gastos ni el presupuesto de otro. Para la API, esos datos no existen (404). |

### 1.2 Gastos y categorías

| Código | Requisito | Prioridad | Criterio de aceptación |
|---|---|---|---|
| RF-07 | Dar de alta un gasto | Imprescindible | Se cumplen las reglas de los campos (apartado 3). |
| RF-08 | Listar los gastos | Imprescindible | El listado está paginado y se puede ordenar. Por defecto salen primero los más recientes. Nunca muestra gastos eliminados. |
| RF-09 | Ver el detalle de un gasto | Imprescindible | Se muestran todos los campos del gasto. |
| RF-10 | Editar un gasto | Imprescindible | Se aplican las mismas reglas que en el alta. |
| RF-11 | Eliminar un gasto | Imprescindible | Se pide confirmación. El gasto desaparece de listados, totales, gráficos y CSV, pero se conserva en la base de datos marcado como eliminado (borrado lógico). |
| RF-12 | Clasificar cada gasto en una categoría fija | Imprescindible | Las categorías están predefinidas (entre ellas, «Otros»). El usuario elige una, pero no puede crearlas, editarlas ni borrarlas. |
| RF-13 | Filtrar por fechas, categoría e importe | Imprescindible | Se filtra por fecha desde y hasta, categoría e importe mínimo y máximo. Cada filtro funciona solo y combinado con los demás. |
| RF-14 | Buscar por texto | Imprescindible | Busca en el nombre y la descripción sin distinguir mayúsculas de minúsculas, y se combina con los filtros. |

### 1.3 Presupuesto e informes

| Código | Requisito | Prioridad | Criterio de aceptación |
|---|---|---|---|
| RF-15 | Fijar o cambiar el presupuesto mensual global | Imprescindible | El importe es mayor que 0. Hay un único presupuesto por mes; fijarlo de nuevo sustituye al anterior. |
| RF-16 | Ver el estado del presupuesto del mes | Imprescindible | Muestra el presupuesto, lo gastado, lo que queda y el porcentaje consumido, y coincide con el cálculo hecho directamente en la base de datos. Si no hay presupuesto, muestra «Aún no has fijado el presupuesto de este mes.». |
| RF-17 | Avisar al 80 % y al 100 % del presupuesto | Imprescindible | El estado es NORMAL (menos del 80 %), AVISO (desde el 80 %) o SUPERADO (desde el 100 %), con un mensaje claro en las pantallas de Presupuesto y Dashboard. |
| RF-18 | Ver el Dashboard de un mes | Imprescindible | Muestra el total del mes, el gasto por categoría (gráfico circular), la evolución de los últimos 6 meses (gráfico de barras), lo que queda del presupuesto y el aviso. |
| RF-19 | Exportar los gastos a CSV | Imprescindible | Se exportan solo los gastos que cumplen los filtros aplicados. El separador es `;` y la codificación UTF-8 con BOM, para que Excel lo abra con tildes. Las columnas son fecha, nombre, categoría, método de pago, importe y descripción. |

### 1.4 Ampliaciones y mejoras futuras

| Código | Requisito | Prioridad |
|---|---|---|
| RD-01 | Gastos recurrentes con avisos previos | Deseable |
| RD-02 | Exportar a PDF el informe mensual | Deseable |
| RD-03 | Presupuesto por categoría | Deseable |
| RD-04 | Icono propio de la aplicación (un tigre) | Deseable |
| RD-05 | Aplicación web progresiva (PWA) instalable | Pendiente de decidir |
| RFU-01 | Recuperar la contraseña | Futura (limitación) |
| RFU-02 | Renovar la sesión sin volver a iniciarla (refresh token) | Futura (limitación) |
| RFU-03 | Ingresos y balance | Futura |
| RFU-04 | Categorías personalizadas | Futura |
| RFU-05 | Varias monedas, idiomas o cuentas | Futura |
| RFU-06 | Cliente Android sobre la misma API REST | Futura |
| RFU-07 | Objetivos de ahorro, gastos compartidos y archivos adjuntos | Futura |

---

## 2. Requisitos no funcionales

| Código | Tipo | Requisito | Cómo se comprueba |
|---|---|---|---|
| RNF-01 | Seguridad | Las contraseñas se guardan cifradas con BCrypt. | En la base de datos nunca aparecen en claro. |
| RNF-02 | Seguridad | Autenticación con JWT, sin estado y con caducidad. Todo requiere token salvo el registro, el inicio de sesión y la documentación de la API. | Una petición sin token recibe 401 (prueba automática). |
| RNF-03 | Seguridad | Las contraseñas de la base de datos y la clave del JWT quedan fuera del repositorio. | El repositorio no contiene contraseñas ni claves. |
| RNF-04 | Validación | Los datos se validan en el frontend (Zod) y en el backend (Bean Validation). La validación que decide es la del backend. | Un importe negativo enviado directamente a la API devuelve 400 con un mensaje claro. |
| RNF-05 | Mensajes | Todos los mensajes están en español, tratan de tú y terminan en punto. Los errores de la API tienen siempre el mismo formato JSON. | Un importe inválido, un presupuesto superado y un servidor caído muestran un mensaje comprensible. |
| RNF-06 | Integridad | Las reglas de los datos se aplican también en la base de datos: claves foráneas, email único, importe mayor que 0, importes con `NUMERIC (12, 2)` y un presupuesto por usuario y mes. | Se detallan en `docs/03-modelo-datos.md`. |
| RNF-07 | Usabilidad | Importes con formato español (1.234,56 €) y fechas dd/mm/aaaa. Cada pantalla indica si está cargando, si no hay datos o si se ha producido un error. | Revisión de cada pantalla, también con el backend apagado. |
| RNF-08 | Diseño adaptable | La aplicación se usa bien en móvil (360 px), tablet (768 px) y escritorio (1366 px o más). | Vista de dispositivo del navegador y, si es posible, un móvil real. |
| RNF-09 | Accesibilidad | Lighthouse da 90 o más en accesibilidad en las pantallas principales, con los dos temas. | Informe de Lighthouse de cada pantalla. |
| RNF-10 | Compatibilidad | Funciona en Chrome, Firefox y Edge en Windows 11, y en Chrome y Firefox en Linux Mint. | Pruebas manuales en cada combinación. |
| RNF-11 | Rendimiento | Los listados están paginados, la búsqueda filtra antes por usuario y los totales se calculan en la base de datos (SUM y GROUP BY). | Los totales se obtienen con una sola consulta y coinciden con el cálculo hecho a mano. |
| RNF-12 | Mantenibilidad | Arquitectura en capas con DTOs, código según la guía de estilo y API documentada con Swagger y una colección de Postman. | Revisión del código y de la documentación de la API. |
| RNF-13 | Pruebas | Pruebas unitarias (JUnit y Mockito) y pruebas de integración y de autorización. | `mvn test` termina sin errores. |
| RNF-14 | Despliegue | La base de datos se levanta con Docker Compose y un README explica cómo arrancar la aplicación. | Siguiendo solo el README, la aplicación arranca en otro equipo. |

---

## 3. Campos del gasto

| Campo | Obligatorio | Reglas |
|---|---|---|
| Nombre | Sí | Como mucho 50 caracteres. |
| Importe | Sí | Mayor que 0, en euros, con 2 decimales como máximo y hasta 9.999.999.999,99 €. |
| Fecha | Sí | No puede ser futura. El formulario la trae rellenada con el día de hoy. |
| Categoría | Sí | Una de las categorías fijas. El formulario trae «Otros» seleccionada. |
| Método de pago | No | Efectivo, Tarjeta, Transferencia o Bizum. |
| Descripción | No | Como mucho 255 caracteres. |

---

## 4. MVP

El MVP lo forman los 19 requisitos funcionales imprescindibles (RF-01 a RF-19) y los 14 no funcionales (RNF-01 a RNF-14). Cubren todas las funcionalidades obligatorias del proyecto:

| Funcionalidad obligatoria | Requisitos |
|---|---|
| Alta, edición y eliminación de gastos | RF-07, RF-10 y RF-11 |
| Categorías | RF-12 |
| Filtros | RF-13 y RF-14 |
| Presupuestos | RF-15, RF-16 y RF-17 |
| Gráficos | RF-18 |
| Exportación a CSV | RF-19 |
| Acceso por usuario | RF-01, RF-02 y RF-06 |

Las ampliaciones (RD) solo se abordan con el MVP terminado y probado. Las mejoras futuras (RFU) no se implementan. La falta de recuperación de contraseña y de renovación de la sesión son limitaciones asumidas.
