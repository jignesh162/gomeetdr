package com.gomeetdr.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.gomeetdr.modal.Appointment;
import com.gomeetdr.modal.SearchCriteria;
import com.gomeetdr.modal.SearchResponse;
import com.gomeetdr.service.AppointmentService;
import com.gomeetdr.utils.NotFoundException;

/**
 * The rest controller for the appointments.
 * 
 * @author parvajig
 *
 */
@RestController
@RequestMapping("/api/appointment")
public class AppointmentController {

	@Autowired
	private AppointmentService service;

	/**
	 * Get all the appointments list.
	 * 
	 * @return The list of an appointment
	 */
	@RequestMapping(method = RequestMethod.GET)
	public Iterable<Appointment> getAllAppointments() {
		return service.getAll();
	}

	/**
	 * Get an appointment by id.
	 * 
	 * @param id The id of an appointment
	 * @return The Appointment
	 * @throws NotFoundException Throw an exception if the id could not found.
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public Appointment getAppointment(@PathVariable Long id) throws NotFoundException {
		return service.get(id);
	}

	/**
	 * Delete an appointment by id
	 * 
	 * @param id The id of appointment
	 * @throws NotFoundException Throw an exception if the id could not found.
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public void deleteAppointment(@PathVariable Long id) throws NotFoundException {
		service.deleteAppointment(id);
	}
	
	/**
	 * Delete all appointments by doctor id
	 * 
	 * @param id The id of doctor
	 * @throws NotFoundException Throw an exception if the doctor id is not found.
	 */
	@RequestMapping(value = "/doctor/{id}", method = RequestMethod.DELETE)
	public void deleteAppointmentsByDrId(@PathVariable Long id) throws NotFoundException {
		service.deleteAppointmentsByDrId(id);
	}
	
	/**
	 * Count appointments by doctor id
	 * 
	 * @param id The id of doctor
	 * @throws NotFoundException Throw an exception if the doctor id is not found.
	 */
	@RequestMapping(value = "/doctor/{id}", method = RequestMethod.GET)
	public Long countAppointmentsByDrId(@PathVariable Long id) throws NotFoundException {
		return service.countAppointmentsByDrId(id);
	}

	/**
	 * Create or update an appointment
	 * 
	 * @param appointment The appointment object
	 * @return Appointment The appointment object after create/update
	 */
	@RequestMapping(method = RequestMethod.PUT)
	public Appointment createOrUpdate(@Valid @RequestBody Appointment appointment) {
		return service.create(appointment);
	}

	/**
	 * Update an appointment
	 * 
	 * @param appointment The appointment object
	 * @return Appointment The appointment object after update
	 * @throws NotFoundException Throw an exception if the object is totally new.
	 */
	@RequestMapping(method = RequestMethod.POST)
	public Appointment update(@Valid @RequestBody Appointment appointment) throws NotFoundException {
		return service.update(appointment);
	}
	
	/**
	 * Get all appointments by search criteria
	 * 
	 * @param SearchCriteria The object of SearchCriteria
	 * @return The list of an appointment
	 */
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public Iterable<SearchResponse> getAppointmentsBySearchCriteria(@Valid @RequestBody SearchCriteria searchCriteria) {
		return service.getAppointmentsBySearchCriteria(searchCriteria);
	}
}