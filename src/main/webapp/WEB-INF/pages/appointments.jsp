<%@include file="header.jsp" %>
<html lang="en">
<head>
<title>Dr. Appointment Application</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script>
$(document).ready(function() {
	var appointmentRest = "/api/appointment/";
	var doctorRest = "/api/doctor/";
	var t = $('#appointmentTable').DataTable( {
		"order": [[ 0, "desc" ]]
    });
	
	var endTimeId = $('#endTime');
	var startTimeId = $('#startTime');
	hideColumnById(t, 4);
	hideColumnById(t, 7);
	hideColumnById(t, 8);
	
	disableButton($('#deleteRow'));
	disableButton($('#editRow'));
	tableSelectDeselectFunction($('#appointmentTable tbody'), t, $('#editRow'), $('#deleteRow'))
	
	var todayDate = new Date();
    $('#startTime').datetimepicker({
    	format: 'DD-MM-YYYY HH:mm',
	    minDate: todayDate //Important! See issue #1075
    });
	
	disableButton(endTimeId);
	startTimeId.on("dp.change", function(e) {
    	var d = new Date(e.date);
    	d.setHours(d.getHours()+1);
      endTimeId.data("DateTimePicker").minDate(e.date);
      endTimeId.data("DateTimePicker").maxDate(d);
      enableButton(endTimeId);
    });
	
	setDateTimePickerFixedValues(endTimeId);
	setDateTimePickerFixedValues(startTimeId);
	
	deleteRowTask(t, $('#deleteRow'), appointmentRest);
	 
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
	            	/* console.log("start of responseData");
	           		console.log(responseData[i].id);
	           		console.log(responseData[i].name);
	           		console.log(responseData[i].contactNumber);
	           		console.log(responseData[i].email);
	           		console.log(responseData[i].doctor.id);
	           		console.log(responseData[i].doctor.name);
	           		console.log(responseData[i].doctor.type);
	           		console.log(responseData[i].doctor.email);
	           		console.log(responseData[i].doctor.contactNumber);
	           		console.log(responseData[i].startTime);
	           		console.log(responseData[i].endTime);
	           		console.log("end of responseData"); */
	           		
	           		t.row.add( [
	           			responseData[i].id,
		           		responseData[i].name,
		           		responseData[i].contactNumber,
		           		responseData[i].email,
		           		responseData[i].doctor.id,
		           		responseData[i].doctor.name,
		           		responseData[i].doctor.type,
		           		responseData[i].doctor.email,
		           		responseData[i].doctor.contactNumber,
		           		responseData[i].startTime,
		           		responseData[i].endTime
	           			] ).draw( false );
	           		
	           		
	           		if(appointmentList.length > 1 && appointmentList != undefined) {
		            	for (var j in appointmentList) {
		            		if(j != 0) {
			            		/* console.log("start of appointments")
			            		console.log(responseData[i].doctor.appointments[j].id);
			            		console.log(responseData[i].doctor.appointments[j].name);
			            		console.log(responseData[i].doctor.appointments[j].contactNumber);
			            		console.log(responseData[i].doctor.appointments[j].email);
			            		console.log(responseData[i].doctor.id);
			            		console.log(responseData[i].doctor.name);
			            		console.log(responseData[i].doctor.type);
			            		console.log(responseData[i].doctor.email);
			            		console.log(responseData[i].doctor.contactNumber);
			            		console.log(responseData[i].doctor.appointments[j].startTime);
			            		console.log(responseData[i].doctor.appointments[j].endTime);
			            		console.log("end of appointments"); */
			            		
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
<button id="addRow" class="btn btn-success btn-md" data-toggle="modal" data-target="#addDrModal">Add</button>
<button id="editRow" class="btn btn-warning btn-md" data-toggle="modal" data-target="#addDrModal">Edit</button>
<button id="deleteRow" class="btn btn-danger btn-md">Delete</button>


<div class="modal fade" id="addDrModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Add appointment</h4>
				</div>
				<div class="modal-body" style="padding:40px 50px;">
			          <form role="form" id="bookAppointmentForm">
			          	<div class="form-group">
			              <input type="hidden" id="patientId" name="patientId" value="0">
			            </div>
			            <div class="form-group">
			              <label for="patientName"><span class="glyphicon glyphicon-user"></span> Patient Name</label>
			              <input type="text" class="form-control" id="patientName" placeholder="Enter patient name" required>
			            </div>
			            <div class="form-group">
			              <label for="email"><span class="glyphicon glyphicon-envelope"></span> Email</label>
			              <input type="email" class="form-control" id="email" placeholder="Enter email" required>
			            </div>
			            <div class="form-group">
			              <label for="phone"><span class="glyphicon glyphicon-phone"></span> Mobile Number</label>
			              <input type="text" class="form-control" id="phone" placeholder="Enter mobile number" required>
			            </div>
			            <div class="form-group">
			              <label for="drName"><span class="glyphicon glyphicon-plus"></span> Dr. Name</label>
			              <select class="form-control selectpicker" id="drName"></select>
			            </div>
			            <div class="form-group">
			            	<label for="startTime"><span class="glyphicon glyphicon-time"></span> Start Time</label>
					        <div class='input-group date' id='startTime'>
					          <input type='text' class="form-control" id="startDate" required/>
					          <span class="input-group-addon">
					                        <span class="glyphicon glyphicon-calendar"></span>
					          </span>
					        </div>
				      	</div>
						<div class="form-group">
						<label for="endTime"><span class="glyphicon glyphicon-time"></span> End Time</label>
					        <div class='input-group date' id='endTime'>
					          <input type='text' class="form-control" id="endDate" required/>
					          <span class="input-group-addon">
					                        <span class="glyphicon glyphicon-calendar"></span>
					          </span>
					        </div>
					    </div>
			            <div class="modal-footer">
							<button id="submitRow" type="submit" class="btn btn-success btn-md">submit</button>
							<button id="closeAddDrDialog" type="button" class="btn btn-danger btn-md" data-dismiss="modal">Close</button>
						</div>
			          </form>
        		</div>
			</div>
		</div>
	</div>

	<table id="appointmentTable"
		class="table table-striped table-bordered dt-responsive"
		style="width: 100%">
		<thead>
			<tr>
				<th>Id</th>
				<th>Name</th>
				<th>Phone</th>
				<th>Email</th>
				<th>Dr. Id</th>
				<th>Dr. Name</th>
				<th>Dr. Type</th>
				<th>Dr. email</th>
				<th>Dr. contact number</th>
				<th>Start time</th>
				<th>End time</th>
			</tr>
		</thead>
	</table>
</body>