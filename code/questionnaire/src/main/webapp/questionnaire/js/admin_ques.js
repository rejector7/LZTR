/**
 * 
 */
$(function() {

	$("#save").click(function(e) {
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		var status = $("#selectf").val();
		
		console.log(id,status);

		jQuery.ajax({
			url : 'updateStatusQuestionnaire',
			processData : true,
			dataType : "text",
			data : {
				        id 	: id,
				     status : status,
			},
			success : function(data) {
				console.log(id);
				bootbox.alert({
					message : 'Change successfully!',
					callback : function() {
						location.reload();
					}
				});
			}
		});
		$('#modal').modal('hide');
	});

	$(".delete").click(function(e) {
		bootbox.confirm({
			buttons : {
				confirm : {
					label : 'Delete'
				},
				cancel : {
					label : 'Cancel'
				}
			},
			message : 'Sure to delete?',
			callback : function(result) {
				if (result) {

					var dataset = e.currentTarget.dataset;
					var id = dataset.id;
					jQuery.ajax({
						url : 'delete2Questionnaire',
						processData : true,
						dataType : "text",
						data : {
							id : id
						},
						success : function(data) {
							console.log(id);
							bootbox.alert({
								message : 'Delete Successfully! ',
								callback : function() {
									location.reload();
								}
							});
						}
					});

				}
			}
		});
	});

	$(".edit").click(function(e) {
		$('#modalTitle').html("修改问卷状态");
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		console.log(id);

		$("select[name='status']").val(dataset.status);

		$("#save").attr("data-id", dataset.id);
		$('#modal').modal('show');
	});

	$(".backup").click(function(e) {
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		jQuery.ajax({
			url : 'backupexport',
			processData : true,
			dataType : "text",
			data : {
				quesid : id
			},
			success : function(data) {
				exportBackup(data,id);
			}
		});
	});
});