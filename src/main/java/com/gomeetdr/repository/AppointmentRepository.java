package com.gomeetdr.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.gomeetdr.modal.Appointment;

/**
 * The appointment repository interface.
 * 
 * @author parvajig
 */
public interface AppointmentRepository extends CrudRepository<Appointment, Long> {
	
	/**
	 * Delete all appointments by doctor id
	 * 
	 * @param id The id of doctor
	 */
	@Modifying
    @Transactional
    @Query("DELETE FROM Appointment WHERE doctor.id = ?")
	void deleteAppointmentsByDrId(Long id);
	
	/**
	 * Count number of appointments by doctor id
	 * 
	 * @param id The id of doctor
	 */
    @Query("SELECT COUNT(a) FROM Appointment a WHERE doctor.id = ?")
	Long countAppointmentsByDrId(Long id);
}
