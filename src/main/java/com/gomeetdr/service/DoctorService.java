package com.gomeetdr.service;
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gomeetdr.modal.Appointment;
import com.gomeetdr.modal.Doctor;
import com.gomeetdr.repository.DoctorRepository;
import com.gomeetdr.utils.NotFoundException;

@Service
public class DoctorService {

	@Autowired
	private DoctorRepository doctorRepository;
	
	public Doctor createOrUpdateDoctor(Doctor doctor) {
		return doctorRepository.save(doctor);
	}
	
	public Doctor updateDoctor(Doctor doctor) throws NotFoundException {
		if(doctorRepository.exists(doctor.getId())) {
			return doctorRepository.save(doctor);
		}
		
		throw new NotFoundException("Doctor not found");
	}
	
	public Doctor getDoctor(Long id) {
		return doctorRepository.findOne(id);
	}
	
	public Iterable<Doctor> getAllDoctors() {
		return doctorRepository.findAll();
	}
	
	public void deleteDoctor(Long id) {
		doctorRepository.delete(id);
	}

	public List<Appointment> GetAppointments(Long id) {
		return doctorRepository.findOne(id).getAppointments();
	}
}