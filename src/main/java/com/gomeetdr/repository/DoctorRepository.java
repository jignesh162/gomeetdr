package com.gomeetdr.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.gomeetdr.modal.Doctor;

/**
 * The doctor repository interface. Here we can implement paging and sorting for
 * output.
 * 
 * @author parvajig
 */
public interface DoctorRepository extends PagingAndSortingRepository<Doctor, Long> {

}
