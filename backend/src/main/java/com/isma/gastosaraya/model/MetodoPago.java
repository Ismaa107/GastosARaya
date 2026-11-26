package com.isma.gastosaraya.model;

/**
 * Métodos de pago que pueden añadirse en un gasto.
 */
public enum MetodoPago {

	EFECTIVO ("Efectivo"),
	TARJETA ("Tarjeta"),
	TRANSFERENCIA ("Transferencia"),
	BIZUM ("Bizum");

	private final String nombre;

	/**
	* Crea un método de pago con su texto visible.
	*
	* @param nombre texto que se muestra al usuario
	*/
	MetodoPago (String nombre) {

		this.nombre = nombre;

	}

	/**
	 * Devuelve el texto visible del método de pago.
	 *
	 * @return nombre del método de pago para mostrar
	 */
	public String getNombre () {

		return nombre;

	}

}
