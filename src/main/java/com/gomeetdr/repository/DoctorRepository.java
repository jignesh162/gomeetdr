package com.gomeetdr.repository;

import org.springframework.data.repository.CrudRepository;

import com.gomeetdr.modal.Doctor;

/**
 * The doctor repository interface.
 * 
 * @author parvajig
 */
public interface DoctorRepository extends CrudRepository<Doctor, Long> {

}
