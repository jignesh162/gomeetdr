package com.gomeetdr.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gomeetdr.modal.Appointment;
import com.gomeetdr.modal.Doctor;
import com.gomeetdr.repository.DoctorRepository;
import com.gomeetdr.utils.NotFoundException;

/**
 * The rest service for the doctors.
 * 
 * @author parvajig
 *
 */
@Service
public class DoctorService {
	private static final Logger logger = Logger.getLogger(DoctorService.class);
	
	@Autowired
	private DoctorRepository doctorRepository;

	public Doctor createOrUpdateDoctor(Doctor doctor) {
		return doctorRepository.save(doctor);
	}

	public Doctor updateDoctor(Doctor doctor) throws NotFoundException {
		if (doctorRepository.exists(doctor.getId())) {
			return doctorRepository.save(doctor);
		}
		logger.error("Could not update the doctor because given id does not exists.");
		throw new NotFoundException("Could not update the doctor because given id does not exists.");
	}

	public Doctor getDoctor(Long id) throws NotFoundException {
		if (doctorRepository.exists(id)) {
			return doctorRepository.findOne(id);
		}
		logger.error("Could not get the doctor because given id does not exists.");
		throw new NotFoundException("Could not get the doctor because given id does not exists.");
	}

	public Iterable<Doctor> getAllDoctors() {
		return doctorRepository.findAll();
	}

	public void deleteDoctor(Long id) throws NotFoundException {
		if (!doctorRepository.exists(id)) {
			logger.error("Could not delete the doctor because given id does not exists.");
			throw new NotFoundException("Could not delete the doctor because given id does not exists.");
		}
		doctorRepository.delete(id);
	}

	public List<Appointment> getAppointments(Long id) throws NotFoundException {
		if (doctorRepository.exists(id)) {
			return doctorRepository.findOne(id).getAppointments();
		}
		logger.error("Could not get appointments because given id does not exists.");
		throw new NotFoundException("Could not get appointments because given id does not exists.");
	}
}