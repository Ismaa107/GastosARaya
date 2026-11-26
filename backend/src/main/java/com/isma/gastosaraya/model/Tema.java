package com.isma.gastosaraya.model;

/**
 * Temas visuales que puede elegir el usuario en su perfil.
 */
public enum Tema {

	CLARO ("Claro"),
	OSCURO ("Oscuro");

	private final String nombre;

	/**
	 * Crea un tema con su texto visible.
	 *
	 * @param nombre texto que se muestra al usuario
	 */
	Tema (String nombre) {

		this.nombre = nombre;

	}

	/**
	 * Devuelve el texto visible del tema.
	 *
	 * @return nombre del tema para mostrar
	 */
	public String getNombre () {

		return nombre;

	}

}
