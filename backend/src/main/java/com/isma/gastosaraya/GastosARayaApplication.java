package com.isma.gastosaraya;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// @SpringBootApplication: marca la clase de arranque de Spring Boot. Activa la
// configuración automática y busca los componentes (@Service, @Controller...)
// en este paquete y en sus subpaquetes.
/**
 * Clase principal de Gastos a Raya: solo arranca la aplicación.
 */
@SpringBootApplication
public class GastosARayaApplication {

	/**
	 * Punto de entrada de la aplicación.
	 *
	 * @param args argumentos de la línea de comandos
	 */
	public static void main (String [] args) {

		SpringApplication.run (GastosARayaApplication.class, args);

	}

}
