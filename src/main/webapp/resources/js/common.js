/**
 * Common utility functions
 */

// Hide Id columns and not required columns
function hideColumnById(datatable, columnid) {
	datatable.column(columnid).visible(false);
}

function disableButton(id) {
	id.attr("disabled", true);
}

function enableButton(id) {
	id.attr("disabled", false);
}

function tableSelectDeselectFunction(tableWithTBody, table, editButton,
		deleteButton) {
	tableWithTBody.on('click', 'tr', function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			disableButton(deleteButton);
			disableButton(editButton);
		} else {
			table.$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			enableButton(deleteButton);
			enableButton(editButton);
		}
	});
}

//This function add the input field in table column's footer which is useful for column wise filtering.
function tableSearch(tableFooterTh, table) {
	tableFooterTh.each(function() {
		var title = $(this).text();
		$(this)
				.html(
						'<input type="text" placeholder="Search ' + title
								+ '" />');
	});

	table.columns().every(function() {
		var that = this;

		$('input', this.footer()).on('keyup change', function() {
			if (that.search() !== this.value) {
				that.search(this.value).draw();
			}
		});
	});
}

function deleteRowTask(table, deleteButton, editButton, restUrl) {
	$.ajax({
		url : restUrl + table.rows('.selected').data()[0][0],
		type : "DELETE",
		success : function(data) {
			table.row('.selected').remove().draw(false);
			disableButton(deleteButton);
			disableButton(editButton);
		},
		error : function(request, status, errorThrown, responseText) {
			console.log("--------deleteRowTask-----------");
			console.log("request: " + request);
			console.log("status: " + status);
			console.log("errorThrown: " + errorThrown);
			console.log("responseText: " + responseText);
		}
	});
}

function deleteAllAppointmentsByDrId(table, deleteButton, editButton, restUrl) {
	$.ajax({
		url : "/api/appointment/doctor/"
				+ table.rows('.selected').data()[0][0],
		type : "DELETE",
		success : function(data) {
			deleteRowTask(table, deleteButton, editButton, restUrl);
		},
		error : function(request, status, errorThrown, responseText) {
			console.log("--------deleteRowTask-----------");
			console.log("request: " + request);
			console.log("status: " + status);
			console.log("errorThrown: " + errorThrown);
			console.log("responseText: " + responseText);
		}
	});
}

function setDateTimePickerFixedValues(dateTimePickerId) {
	dateTimePickerId.datetimepicker({
		format : 'DD-MM-YYYY HH:mm',
		//Here we have disabled time from 00:00-08:00 hours and 20:00-24:00 hours. That means user can only select timing between 08AM to 08PM.
		disabledTimeIntervals : [ [ moment({
			h : 0
		}), moment({
			h : 8
		}) ], [ moment({
			h : 19
		}), moment({
			h : 24
		}) ] ],
		enabledHours : [ 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 ],
		//This setting will allow user to set minutes in multiple of 30 only.
		stepping : 60
	});
}