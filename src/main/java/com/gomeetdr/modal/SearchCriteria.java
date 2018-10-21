package com.gomeetdr.modal;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * The entity class for search criteria.
 * 
 * @author parvajig
 *
 */
public class SearchCriteria implements Serializable {
	private static final long serialVersionUID = -5440329357712846711L;

	private Long doctorId;
	private String patientName;

	@JsonFormat(pattern = "dd-MM-yyyy HH:mm")
	private Date fromTime;

	@JsonFormat(pattern = "dd-MM-yyyy HH:mm")
	private Date toTime;

	public SearchCriteria() {
	}

	public SearchCriteria(Long doctorId, String patientName, Date fromTime, Date toTime) {
		this.doctorId = doctorId;
		this.patientName = patientName;
		this.fromTime = fromTime;
		this.toTime = toTime;
	}

	public Long getDoctorId() {
		return doctorId;
	}

	public void setDoctorId(Long doctorId) {
		this.doctorId = doctorId;
	}

	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public Date getFromTime() {
		return fromTime;
	}

	public void setFromTime(Date fromTime) {
		this.fromTime = fromTime;
	}

	public Date getToTime() {
		return toTime;
	}

	public void setToTime(Date toTime) {
		this.toTime = toTime;
	}
}