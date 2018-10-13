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
import com.gomeetdr.utils.NotFoundException;

@RestController
@RequestMapping("/api/doctor")
public class DoctorController {

	@Autowired
	private DoctorService doctorService;
	
	@RequestMapping(method = RequestMethod.GET)
	public Iterable<Doctor> getAllDoctors() {
		return doctorService.getAllDoctors();
	}
	
	@RequestMapping(method = RequestMethod.GET, value= "/{id}")
	public Doctor getDoctor(@PathVariable Long id) {
		return doctorService.getDoctor(id);
	}

	@RequestMapping(method = RequestMethod.PUT)
	public Doctor createDoctor(@Valid @RequestBody Doctor doctor) {
		return doctorService.createOrUpdateDoctor(doctor);
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public Doctor updateDoctor(@Valid @RequestBody Doctor doctor) throws NotFoundException {
		return doctorService.updateDoctor(doctor);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public void deleteDoctor(@PathVariable Long id) {
		doctorService.deleteDoctor(id);
	}
	
	@RequestMapping(value = "/{id}/appointments", method = RequestMethod.GET)
	public List<Appointment> getAppointments(@PathVariable Long id) {
		return doctorService.GetAppointments(id);
	}
}