$(function() {
	$("#save").click(function(e) {
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		var status = $("#selectf").val();
		if(status=="未发布"){
			status="unp";
		}
		else if(status=="已发布"){
			status="pub";
		}
		else if(status=="已结束"){
			status="end";
		}
		else if(status=="禁用"){
			status="ban";
		}
		jQuery.ajax({
			url : 'updateStatusQuestionnaire',
			processData : true,
			dataType : "text",
			data : {
				        id 	: id,
				     status : status,
			},
			success : function(data) {
				bootbox.alert({
					message : '修改成功！',
					callback : function() {
						location.href= "allQuestionnaire";
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
					label : '删除'
				},
				cancel : {
					label : '取消'
				}
			},
			message : '是否删除?',
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
							bootbox.alert({
								message : '删除成功！',
								callback : function() {
									location.href= "allQuestionnaire";
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
		if(dataset.status=="pub"){
			$("select[name='status']").val("已发布");
		}
		else if(dataset.status=="unp"){
			$("select[name='status']").val("未发布");
		}
		else if(dataset.status=="end"){
			$("select[name='status']").val("已结束");
		}
		else if(dataset.status=="ban"){
			$("select[name='status']").val("禁用");
		}
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
	$("#uploadtxt").submit(function(){
		var filetype=$("#file").val().slice($("#file").val().lastIndexOf(".")+1).toUpperCase();
		if (filetype != 'TXT'){
			$("#uploadalert").html("<font color='red'>请上传正确格式的文件</font>");
			return false;
		}
	});
});