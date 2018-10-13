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

function deleteRowTask(table, deleteButton, restUrl) {
	deleteButton.on('click', function() {
		$.ajax({
			url : restUrl + table.rows('.selected').data()[0][0],
			type : "DELETE",
			success : function(data) {
				table.row('.selected').remove().draw(false);
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
}

//var todayDate = new Date();
function setDateTimePickerFixedValues(dateTimePickerId) {
	dateTimePickerId.datetimepicker({
		format: 'DD-MM-YYYY HH:mm',
		//minDate: todayDate,
		//Here we have disabled time from 00:00-08:00 hours and 20:00-24:00 hours. That means user can only select timing between 08AM to 08PM.
        disabledTimeIntervals: [[moment({ h: 0 }), moment({ h: 8 })], [moment({ h: 19, m: 30}), moment({ h: 24 })]],
        enabledHours: [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
        //This setting will allow user to set minutes in multiple of 30 only.
        stepping: 30
    });
}





