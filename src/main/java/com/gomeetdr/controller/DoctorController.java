package com.gomeetdr.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.gomeetdr.modal.Appointment;
import com.gomeetdr.modal.Doctor;
import com.gomeetdr.service.DoctorService;
import com.gomeetdr.utils.CanNotDeleteDoctor;
import com.gomeetdr.utils.NotFoundException;

/**
 * The rest controller for the doctors.
 * 
 * @author parvajig
 *
 */
@RestController
@RequestMapping("/api/doctor")
public class DoctorController {

	@Autowired
	private DoctorService doctorService;
	
	/**
	 * Get all the doctors list.
	 * 
	 * @return The list of doctors
	 */
	@RequestMapping(method = RequestMethod.GET)
	public Iterable<Doctor> getAllDoctors() {
		return doctorService.getAllDoctors();
	}
	
	/**
	 * Get doctor by id.
	 * 
	 * @param id The id of doctor
	 * @return The Doctor
	 * @throws NotFoundException Throw an exception if the id could not found.
	 */
	@RequestMapping(value= "/{id}", method = RequestMethod.GET)
	public Doctor getDoctor(@PathVariable Long id) throws NotFoundException {
		return doctorService.getDoctor(id);
	}
	
	/**
	 * Create or update doctor
	 * 
	 * @param doctor The doctor object
	 * @return doctor The doctor object after create/update
	 */
	@RequestMapping(method = RequestMethod.PUT)
	public Doctor createDoctor(@Valid @RequestBody Doctor doctor) {
		return doctorService.createOrUpdateDoctor(doctor);
	}
	
	/**
	 * Update doctor
	 * 
	 * @param doctor The doctor object
	 * @return Doctor The doctor object after update
	 * @throws NotFoundException Throw an exception if the object is totally new.
	 */
	@RequestMapping(method = RequestMethod.POST)
	public Doctor updateDoctor(@Valid @RequestBody Doctor doctor) throws NotFoundException {
		return doctorService.updateDoctor(doctor);
	}
	
	/**
	 * Delete doctor by id
	 * 
	 * @param id The id of doctor
	 * @throws NotFoundException Throw an exception if the id could not found.
	 * @throws CanNotDeleteDoctor 
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public void deleteDoctor(@PathVariable Long id) throws NotFoundException {
		doctorService.deleteDoctor(id);
	}
	
	/**
	 * Get all the appointments for doctor
	 * 
	 * @param id The id of doctor
	 * @throws NotFoundException Throw an exception if the id could not found.
	 * @return The list of appointments
	 */
	@RequestMapping(value = "/{id}/appointments", method = RequestMethod.GET)
	public List<Appointment> getAppointments(@PathVariable Long id) throws NotFoundException {
		return doctorService.GetAppointments(id);
	}
}