<%@include file="header.jsp" %>
<html>
<head>
	<title><fmt:message key="home.title" /></title>
</head>
<body>
	<div class="container">
	  <h2><fmt:message key="home.current.feature.list" /></h2>
	  <div class="list-group">
	    <a href="/doctors" class="list-group-item list-group-item-success">
	    	<fmt:message key="home.current.feature.doctor" /><span class="badge"><fmt:message key="home.done" /></span></a>
	    <a href="/appointments" class="list-group-item list-group-item-success">
	    	<fmt:message key="home.current.feature.appointment" /><span class="badge"><fmt:message key="home.done" /></span></a>
	    <a href="/dr_appointments" class="list-group-item list-group-item-success">
	    	<fmt:message key="home.current.feature.doctor.appointment" /><span class="badge"><fmt:message key="home.done" /></span></a>
	    <a href="/dr_appointments" class="list-group-item list-group-item-success">
	    	<fmt:message key="home.current.feature.search.by.criteria" /><span class="badge"><fmt:message key="home.done" /></span></a>
	    <a href="/home" class="list-group-item list-group-item-success">
	    	<fmt:message key="home.translation" /><span class="badge"><fmt:message key="home.done" /></span></a>
	    <a href="/home" class="list-group-item list-group-item-success">
	    	gomeetdr-0.0.2.war<span class="badge"><fmt:message key="home.done" /></span></a>
	  </div>
	</div>
	<div class="container">
	  <h2><fmt:message key="home.upcoming.feature.list" /></h2>
	  <div class="list-group">
	    <a href="#" class="list-group-item list-group-item-info">
	    	<fmt:message key="home.upcoming.feature.doctor" /><span class="badge"><fmt:message key="home.inprogress" /></span></a>
	    <a href="#" class="list-group-item list-group-item-danger">
	    	<fmt:message key="home.upcoming.feature.appointment" /><span class="badge"><fmt:message key="home.todo" /></span></a>
	    <a href="#" class="list-group-item list-group-item-danger">
	    	<fmt:message key="home.upcoming.feature.extra1" /><span class="badge"><fmt:message key="home.todo" /></span></a>
	    <a href="#" class="list-group-item list-group-item-danger">
	    	<fmt:message key="home.upcoming.feature.extra2" /><span class="badge"><fmt:message key="home.todo" /></span></a>
	  </div>
	</div>
</body>
</html>