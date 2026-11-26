package com.isma.gastosaraya.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// @Entity: indica a JPA que esta clase representa una tabla. Cada objeto es una fila.
// @Table: nombre de la tabla, en minúsculas porque PostgreSQL guarda así los nombres.
// @Getter, @Setter y @NoArgsConstructor (Lombok): generan al compilar los getters, los
// setters y el constructor vacío, que JPA necesita para crear los objetos al leer de la BD.
/**
 * Representa una categoría fija de gasto. Las categorías son comunes a todos los
 * usuarios y se crean en la migración V2.
 */
@Entity
@Table (name = "categorias")
@Getter
@Setter
@NoArgsConstructor
public class Categoria {

	// @Id: marca la clave primaria.
	// @GeneratedValue con Identity: el Id lo genera la base de datos (BigSerial), no Java.
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Long id;

	// @Column: describe la columna. Su nombre sale del atributo: Spring lo pasa a
	// minúsculas con guiones bajos (nombre -> nombre, metodoPago -> metodo_pago).
	// Al validar, Hibernate comprueba que la columna exista y que el tipo encaje;
	// nullable, length y unique documentan en Java las reglas de la V1.
	@Column (nullable = false, length = 30, unique = true)
	private String nombre;

}
