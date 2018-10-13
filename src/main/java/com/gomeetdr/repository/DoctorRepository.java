package com.gomeetdr.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.gomeetdr.modal.Doctor;

public interface DoctorRepository extends PagingAndSortingRepository<Doctor, Long> {

}
