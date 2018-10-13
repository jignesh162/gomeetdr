package com.gomeetdr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gomeetdr.modal.Appointment;
import com.gomeetdr.repository.AppointmentRepository;
import com.gomeetdr.utils.NotFoundException;

@Service
public class AppointmentService {
	
	@Autowired
	private AppointmentRepository appointmentRepo;
	
	public Appointment create(Appointment appointment) {
		return appointmentRepo.save(appointment);
	}
	
	public Iterable<Appointment> getAll() {
		return appointmentRepo.findAll();
	}
	
	public void delete(Long id) throws NotFoundException {
		if(!appointmentRepo.exists(id)) {
			throw new NotFoundException("Appointment with given id does not exists");
		}
		
		appointmentRepo.delete(id);
	}
	
	public Appointment get(Long id) throws NotFoundException {
		if(appointmentRepo.exists(id)) {
			return appointmentRepo.findOne(id);
		}
		
		throw new NotFoundException("Appointment with given id does not exists");
	}
	
	public Appointment update(Appointment appointment) throws NotFoundException {
		if(appointmentRepo.exists(appointment.getId())) {
			return appointmentRepo.save(appointment);	
		}
		
		throw new NotFoundException("Appointment not found");
	}
}
