<%@include file="header.jsp" %>
<head>
<title><fmt:message key="doctor.appointment.title" /></title>
<script>
$(document).ready(function() {
	var t = $('#drAppointmentsTable').DataTable( {
		"order": [[ 0, "desc" ]],
		responsive: true,
		colReorder: true,
		"language": {
			"search": "<fmt:message key="datatable.search" />",
            "lengthMenu": "<fmt:message key="datatable.lengthMenu" />",
            "zeroRecords": "<fmt:message key="datatable.zeroRecords" />",
            "info": "<fmt:message key="datatable.info" />",
            "infoEmpty": "<fmt:message key="datatable.infoEmpty" />",
            "infoFiltered": "<fmt:message key="datatable.infoFiltered" />",
            "paginate": {
            	"previous": "<fmt:message key="datatable.previous" />",
                "next": "<fmt:message key="datatable.next" />"
              }
        }
    });
	
	tableSearch($('#drAppointmentsTable tfoot th'), t);
	
	hideColumnById(t, 0);
	
	setDateTimePickerFixedValues($('#fromDateAndTime'));
	setDateTimePickerFixedValues($('#toDateAndTime'));
	
	$('#searchFormButton').on('click', function () {
		$.ajax('/api/appointment/search', {
		    type: 'POST',
		    contentType: 'application/json; charset=UTF-8',
		    dataType: 'json',
		    data: JSON.stringify({
				doctorId : $('#doctorName').val(),
				patientName : $("#patientName").val(),
				fromTime : $("#fromDate").val(),
				toTime : $("#toDate").val()})
		}).done(function (data, textStatus, jqXHR) {
			console.log("--Successful submission of search criteria form data--");
			t.clear().draw();
			for (var i in data) {
				t.row.add( [
        			data[i].id,
        			data[i].name,
        			data[i].contactNumber,
        			data[i].email,
        			data[i].doctorName,
        			data[i].startTime,
        			data[i].endTime
        			] ).draw( false );
            }
		}).fail(function (jqXHR, textStatus, errorThrown) {
		    console.log('fail: status=' + jqXHR.status + ', textStatus=' + textStatus);
		});
		return false;
	});
	
	$.ajax({
	       type: "GET",
	       url:"/api/doctor/",
	       dataType: "json",
	       success: function (responseData) {
	       	var div_data;
	       	for (var i in responseData) {
	            	div_data+="<option value=\""+responseData[i].id+"\">"+responseData[i].name+"</option>";
	        }
	       	$('#doctorName').append(div_data); 
	       }
	});
});
</script>
</head>
<body>
	<div class="row">
		<div class="col-xs-12">
			<form id="searchForm">
				<div class="row">
					<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
						<div class="form-group required">
							<label for="doctorName" class="control-label"><fmt:message
									key="doctor.modal.drname" /></label>
							<div>
								<select id="doctorName" name="doctorName" class="form-control"><option
										value="0">
										<fmt:message key="doctor.appointment.option.all" /></option></select>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
						<div class="form-group required">
							<label for="patientName" class="control-label"><fmt:message
									key="appointment.modal.patientname" /></label>
							<div>
								<input id="patientName" type="text" name="patientName"
									class="form-control">
							</div>
						</div>
					</div>
					<!-- /.col- -->
					<div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">
						<label for="fromDateAndTime" class="control-label"><fmt:message
								key="doctor.appointment.from.date.time.label" /></label>
						<div class='input-group date' id='fromDateAndTime'>
							<input type='text' class="form-control" id="fromDate" required />
							<span class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">
						<label for="toDateAndTime" class="control-label"><fmt:message
								key="doctor.appointment.to.date.time.label" /></label>
						<div class='input-group date' id='toDateAndTime'>
							<input type='text' class="form-control" id="toDate" required /> <span
								class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
					<!-- /.col- -->
					<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
						<div class="clearfix">&nbsp;</div>
						<button type="submit" id="searchFormButton"
							class="btn btn-primary">
							<fmt:message key="common.button.search" />
						</button>
					</div>
					<!-- /.col- -->
				</div>
			</form>
		</div>
		<!-- /.col-xs-12 -->
	</div>
	<!-- /.row -->

	<div id="drAppointmentsTableDiv">
		<table id="drAppointmentsTable" class="display" style="width: 100%">
			<thead>
				<tr>
					<th><fmt:message key="common.table.heading.id" /></th>
					<th><fmt:message key="common.table.heading.name" /></th>
					<th><fmt:message key="common.table.heading.phone" /></th>
					<th><fmt:message key="common.table.heading.email" /></th>
					<th><fmt:message key="doctor.modal.drname" /></th>
					<th><fmt:message key="appointment.modal.starttime" /></th>
					<th><fmt:message key="appointment.modal.endtime" /></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<th><fmt:message key="common.table.heading.id" /></th>
					<th><fmt:message key="common.table.heading.name" /></th>
					<th><fmt:message key="common.table.heading.phone" /></th>
					<th><fmt:message key="common.table.heading.email" /></th>
					<th><fmt:message key="doctor.modal.drname" /></th>
					<th><fmt:message key="appointment.modal.starttime" /></th>
					<th><fmt:message key="appointment.modal.endtime" /></th>
				</tr>
			</tfoot>
		</table>
	</div>
</body>