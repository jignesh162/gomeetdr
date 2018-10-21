package com.gomeetdr.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.gomeetdr.modal.Appointment;
import com.gomeetdr.modal.SearchCriteria;
import com.gomeetdr.modal.SearchResponse;
import com.gomeetdr.repository.AppointmentRepository;
import com.gomeetdr.repository.DoctorRepository;
import com.gomeetdr.utils.NotFoundException;

/**
 * The rest service for the appointments.
 * 
 * @author parvajig
 *
 */
@Service
public class AppointmentService {
	private static final Logger logger = Logger.getLogger(AppointmentService.class);

	@Autowired
	private AppointmentRepository appointmentRepo;
	@Autowired
	private DoctorRepository doctorRepository;

	@PersistenceContext
	private EntityManager em;

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
			logger.error("Could not delete an appointment because given id does not exists.");
			throw new NotFoundException("Could not delete an appointment because given id does not exists.");
		}
		appointmentRepo.delete(id);
	}

	/**
	 * Delete all the appointments by the doctor id
	 * 
	 * @param id The id of doctor
	 * @throws NotFoundException Throw an exception if the id could not found.
	 */
	public void deleteAppointmentsByDrId(Long doctorId) throws NotFoundException {
		if (!doctorRepository.exists(doctorId)) {
			logger.error("Could not delete all appointments because given doctor id does not exists.");
			throw new NotFoundException("Could not delete all appointments because given doctor id does not exists.");
		}
		appointmentRepo.deleteAppointmentsByDrId(doctorId);
	}

	/**
	 * Count all the appointments by the doctor id
	 * 
	 * @param id The id of doctor
	 * @throws NotFoundException Throw an exception if the id could not found.
	 */
	public Long countAppointmentsByDrId(Long doctorId) throws NotFoundException {
		if (!doctorRepository.exists(doctorId)) {
			logger.error("Could not count all appointments because given doctor id does not exists.");
			throw new NotFoundException("Could not count all appointments because given doctor id does not exists.");
		}
		return appointmentRepo.countAppointmentsByDrId(doctorId);
	}

	/**
	 * Get list of appointments which matches the given search criteria
	 * 
	 * @param SearchCriteria The object of SearchCriteria
	 * @return The list of SearchResponse which contain appointment details
	 */
	public List<SearchResponse> getAppointmentsBySearchCriteria(SearchCriteria searchCriteria) {
		List<SearchResponse> searchResponses = new ArrayList<>();
		final CriteriaBuilder cb = em.getCriteriaBuilder();
		final CriteriaQuery<Appointment> criteria = cb.createQuery(Appointment.class);
		final Root<Appointment> appointments = criteria.from(Appointment.class);

		List<Predicate> predicates = new ArrayList<Predicate>();

		if (searchCriteria.getDoctorId() != null && searchCriteria.getDoctorId() != 0L) {
			predicates.add(cb.equal(appointments.get("doctor").get("id"), searchCriteria.getDoctorId()));
			logger.info("Added predicate for doctor id : " + searchCriteria.getDoctorId());
		}
		if (!StringUtils.isEmpty(searchCriteria.getPatientName())) {
			predicates.add(cb.like(cb.lower(appointments.get("name")), "%"+searchCriteria.getPatientName().toLowerCase()+"%"));
			logger.info("Added predicate for patient name : " + searchCriteria.getPatientName());
		}

		if (searchCriteria.getFromTime() != null && searchCriteria.getToTime() != null) {
			predicates.add(cb.between(appointments.get("startTime"), searchCriteria.getFromTime(),
					searchCriteria.getToTime()));
			logger.info("Added predicate for fromTime is beetween date " + searchCriteria.getFromTime() + " and "
					+ searchCriteria.getToTime());
		} else if (searchCriteria.getFromTime() != null) {
			predicates.add(cb.greaterThanOrEqualTo(appointments.get("startTime"), searchCriteria.getFromTime()));
			logger.info("Added predicate for fromTime is greater than date " + searchCriteria.getFromTime());
		} else if (searchCriteria.getToTime() != null) {
			predicates.add(cb.lessThanOrEqualTo(appointments.get("startTime"), searchCriteria.getToTime()));
			logger.info("Added predicate for toTime is less than date " + searchCriteria.getToTime());
		}

		criteria.where(predicates.toArray(new Predicate[] {}));
		List<Appointment> result = em.createQuery(criteria).getResultList();
		for (Appointment appointment : result) {
			searchResponses.add(new SearchResponse(appointment.getId(), appointment.getName(),
					appointment.getContactNumber(), appointment.getEmail(), appointment.getDoctor().getName(),
					appointment.getStartTime(), appointment.getEndTime()));

		}
		return searchResponses;
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
		logger.error("Could not get an appointment because given id does not exists");
		throw new NotFoundException("Could not get an appointment because given id does not exists.");
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
		logger.error("Could not update an appointment because given id does not exists.");
		throw new NotFoundException("Could not update an appointment because given id does not exists.");
	}
}
