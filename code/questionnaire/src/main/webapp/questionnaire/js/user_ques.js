$(function() {
	$("#save").click(function(e) {
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		var isPublic = $("#selectf1").val();
		if(isPublic == "是"){
			isPublic = 1;
		}
		else{
			isPublic = 0;
		}
		var showResult = $("#selectf2").val();
		//alert(showResult); return;
		if(showResult == "是"){
			showResult = "public";
		}
		else{
			showResult = "private";
		}
		var status = $("#state").html();
		if(status=="已发布"){
			status = "pub";
		}
		else if(status=="未发布"){
			status = "unp";
		}
		else if(status=="已结束"){
			status = "end";
		}
		var title = $("input[name='title']").val();
		var releaseTime = $("input[name='releasetime']").val();
		var endTime = $("input[name='endtime']").val();
		if(title==""){
			$("#titlea").html("请输入标题");
			return false;
		}
		else{
			$("#titlea").html("");
		}
		if(releaseTime==""){
			$("#starta").html("请选择一个日期");
			return false;
		}
		else{
			$("#starta").html("");
		}
		if(releaseTime>=endTime && endTime!=""){
			$("#enda").html("结束日期必须晚于开始日期");
			return false;
		}
		else{
			$("#enda").html("");
		}
		jQuery.ajax({
			url : 'updateQuestionnaire',
			processData : true,
			dataType : "text",
			data : {
					id 	: id,
					isPublic : isPublic,
					result : showResult,
				    status : status,
				    endTime : endTime,
				    releaseTime : releaseTime,
				    title : title,
			},
			success : function(data) {
				bootbox.alert({
					message : '修改成功！',
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
					label : '确认'
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
						url : 'delete1Questionnaire',
						processData : true,
						dataType : "text",
						data : {
							id : id
						},
						success : function(data) {
							bootbox.alert({
								message : '删除成功！',
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
		$("input[name='title']").val(dataset.title);
		$("input[name='endtime']").val(dataset.endtime.split(" ")[0]);
		$("input[name='releasetime']").val(dataset.releasetime.split(" ")[0]);
		if(dataset.status=="pub"){
			$("#state").html("已发布");
		}
		else if(dataset.status=="unp"){
			$("#state").html("未发布");
		}
		else if(dataset.status=="end"){
			$("#state").html("已结束");
		}
		
		$("#save").attr("data-id", dataset.id);
		$('#modal').modal('show');
	});
	$(".link").click(function(e) {
		bootbox.alert({
			message : 
			'<input id="qnhref" class="form-control" value='+e.currentTarget.value
			+' type="text"><input class="btn btn-default" type="button" onClick="copyUrl()" value="点击复制问卷链接" />'
			+'<p id="copytip"></p>'
		});
	});
	
});
function statechanger(){
	if($("input[name='endtime']").val()!="" && $("input[name='endtime']").val()<new Date().toISOString().split("T")[0]){
		$("#state").html("已结束");
	}
	else{
	if($("input[name='releasetime']").val()>new Date().toISOString().split("T")[0]){
		$("#state").html("未发布");
	}
	else if($("input[name='releasetime']").val()<=new Date().toISOString().split("T")[0]){
		$("#state").html("已发布");
	}}
}
function copyUrl()
{
var Url=document.getElementById("qnhref");
Url.select(); // 选择对象
document.execCommand("Copy"); // 执行浏览器复制命令
$("#copytip").html("复制成功");
}
