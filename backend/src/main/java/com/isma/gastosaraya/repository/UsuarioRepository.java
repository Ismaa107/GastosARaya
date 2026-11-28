package com.isma.gastosaraya.repository;

import com.isma.gastosaraya.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Acceso a los usuarios en la base de datos.
 */
public interface UsuarioRepository extends JpaRepository <Usuario, Long> {

}
