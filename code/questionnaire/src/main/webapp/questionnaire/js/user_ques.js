$(function() {

	$("#save").click(function(e) {
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		var isPublic = $("#selectf1").val();
		var status = $("#selectf2").val();
		var title = $("input[name='title']").val();
		var releaseTime = $("input[name='releasetime']").val();
		var endTime = $("input[name='endtime']").val();
		console.log(id,isPublic,status,title,endTime, releaseTime);

		jQuery.ajax({
			url : 'updateQuestionnaire',
			processData : true,
			dataType : "text",
			data : {
					id 	: id,
					isPublic : isPublic,
				    status : status,
				    endTime : endTime,
				    releaseTime : releaseTime,
				    title : title,
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
						url : 'delete1Questionnaire',
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
		$('#modalTitle').html("修改问卷信息");
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;

		console.log(id);
		$("input[name='title']").val(dataset.title);
		$("input[name='endtime']").val(dataset.endtime);
		$("input[name='releasetime']").val(dataset.releasetime);
		$("select[name='status']").val(dataset.status);
		$("select[name='ispublic']").val(dataset.ispublic);
		
		$("#save").attr("data-id", dataset.id);
		$('#modal').modal('show');
	});

});