package com.gomeetdr.repository;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.gomeetdr.modal.Appointment;

public interface AppointmentRepository extends PagingAndSortingRepository<Appointment, Long> {

}
