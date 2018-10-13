package com.gomeetdr.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.gomeetdr.modal.Appointment;
import com.gomeetdr.service.AppointmentService;
import com.gomeetdr.utils.NotFoundException;

@RestController
@RequestMapping(path="/api/appointment")
public class AppointmentController {

	@Autowired
	private AppointmentService service;
	
	@RequestMapping(method= RequestMethod.GET) 
	public Iterable<Appointment> getAllAppointments(){
		return service.getAll();
	}
	
	@RequestMapping(path="/{id}", method= RequestMethod.GET) 
	public Appointment getAppointment(@PathVariable Long id) throws NotFoundException{
		return service.get(id);
	}
	
	@RequestMapping(path="/{id}", method= RequestMethod.DELETE) 
	public void deleteAppointment(@PathVariable Long id) throws NotFoundException{
		service.delete(id);
	}
	
	@RequestMapping(method= RequestMethod.PUT) 
	public Appointment createOrUpdate(@Valid @RequestBody Appointment appointment){
		return service.create(appointment);
	}
	
	@RequestMapping(method= RequestMethod.POST) 
	public Appointment update(@Valid @RequestBody Appointment appointment) throws NotFoundException{
		return service.update(appointment);
	}
}
