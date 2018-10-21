<%@include file="header.jsp" %>
<head>
<title><fmt:message key="doctor.title" /></title>
<script>
$(document).ready(function() {
	var rest = "/api/doctor/";
	var t = $('#doctorTable').DataTable( {
		"order": [[ 1, "asc" ]],
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
	
	tableSearch($('#doctorTable tfoot th'), t);
	
	hideColumnById(t, 0);
	disableButton($('#deleteRow'));
	disableButton($('#editRow'));
	tableSelectDeselectFunction($('#doctorTable tbody'), t, $('#editRow'), $('#deleteRow'));
	
	$('#deleteRow').on('click', function() {
		$.ajax({
			url : "/api/appointment/doctor/" + t.rows('.selected').data()[0][0],
			type : "GET",
			success : function(data) {
				if (data != 0) {
					var drName = t.rows('.selected').data()[0][1];
					//TODO Show better confirmation dialog here
					var confirmed = confirm(drName +" <fmt:message key="doctor.delete.all.appointment.confrimation" />");
					if (confirmed == true) {
						deleteAllAppointmentsByDrId(t, $('#deleteRow'), $('#editRow'), rest);
					}
				} else {
					deleteRowTask(t, $('#deleteRow'), $('#editRow'), rest);
				}
			},
			error : function(request, status, errorThrown, responseText) {
				console.log("--------deleteRowTask-----------");
				console.log("request: " + request);
				console.log("status: " + status);
				console.log("errorThrown: " + errorThrown);
				console.log("responseText: " + responseText);
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
		url: rest,
		success: function (responseData) {
			for (var i in responseData) {
			t.row.add( [
				responseData[i].id,
				responseData[i].name,
				responseData[i].email,
				responseData[i].contactNumber,
				responseData[i].type
				] ).draw( false );
			}
		},
		error : function(request, status, errorThrown, responseText) {
			console.log("--------Get doctors list----------");
			console.log("request: " + request);
			console.log("status: " + status);
			console.log("errorThrown: " + errorThrown);
			console.log("responseText: " + responseText);
		}
	});

	$('#addDoctorForm').submit(function () {
		$.ajax({
			url: rest,
			type: "PUT",
			contentType: "application/json",
			data : JSON.stringify({
					id : $('#drid').val(),
					name : $("#drname").val(),
					type : $("#drtype").val(),
					email : $("#dremail").val(),
					contactNumber : $("#drphone").val()
				}),
			dataType : 'json',
			success: function (data) {
				console.log("--Successful submission of doctor form data--");
			},
			error : function(request, status, errorThrown, responseText) {
				console.log("--------Submit doctor form data----------");
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
						<fmt:message key="doctor.modal.title" />
					</h4>
				</div>
				<div class="modal-body">
					<form role="form" id="addDoctorForm">
						<div class="form-group">
							<input type="hidden" id="drid" name="drid" value="0">
						</div>
						<div class="form-group">
							<label for="drname"><span
								class="glyphicon glyphicon-user"></span>
							<fmt:message key="doctor.modal.drname" /></label> <input type="text"
								class="form-control" id="drname" name="drname"
								placeholder="<fmt:message key="doctor.modal.placeholder.name" />"
								required>
						</div>
						<div class="form-group">
							<label for="email"><span
								class="glyphicon glyphicon-envelope"></span> <fmt:message
									key="common.table.heading.email" /></label> <input type="email"
								class="form-control" id="dremail" name="dremail"
								placeholder="<fmt:message key="common.modal.placeholder.email" />">
						</div>
						<div class="form-group">
							<label for="phone"><span
								class="glyphicon glyphicon-phone"></span> <fmt:message
									key="common.table.heading.phone" /></label> <input type="text"
								class="form-control" id="drphone" name="drphone"
								placeholder="<fmt:message key="common.modal.placeholder.phone" />">
						</div>
						<div class="form-group">
							<label for="drtype"><span
								class="glyphicon glyphicon-plus"></span> <fmt:message
									key="doctor.modal.drtype" /></label> <input type="text"
								class="form-control" id="drtype" name="drtype"
								placeholder="<fmt:message key="doctor.modal.placeholder.type" />"
								required>
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

	<div id="doctorTableDiv">
		<table id="doctorTable" class="display commonTable"
			style="width: 100%">
			<thead>
				<tr>
					<th><fmt:message key="common.table.heading.id" /></th>
					<th><fmt:message key="common.table.heading.name" /></th>
					<th><fmt:message key="common.table.heading.email" /></th>
					<th><fmt:message key="common.table.heading.phone" /></th>
					<th><fmt:message key="common.table.heading.type" /></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<th><fmt:message key="common.table.heading.id" /></th>
					<th><fmt:message key="common.table.heading.name" /></th>
					<th><fmt:message key="common.table.heading.email" /></th>
					<th><fmt:message key="common.table.heading.phone" /></th>
					<th><fmt:message key="common.table.heading.type" /></th>
				</tr>
			</tfoot>
		</table>
	</div>
</body>