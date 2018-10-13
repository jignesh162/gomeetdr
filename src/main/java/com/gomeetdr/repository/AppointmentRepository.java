package com.gomeetdr.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.gomeetdr.modal.Appointment;

/**
 * The appointment repository interface. Here we can implement paging and
 * sorting for output.
 * 
 * @author parvajig
 */
public interface AppointmentRepository extends PagingAndSortingRepository<Appointment, Long> {

}
