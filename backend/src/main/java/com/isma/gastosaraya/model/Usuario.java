package com.isma.gastosaraya.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Representa una cuenta de usuario de la aplicación.
 * La contraseña se guarda siempre como hash de BCrypt, nunca en claro.
 */
@Entity
@Table (name = "usuarios")
@Getter
@Setter
@NoArgsConstructor
public class Usuario {

	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Long id;

	@Column (nullable = false, length = 50)
	private String nombre;

	@Column (nullable = false, length = 100, unique = true)
	private String email;

	@Column (nullable = false, length = 100)
	private String contrasena;

	// @Enumerated (EnumType.STRING): guarda el enum como texto ("CLARO").
	// Sin él, JPA guardaría su posición (0, 1), que cambiaría si algún día se reordenan las constantes.
	// El valor inicial hace falta porque Hibernate envía todas las columnas en el insert:
	// el default 'CLARO' de la V1 nunca llegaría a usarse y fallaría el not null.
	@Enumerated (EnumType.STRING)
	@Column (nullable = false, length = 10)
	private Tema tema = Tema.CLARO;

}
