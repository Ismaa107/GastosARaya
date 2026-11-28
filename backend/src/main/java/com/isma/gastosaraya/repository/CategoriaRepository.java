package com.isma.gastosaraya.repository;

import com.isma.gastosaraya.model.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

// JpaRepository <Categoria, Long>: Spring Data genera al arrancar una clase que cumple esta interfaz,
// con los métodos básicos ya creados (findById, findAll, save, count...).
// No hace falta @Repository: Spring encuentra solo las interfaces que heredan de JpaRepository.
/**
 * Acceso a las categorías fijas en la base de datos.
 */
public interface CategoriaRepository extends JpaRepository <Categoria, Long> {

	// Consulta derivada: Spring genera el SQL a partir del nombre del método.
	// findAll + OrderByIdAsc -> SELECT ... FROM categorias ORDER BY id ASC.
	/**
	 * Obtiene todas las categorías ordenadas por su id, que es el
	 * orden en que se muestran (con "Otros" al final).
	 *
	 * @return lista de categorías ordenadas
	 */
	List <Categoria> findAllByOrderByIdAsc ();

}
