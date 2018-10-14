<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>GoMeetDoctor</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<div class="container">
	  <h2>Current feature list</h2>
	  <div class="list-group">
	    <a href="/doctors" class="list-group-item list-group-item-success">Doctor -- User can add/edit/delete doctor.<span class="badge">Done</span></a>
	    <a href="/appointments" class="list-group-item list-group-item-success">Appointment -- User can book/edit/delete an appointment with listed doctors.<span class="badge">Done</span></a>
	    <a href="/dr_appointments" class="list-group-item list-group-item-success">Dr-Appointment -- User can check all the appointments for particular doctor.<span class="badge">Done</span></a>
	  </div>
	</div>
	<div class="container">
	  <h2>Upcoming feature/validations list</h2>
	  <div class="list-group">
	    <a href="#" class="list-group-item list-group-item-info">Doctor -- What if doctor is on leave for particular time period?<span class="badge">In progress</span></a>
	    <a href="#" class="list-group-item list-group-item-danger">Appointment -- What if someone has already booked appointment with same time and same doctor?<span class="badge">TODO</span></a>
	    <a href="#" class="list-group-item list-group-item-danger">Dr-Appointment -- Make search possible by dates.<span class="badge">TODO</span></a>
	    <a href="#" class="list-group-item list-group-item-danger">Make possible to delete appointments or doctors in bulk.<span class="badge">TODO</span></a>
	    <a href="#" class="list-group-item list-group-item-danger">Make better user interface of web-site.<span class="badge">TODO</span></a>
	  </div>
	</div>
</body>
</html>