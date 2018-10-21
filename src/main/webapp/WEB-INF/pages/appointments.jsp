<%@include file="header.jsp" %>
<head>
<title><fmt:message key="appointment.title" /></title>
<script>
$(document).ready(function() {
	var appointmentRest = "/api/appointment/";
	var doctorRest = "/api/doctor/";
	
	var t = $('#appointmentTable').DataTable( {
		"order": [[ 9, "desc" ]],
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
	
	tableSearch($('#appointmentTable tfoot th'), t);
	
	hideColumnById(t, 0);
	hideColumnById(t, 4);
	hideColumnById(t, 7);
	hideColumnById(t, 8);
	
	disableButton($('#deleteRow'));
	disableButton($('#editRow'));
	tableSelectDeselectFunction($('#appointmentTable tbody'), t, $('#editRow'), $('#deleteRow'))
	
	setDateTimePickerFixedValues($('#startTime'));
	setDateTimePickerFixedValues($('#endTime'));
	
	$('#startTime').on("dp.change", function(e) {
	   	var d = new Date(e.date);
	   	d.setHours(d.getHours()+1);
    
		$('#endTime').data("DateTimePicker").date(d);
    });
	
	$('#deleteRow').on('click', function() {
		deleteRowTask(t, $('#deleteRow'), $('#editRow'), appointmentRest);
	});
	 
	$('#editRow').on( 'click', function () {
		$('#patientId').val(t.rows('.selected').data()[0][0]);
		$('#patientName').val(t.rows('.selected').data()[0][1]);
		$('#email').val(t.rows('.selected').data()[0][3]);
		$('#phone').val(t.rows('.selected').data()[0][2]);
		$('#drName').val(t.rows('.selected').data()[0][4]);
		$('#startDate').val(t.rows('.selected').data()[0][9]);
		$('#endDate').val(t.rows('.selected').data()[0][10]);
	});
	 
	$.ajax({
		type: "GET",
		url: doctorRest,
		dataType: "json",
		success: function (responseData) {
			var div_data;
			for (var i in responseData) {
				div_data+="<option value=\""+responseData[i].id+"\">"+responseData[i].name+"</option>";
			}
			$('#drName').append(div_data); 
		},
		error : function(request, status, errorThrown, responseText) {
			console.log("--------deleteRowTask-----------");
			console.log("request: " + request);
			console.log("status: " + status);
			console.log("errorThrown: " + errorThrown);
			console.log("responseText: " + responseText);
		}
	});
	
	$.ajax({
        type: "GET",
        url: appointmentRest,
        success: function (responseData) {
            for (var i in responseData) {
            	if(responseData[i].doctor != null) {
	            	var appointmentList = responseData[i].doctor.appointments;
	           		if(appointmentList != null && appointmentList != undefined) {
		            	for (var j in appointmentList) {
			            		t.row.add( [
			            			responseData[i].doctor.appointments[j].id,
				            		responseData[i].doctor.appointments[j].name,
				            		responseData[i].doctor.appointments[j].contactNumber,
				            		responseData[i].doctor.appointments[j].email,
				            		responseData[i].doctor.id,
				            		responseData[i].doctor.name,
				            		responseData[i].doctor.type,
				            		responseData[i].doctor.email,
				            		responseData[i].doctor.contactNumber,
				            		responseData[i].doctor.appointments[j].startTime,
				            		responseData[i].doctor.appointments[j].endTime
			            			] ).draw( false );
			            		
		            	}
		            }
	           	}
            }
        },
        error : function(request, status, errorThrown, responseText) {
			console.log("--------Get appointment data-----------");
			console.log("request: " + request);
			console.log("status: " + status);
			console.log("errorThrown: " + errorThrown);
			console.log("responseText: " + responseText);
		}
    });

	$('#bookAppointmentForm').submit(function () {
		$.ajax({
			url: appointmentRest,
			type: "PUT",
			contentType: "application/json",
			data : JSON.stringify({
				id : $('#patientId').val(),
				name : $("#patientName").val(),
				email : $("#email").val(),
				contactNumber : $("#phone").val(),
				doctor : {
					id : $("#drName").val()
				},
				startTime : $('#startDate').val(),
				endTime : $('#endDate').val()}),
			dataType : 'json',
			success: function (data) {
				console.log("--Successful submission of appointment form data--");
			},
			error : function(request, status, errorThrown, responseText) {
				console.log("----submission of appointment form data-----");
				console.log("request: " + request);
				console.log("status: " + status);
				console.log("errorThrown: " + errorThrown);
				console.log("responseText: " + responseText);
			}
		});
	});
});
</script>
</head>
<body>
	<button id="addRow" class="btn btn-success btn-md" data-toggle="modal"
		data-target="#addDrModal">
		<fmt:message key="common.button.add" />
	</button>
	<button id="editRow" class="btn btn-warning btn-md" data-toggle="modal"
		data-target="#addDrModal">
		<fmt:message key="common.button.edit" />
	</button>
	<button id="deleteRow" class="btn btn-danger btn-md">
		<fmt:message key="common.button.delete" />
	</button>

	<div class="modal fade" id="addDrModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<fmt:message key="appointment.modal.title" />
					</h4>
				</div>
				<div class="modal-body">
					<form role="form" id="bookAppointmentForm">
						<div class="form-group">
							<input type="hidden" id="patientId" name="patientId" value="0">
						</div>
						<div class="form-group">
							<label for="patientName"><span
								class="glyphicon glyphicon-user"></span> <fmt:message
									key="appointment.modal.patientname" /></label> <input type="text"
								class="form-control" id="patientName"
								placeholder="<fmt:message key="appointment.modal.placeholder.patientname" />"
								required>
						</div>
						<div class="form-group">
							<label for="email"><span
								class="glyphicon glyphicon-envelope"></span> <fmt:message
									key="common.table.heading.email" /></label> <input type="email"
								class="form-control" id="email"
								placeholder="<fmt:message key="common.modal.placeholder.email" />"
								required>
						</div>
						<div class="form-group">
							<label for="phone"><span
								class="glyphicon glyphicon-phone"></span> <fmt:message
									key="common.table.heading.phone" /></label> <input type="text"
								class="form-control" id="phone"
								placeholder="<fmt:message key="common.modal.placeholder.phone" />"
								required>
						</div>
						<div class="form-group">
							<label for="drName"><span
								class="glyphicon glyphicon-plus"></span> <fmt:message
									key="doctor.modal.drname" /></label> <select
								class="form-control selectpicker" id="drName"></select>
						</div>
						<div class="form-group">
							<label for="startTime"><span
								class="glyphicon glyphicon-time"></span> <fmt:message
									key="appointment.modal.starttime" /></label>
							<div class='input-group date' id='startTime'>
								<input type='text' class="form-control" id="startDate" required />
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<div class="form-group">
							<label for="endTime"><span
								class="glyphicon glyphicon-time"></span> <fmt:message
									key="appointment.modal.endtime" /></label>
							<div class='input-group date' id='endTime'>
								<input type='text' class="form-control" id="endDate" required
									disabled /> <span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<div class="modal-footer">
							<button id="submitRow" type="submit"
								class="btn btn-success btn-md">
								<fmt:message key="common.button.submit" />
							</button>
							<button id="closeAddDrDialog" type="button"
								class="btn btn-danger btn-md" data-dismiss="modal">
								<fmt:message key="common.button.close" />
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div id="appointmentTableDiv">
		<table id="appointmentTable" class="display" style="width: 100%">
			<thead>
				<tr>
					<th><fmt:message key="common.table.heading.id" /></th>
					<th><fmt:message key="common.table.heading.name" /></th>
					<th><fmt:message key="common.table.heading.phone" /></th>
					<th><fmt:message key="common.table.heading.email" /></th>
					<th><fmt:message key="common.table.heading.id" /></th>
					<th><fmt:message key="doctor.modal.drname" /></th>
					<th><fmt:message key="doctor.modal.drtype" /></th>
					<th><fmt:message key="common.table.heading.email" /></th>
					<th><fmt:message key="common.table.heading.phone" /></th>
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
					<th><fmt:message key="common.table.heading.id" /></th>
					<th><fmt:message key="doctor.modal.drname" /></th>
					<th><fmt:message key="doctor.modal.drtype" /></th>
					<th><fmt:message key="common.table.heading.email" /></th>
					<th><fmt:message key="common.table.heading.phone" /></th>
					<th><fmt:message key="appointment.modal.starttime" /></th>
					<th><fmt:message key="appointment.modal.endtime" /></th>
				</tr>
			</tfoot>
		</table>
	</div>
</body>