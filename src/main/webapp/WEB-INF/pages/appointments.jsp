<%@include file="header.jsp" %>
<html lang="en">
<head>
<title>Dr. Appointment Application</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script>
var endDate;
var startDate;
$(document).ready(function() {
	var t = $('#example').DataTable();
	t.column( 0 ).visible( false );
	t.column( 4 ).visible( false );
	
	$('#deleteRow').attr("disabled", true);
	$('#editRow').attr("disabled", true);
	$('#endTime').attr("disabled", true);
	$(function() {
	    $('#endTime').datetimepicker();
	    $('#startTime').datetimepicker({
	      useCurrent: true //Important! See issue #1075
	    });
	    
	    $("#startTime").on("dp.change", function(e) {
	    	var d = new Date(e.date);
	    	d.setHours(d.getHours()+1);
	      $('#endTime').data("DateTimePicker").minDate(e.date);
	      $('#endTime').data("DateTimePicker").maxDate(d);
	      $('#endTime').attr("disabled", false);
	    });
	  });
	
	$('#endTime').datetimepicker({
		format: 'DD-MM-YYYY HH:mm',
        disabledTimeIntervals: [[moment({ h: 0 }), moment({ h: 8 })], [moment({ h: 19, m: 30}), moment({ h: 24 })]],
        enabledHours: [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
        stepping: 30
    });
	$('#startTime').datetimepicker({
		format: 'DD-MM-YYYY HH:mm',
        disabledTimeIntervals: [[moment({ h: 0 }), moment({ h: 8 })], [moment({ h: 19, m: 30}), moment({ h: 24 })]],
        enabledHours: [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
        stepping: 30
    });
	
	 $('#example tbody').on( 'click', 'tr', function () {
	     if ( $(this).hasClass('selected') ) {
	         $(this).removeClass('selected');
	         $('#deleteRow').attr("disabled", true);
	         $('#editRow').attr("disabled", true);
	     } else {
	         t.$('tr.selected').removeClass('selected');
	         $(this).addClass('selected');
	         $('#deleteRow').attr("disabled", false);
	         $('#editRow').attr("disabled", false);
	     }
	 } );
	 
	 $('#deleteRow').on( 'click', function () {
			$.ajax({
				   url: "/api/appointment/"+t.rows('.selected').data()[0][0],
				   type: "DELETE",
				   success: function (data) {
					   t.row('.selected').remove().draw( false );
				   },
				   failure: function (response) {
				      alert("Delete failed");
				   }
				});
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
	        url:"/api/doctor/",
	        dataType: "json",
	        success: function (responseData) {
	        	var div_data;
	        	for (var i in responseData) 
	            {
	             	div_data+="<option value=\""+responseData[i].id+"\">"+responseData[i].name+"</option>";
	            }
	        	console.log("div_data: "+ div_data);
	        	$('#drName').append(div_data); 
	        }
	      });
	
	
	$.ajax({
        type: "GET",
        url: "/api/appointment",
        success: function (responseData) {
        	//var json_obj = $.parseJSON(responseData);//parse JSON
        	
            for (var i in responseData) 
            {
            	if(responseData[i].doctor != null) {
	            	var appointmentList = responseData[i].doctor.appointments;
	            	
	            	console.log("start of responseData");
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
	           		console.log("end of responseData");
	           		
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
			            		console.log("start of appointments")
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
			            		console.log("end of appointments");
			            		
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
        error: function (request, status, error) {
        	console.log(request);
        	console.log(status);
        	console.log(error);
        }
    });

	$('#bookAppointmentForm').submit(function () {
		$.ajax({
			   url: "/api/appointment",
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
				   alert(success);
			   },
			   failure: function (response) {
			      alert("call failed");
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

	<table id="example"
		class="table table-striped table-bordered dt-responsive"
		style="width: 100%">
		<thead>
			<tr>
				<th>Id</th>
				<th>Name</th>
				<th>E-mail</th>
				<th>Phone</th>
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