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
		if (doctorRepository.exists(doctor.getId())) {
			return doctorRepository.save(doctor);
		}
		throw new NotFoundException("Could not update doctor because given id does not exists");
	}

	public Doctor getDoctor(Long id) throws NotFoundException {
		if (doctorRepository.exists(id)) {
			return doctorRepository.findOne(id);
		}
		throw new NotFoundException("Could not get doctor because given id does not exists");
	}

	public Iterable<Doctor> getAllDoctors() {
		return doctorRepository.findAll();
	}

	public void deleteDoctor(Long id) throws NotFoundException {
		if (!doctorRepository.exists(id)) {
			throw new NotFoundException("Could not delete doctor because given id does not exists.");
		}
		doctorRepository.delete(id);
	}

	public List<Appointment> getAppointments(Long id) throws NotFoundException {
		if (doctorRepository.exists(id)) {
			return doctorRepository.findOne(id).getAppointments();
		}
		throw new NotFoundException("Could not get appointments because given id does not exists.");
	}
}