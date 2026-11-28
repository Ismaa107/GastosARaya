package com.isma.gastosaraya.repository;

import com.isma.gastosaraya.model.Gasto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface GastoRepository extends JpaRepository <Gasto, Long> {

	/**
	 * Obtiene los gastos activos de un usuario, del más reciente al más antiguo.
	 * ???En el paso 6.1 se sustituirá por una consulta con filtros y páginas.???
	 *
	 * @param usuarioId id del usuario
	 * @return lista de gastos no eliminados del usuario
	 */
	List <Gasto> findByUsuarioIdAndEliminadoFalseOrderByFechaDesc (Long usuarioId);

	// Optional: un contenedor que puede tener un gasto o estar vacío.
	// En el servicio se usa .orElse (null) y una cláusula de guarda (comprobación al inicio
	// de un método que corta su ejecución con una excepción si no se cumple una condición).
	/**
	 * Busca un gasto activo que pertenezca al usuario indicado.
	 *
	 * @param id id del gasto
	 * @param usuarioId id del usuario propietario del gasto
	 * @return gasto o vacío si no existe, está eliminado o es de otro usuario
	 */
	Optional <Gasto> findByIdAndUsuarioIdAndEliminadoFalse (Long id, Long usuarioId);

}
