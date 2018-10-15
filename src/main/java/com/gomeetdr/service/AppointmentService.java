package com.gomeetdr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gomeetdr.modal.Appointment;
import com.gomeetdr.repository.AppointmentRepository;
import com.gomeetdr.utils.NotFoundException;

/**
 * The rest service for the appointments.
 * 
 * @author parvajig
 *
 */
@Service
public class AppointmentService {

	@Autowired
	private AppointmentRepository appointmentRepo;

	/**
	 * Create an appointment
	 * 
	 * @param appointment The appointment object
	 * @return Appointment The appointment object after create
	 */
	public Appointment create(Appointment appointment) {
		return appointmentRepo.save(appointment);
	}

	/**
	 * Get all the appointments list.
	 * 
	 * @return The list of an appointment
	 */
	public Iterable<Appointment> getAll() {
		return appointmentRepo.findAll();
	}

	/**
	 * Delete an appointment by id
	 * 
	 * @param id The id of appointment
	 * @throws NotFoundException Throw an exception if the id could not found.
	 */
	public void deleteAppointment(Long id) throws NotFoundException {
		if (!appointmentRepo.exists(id)) {
			throw new NotFoundException("Could not delete an appointment because given id does not exists");
		}
		appointmentRepo.delete(id);
	}
	
	/**
	 * Delete all appointments by doctor id
	 * 
	 * @param id The id of doctor
	 */
	public void deleteAppointmentsByDrId(Long id) {
		appointmentRepo.deleteAppointmentsByDrId(id);
	}
	
	/**
	 * Count appointments by doctor id
	 * 
	 * @param id The id of doctor
	 */
	public Long countAppointmentsByDrId(Long id) {
		return appointmentRepo.countAppointmentsByDrId(id);
	}

	/**
	 * Get an appointment by id.
	 * 
	 * @param id The id of an appointment
	 * @return The Appointment
	 * @throws NotFoundException Throw an exception if the id could not found.
	 */
	public Appointment get(Long id) throws NotFoundException {
		if (appointmentRepo.exists(id)) {
			return appointmentRepo.findOne(id);
		}
		throw new NotFoundException("Could not get an appointment because given id does not exists");
	}

	/**
	 * Update an appointment
	 * 
	 * @param appointment The appointment object
	 * @return Appointment The appointment object after update
	 * @throws NotFoundException Throw an exception if the object is totally new.
	 */
	public Appointment update(Appointment appointment) throws NotFoundException {
		if (appointmentRepo.exists(appointment.getId())) {
			return appointmentRepo.save(appointment);
		}
		throw new NotFoundException("Could not update an appointment because given id does not exists");
	}
}
