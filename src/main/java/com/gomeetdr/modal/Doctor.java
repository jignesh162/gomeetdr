package com.gomeetdr.modal;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

/**
 * The entity class for the doctors.
 * 
 * @author parvajig
 *
 */
@Entity
public class Doctor implements Serializable {

	private static final long serialVersionUID = -1042724889762962358L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotBlank
	private String name;

	@NotBlank
	private String type;

	@Email
	private String email;

	private String contactNumber;

	@OneToMany(mappedBy = "doctor", fetch = FetchType.EAGER)
	private List<Appointment> appointments;

	public Doctor() {
		super();
	}

	public Doctor(Long id, String name, String type, String email, String contactNumber) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.type = type;
		this.contactNumber = contactNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<Appointment> getAppointments() {
		return appointments;
	}

	public void setAppointments(List<Appointment> appointments) {
		this.appointments = appointments;
	}
}