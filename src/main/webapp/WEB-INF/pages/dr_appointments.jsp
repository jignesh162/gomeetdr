<%@include file="header.jsp" %>
<html lang="en">
<head>
<title>Dr. Appointment Application</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script>

$(document).ready(function() {
	var t = $('#example').DataTable( {
		"order": [[ 5, "asc" ]]
    });
	
	//Hide Id columns and not required columns
    t.column( 0 ).visible( false );
	
	$("#drName").on('change', function(){
		t.clear().draw();
		getAppointments($("#drName").val());
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
	
	function getAppointments(doctorId) {
		$.ajax({
	        type: "GET",
	        url: "/api/doctor/"+doctorId+"/appointments",
	        success: function (responseData) {
	        	//var json_obj = $.parseJSON(responseData);//parse JSON
	            for (var i in responseData) 
	            {
	            	if(responseData[i].doctor != null) {
		            	var appointmentList = responseData[i].doctor.appointments;
		           		t.row.add( [
		           			responseData[i].id,
			           		responseData[i].name,
			           		responseData[i].contactNumber,
			           		responseData[i].email,
			           		responseData[i].startTime,
			           		responseData[i].endTime
		           			] ).draw( false );
		           		
		           		if(appointmentList.length > 1 && appointmentList != undefined) {
			            	for (var j in appointmentList) {
			            		if(j != 0) {
				            		t.row.add( [
				            			responseData[i].doctor.appointments[j].id,
					            		responseData[i].doctor.appointments[j].name,
					            		responseData[i].doctor.appointments[j].contactNumber,
					            		responseData[i].doctor.appointments[j].email,
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
	}//End of function
});
</script>
</head>
<body>

<div>
  <label for="drName"><span class="glyphicon glyphicon-plus"></span> Select Doctor: </label>
  <select data-size="7" data-live-search="true" class="custom_selectbox selectpicker btn-primary fill_selectbtn_in own_selectbox" data-title="Location" id="state_list" data-width="100%" id="drName">
  	<option value="0"></option>
  </select>
</div>
<div>
	<table id="example"
		class="table table-striped table-bordered dt-responsive"
		style="width: 100%">
		<thead>
			<tr>
				<th>Id</th>
				<th>Patient Name</th>
				<th>E-mail</th>
				<th>Phone</th>
				<th>Start time</th>
				<th>End time</th>
			</tr>
		</thead>
	</table>
	</div>
</body>