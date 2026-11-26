package com.isma.gastosaraya.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Representa un gasto registrado por un usuario.
 * Los gastos no se borran de la base de datos: se marcan como eliminados (borrado lógico).
 */
@Entity
@Table (name = "gastos")
@Getter
@Setter
@NoArgsConstructor
public class Gasto {

	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private Long id;

	// @ManyToOne: relación «muchos a uno»: muchos gastos pertenecen a un mismo usuario.
	// @JoinColumn: columna de la clave foránea en la tabla GASTOS.
	// FetchType.LAZY: el usuario no se lee de la BD hasta que se usa (carga perezosa).
	@ManyToOne (fetch = FetchType.LAZY)
	@JoinColumn (name = "usuario_id", nullable = false)
	private Usuario usuario;

	// FetchType.EAGER: la categoría se lee siempre junto con el gasto (carga inmediata).
	@ManyToOne (fetch = FetchType.EAGER)
	@JoinColumn (name = "categoria_id", nullable = false)
	private Categoria categoria;

	@Column (nullable = false, length = 50)
	private String nombre;

	// Precision y scale corresponden a numeric (12, 2): 12 dígitos en total y 2 decimales.
	@Column (nullable = false, precision = 12, scale = 2)
	private BigDecimal importe;

	@Column (nullable = false)
	private LocalDate fecha;

	@Enumerated (EnumType.STRING)
	@Column (length = 20)
	private MetodoPago metodoPago;

	@Column (length = 255)
	private String descripcion;

	// Un boolean primitivo empieza en false, igual que el default false de la V1.
	// Con un boolean, Lombok genera isEliminado () en lugar de getEliminado ().
	@Column (nullable = false)
	private boolean eliminado;

}
