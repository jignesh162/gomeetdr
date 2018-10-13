<%@include file="header.jsp" %>
<html lang="en">
<head>
<title>Dr. Appointment Application</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script>
$(document).ready(function() {
	var t = $('#example').DataTable( {
		"order": [[ 0, "desc" ]]
    } );
	t.column( 0 ).visible( false );
	$('#deleteRow').attr("disabled", true);
	$('#editRow').attr("disabled", true);
	
	 t.column( 0 ).visible( true );
	 
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
	 
	 $('#addDrModal').on('hidden.bs.modal', function () {
		 alert("hi");
		 $("#addDrModal").get(0).reset();
		    alert("bye");
	 });
	 
	 $('#deleteRow').on( 'click', function () {
			$.ajax({
				   url: "/api/doctor/"+t.rows('.selected').data()[0][0],
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
		 $('#drid').val(t.rows('.selected').data()[0][0]);
		 $('#drname').val(t.rows('.selected').data()[0][1]);
		 $('#dremail').val(t.rows('.selected').data()[0][2]);
		 $('#drphone').val(t.rows('.selected').data()[0][3]);
		 $('#drtype').val(t.rows('.selected').data()[0][4]);
	});
	
	
	$.ajax({
        type: "GET",
        url: "/api/doctor",
        success: function (responseData) {
        	//var json_obj = $.parseJSON(responseData);//parse JSON
            
            for (var i in responseData) 
            {
            	t.row.add( [
            		responseData[i].id,
            		responseData[i].name,
            		responseData[i].email,
            		responseData[i].contactNumber,
            		responseData[i].type
        		] ).draw( false );
            }
        },
        error: function (request, status, error) {
        	console.log(request);
        	console.log(status);
        	console.log(error);
        }
    });

	$('#addDoctorForm').submit(function () {
		$.ajax({
			   url: "/api/doctor",
			   type: "PUT",
			   contentType: "application/json",
			   data : JSON.stringify({
				    id : $('#drid').val(),
					name : $("#drname").val(),
				   	type : $("#drtype").val(),
				   	email : $("#dremail").val(),
				   	contactNumber : $("#drphone").val()}),
			   dataType : 'json',
			   success: function (data) {
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
	<div class="pull-center">
		<button id="addRow" class="btn btn-success btn-md" data-toggle="modal"
			data-target="#addDrModal">Add</button>
		<button id="editRow" class="btn btn-warning btn-md"
			data-toggle="modal" data-target="#addDrModal">Edit</button>
		<button id="deleteRow" class="btn btn-danger btn-md">Delete</button>
	</div>

	<div class="modal fade" id="addDrModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Add doctor</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">
					<form role="form" id="addDoctorForm">
						<div class="form-group">
							<input type="hidden" id="drid" name="drid" value="0">
						</div>
						<div class="form-group">
							<label for="drname"><span
								class="glyphicon glyphicon-user"></span> Dr. Name</label> <input
								type="text" class="form-control" id="drname" name="drname"
								placeholder="Enter dr. name" required>
						</div>
						<div class="form-group">
							<label for="email"><span
								class="glyphicon glyphicon-envelope"></span> Email</label> <input
								type="email" class="form-control" id="dremail" name="dremail"
								placeholder="Enter email">
						</div>
						<div class="form-group">
							<label for="phone"><span
								class="glyphicon glyphicon-phone"></span> Mobile Number</label> <input
								type="text" class="form-control" id="drphone" name="drphone"
								placeholder="Enter mobile number">
						</div>
						<div class="form-group">
							<label for="drtype"><span
								class="glyphicon glyphicon-plus"></span> Dr. Type</label> <input
								type="text" class="form-control" id="drtype" name="drtype"
								placeholder="Enter dr. type" required>
						</div>
						<div class="modal-footer">
							<button id="submitRow" type="submit"
								class="btn btn-success btn-md">submit</button>
							<button id="closeAddDrDialog" type="button"
								class="btn btn-danger btn-md" data-dismiss="modal">Close</button>
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
				<th>Type</th>
			</tr>
		</thead>
	</table>
</body>