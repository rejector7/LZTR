var DELETE_NUM_QUESTION = -1;
var QUES_ID = 0;
var FLAG = 0;
$(function() {	
	$(".cancel").click(function(e){
		bootbox.confirm({
			buttons : {
				confirm : {
					label : '确认'
				},
				cancel : {
					label : '取消'
				}
			},
			message : "是否确认离开？你的修改不会被保存",
			callback : function(result) {
				if(result){
				location.href = 'FrontPage';}
			}
		});
	});	
	$(".submit").click(function(e) {
		var form = document.getElementById("form");
		if(form == null){
			alert("未创建任何问题");
			return;
		}
		var childs = form.childNodes;  
		if(childs.length == 0){
			alert("未创建任何问题");
			return;
		}
		var result = {};
		if(document.getElementById("allowDup").checked==true){
			var allowDup=1;
		}
		else{
			var allowDup=0;
		}
		if(document.getElementById("resultPublished").checked==true){
			var resultPublished="public";
		}
		else{
			var resultPublished="private";
		}
		var title = $("input[name='title']").val();
		if(title=="") {alert("标题不可为空");return;}
		var intro = $("input[name='introduction']").val();
		result['introduction'] = intro;
		result['questions'] = [];
		for(var k = 0 ; k < childs.length ; k++ ){
			result['questions'][k] = {};
			result['questions'][k]['id'] = k;
			var i = childs[k].getAttribute("id").split("div")[0];
			var stem = $("input[name=" + i + "]").val();
			if(stem ==""){alert("第 " + (k*1+1) + "题题干为空");return;}
			result['questions'][k]['stem'] = stem;
			//get the required
			var required = document.getElementById(i + "required");
			if(required.checked){
				result['questions'][k]['required'] = true;
			}
			else result['questions'][k]['required'] = false;
			var imgpreview = document.getElementById(i+"imgpreview").src;
			imgpreview = encodeURIComponent(imgpreview);
			result['questions'][k]['img'] = imgpreview;
			result['questions'][k]['video'] = $("#"+i+"video").val();
			result['questions'][k]['audio'] = $("#"+i+"audio").val();
			//get the question type
			var type = (document.getElementById(i + "div")).getAttribute("value");
			switch(type){
			case '0':
				result['questions'][k]['type'] = 'Subjective';
				break;
			case '1':
				result['questions'][k]['type'] = 'Single';
				//get all the options
				var option_form = document.getElementById(i + "container");
				var options = option_form.childNodes;
				if(options.length == 1){
					alert("第 " + (k*1+1) + "题无选项");
					return;
				}
				result['questions'][k]['options'] = [];
				for(var m = 1; m < options.length; m++){
					var name = options[m].getAttribute("id").split("div")[0];
					var option = $("input[name=" + name + "]").val();
					var mm = name.split("o")[0].split("_")[1];
					var cf = document.getElementById(i+"_"+mm+"cf");
					var rele = document.getElementById(i+"_"+mm+"optrele");
					if(option == "") {alert("第"+ (k*1+1) + "题存在选项内容为空");return;}
					result['questions'][k]['options'][m-1] = {};
					result['questions'][k]['options'][m-1]['id'] = m;
					result['questions'][k]['options'][m-1]['option'] = option;
					if(cf.checked){
						result['questions'][k]['options'][m-1]['hasWords'] = true;
					}
					else result['questions'][k]['options'][m-1]['hasWords'] = false;
					if(rele.innerHTML!=""){
						var relearray = rele.getElementsByTagName("SPAN")[0].innerHTML.split(" ");
						relearray.pop();
						result['questions'][k]['options'][m-1]['relevancy'] = [];
						result['questions'][k]['options'][m-1]['relevancy'] = relearray;
					}
					var imgsrc = document.getElementById(i+"_"+mm+"imgpreview").src
					result['questions'][k]['options'][m-1]['img'] = encodeURIComponent(imgsrc);
				}
				break;
			case '2':
				result['questions'][k]['type'] = 'Multiple';
				var option_form = document.getElementById(i + "container");
				var options = option_form.childNodes;
				if(options.length == 1){
					alert("第" + (k*1+1) + "题无选项");
					return;
				}
				//get the number of options
				var num = (document.getElementById(i + "container")).getAttribute("value");
				num = num*1;
				if(num == 0 ){alert("第" + (k*1+1) + "题至少需要有一个选项");return;}
				//get min & max
				var min = $("input[name='" + i + "min']").val();
				var max = $("input[name='" + i + "max']").val();
				if(min==""){min=0;}
				if(max==""){max=options.length-1;}
				min=min*1;
				max=max*1;
				if(min > max) {alert("第"+ (k*1+1) + "题最小可选不得超过最大");return;}
				if(min < 0) {alert("第"+ (k*1+1) + "题最小可选必须不小于0");return;}
				if(max > num) {alert("第"+ (k*1+1) + "题最大选项不可超过总选项数");return;}
				result['questions'][k]['min'] = min;
				result['questions'][k]['max'] = max;
 				//get all the options
				result['questions'][k]['options'] = [];
				for(var m = 1; m < options.length; m++){
					var name = options[m].getAttribute("id").split("div")[0];
					var option = $("input[name=" + name + "]").val();
					if(option == "") {alert("第"+ (k*1+1) + "题中存在选项为空");return;}
					result['questions'][k]['options'][m-1] = {};
					result['questions'][k]['options'][m-1]['id'] = m;
					result['questions'][k]['options'][m-1]['option'] = option;
					var mm = name.split("o")[0].split("_")[1];
					var cf = document.getElementById(i+"_"+mm+"cf");
					var rele = document.getElementById(i+"_"+mm+"optrele");
					if(cf.checked){
						result['questions'][k]['options'][m-1]['hasWords'] = true;
					}
					else result['questions'][k]['options'][m-1]['hasWords'] = false;
					if(rele.innerHTML!=""){
						var relearray = rele.getElementsByTagName("SPAN")[0].innerHTML.split(" ");
						relearray.pop();
						result['questions'][k]['options'][m-1]['relevancy'] = [];
						result['questions'][k]['options'][m-1]['relevancy'] = relearray;
					}
					var imgsrc = document.getElementById(i+"_"+mm+"imgpreview").src
					result['questions'][k]['options'][m-1]['img'] = encodeURIComponent(imgsrc);
				}				
				break;
			case '3':
				result['questions'][k]['type'] = 'Slider';
				//get min & max
				var min = $("input[name='" + i + "min']").val();
				if(min==""){alert("第" +  (k*1+1) + "题最小数值为空");return;}
				var max = $("input[name='" + i + "max']").val();
				if(max==""){alert("第" +  (k*1+1) + "题最大数值为空");return;}
				var mintext = $("input[name='" + i + "mintext']").val();
				if(mintext==""){alert("第" +  (k*1+1) + "题最小值标签为空");return;}
				var maxtext = $("input[name='" + i + "maxtext']").val();
				if(maxtext==""){alert("第" +  (k*1+1) + "题最大值标签为空");return;}
				min=min*1;
				max=max*1;
				if(min > max) {alert("第" +  (k*1+1) + "题最小值不得超过最大值");return;}
				result['questions'][k]['min'] = min;
				result['questions'][k]['max'] = max;
				result['questions'][k]['mintext'] = mintext;
				result['questions'][k]['maxtext'] = maxtext;
				break;
			}
		}
		if(FLAG==1){
			bootbox.confirm({
				buttons : {
					confirm : {
						label : '确认'
					},
					cancel : {
						label : '取消'
					}
				},
				message : '这会删除此前的所有已答答卷，是否更新问卷？',
				callback : function(test) {
					if (test) {
						jQuery.ajax({
							type: "post",
							url : 'addQuestionnaire',
							processData : true,
							dataType : "text",
							data : {
								title:encodeURI(encodeURI(title)),
								id:QUES_ID,
								preview:0,
								content : encodeURI(encodeURI(JSON.stringify(result))),
								allowDup : allowDup,
								result : resultPublished
							},
							success : function(data) {
								bootbox.alert({
									message : '更新成功',
								    callback : function() {
								    	//location.href = 'FrontPage';
									}
								});
							}
						});
					}				
					}});
			return;
		}
		jQuery.ajax({
			type: "post",
			url : 'addQuestionnaire',
			processData : true,
			dataType : "text",
			data : {
				title:encodeURI(encodeURI(title)),
				id:QUES_ID,
				preview:0,
				content : encodeURI(encodeURI(JSON.stringify(result))),
				allowDup : allowDup,
				result : resultPublished
			},
			success : function(data) {
				bootbox.alert({
					message : '保存成功',
				    callback : function() {
				    	//location.href = 'FrontPage';
					}
				});
			}
		});
	});
	$(".addBlank").click(function(e){addBlank()});
	$(".addSingle").click(function(e){addSingle()});
	$(".addMultiple").click(function(e) {addMultiple()});
	$(".addSlider").click(function(e) {addSlider()});
	$(".publish").click(function(e) {
		var d = new Date().toISOString().split("T")[0];
		$("input[name='releasetime']").val(d);
		$("input[name='endtime']").val("");
		$('#modal').modal('show');
	});
	$(".preview").click(function(e) {
		var form = document.getElementById("form");
		if(form == null){
			alert("未创建任何问题");
			return;
		}
		var childs = form.childNodes;  
		if(childs.length == 0){
			alert("未创建任何问题");
			return;
		}
		var result = {};
		if(document.getElementById("allowDup").checked==true){
			var allowDup=1;
		}
		else{
			var allowDup=0;
		}
		if(document.getElementById("resultPublished").checked==true){
			var resultPublished="public";
		}
		else{
			var resultPublished="private";
		}
		var title = $("input[name='title']").val();
		if(title=="") {alert("标题不可为空");return;}
		var intro = $("input[name='introduction']").val();
		result['introduction'] = intro;
		result['questions'] = [];
		for(var k = 0 ; k < childs.length ; k++ ){
			result['questions'][k] = {};
			result['questions'][k]['id'] = k;
			var i = childs[k].getAttribute("id").split("div")[0];
			var stem = $("input[name=" + i + "]").val();
			if(stem ==""){alert("第 " + (k*1+1) + "题题干为空");return;}
			result['questions'][k]['stem'] = stem;
			//get the required
			var required = document.getElementById(i + "required");
			if(required.checked){
				result['questions'][k]['required'] = true;
			}
			else result['questions'][k]['required'] = false;
			var imgpreview = document.getElementById(i+"imgpreview").src;
			imgpreview = encodeURIComponent(imgpreview);
			result['questions'][k]['img'] = imgpreview;
			result['questions'][k]['video'] = $("#"+i+"video").val();
			result['questions'][k]['audio'] = $("#"+i+"audio").val();
			//get the question type
			var type = (document.getElementById(i + "div")).getAttribute("value");
			switch(type){
			case '0':
				result['questions'][k]['type'] = 'Subjective';
				break;
			case '1':
				result['questions'][k]['type'] = 'Single';
				//get all the options
				var option_form = document.getElementById(i + "container");
				var options = option_form.childNodes;
				if(options.length == 1){
					alert("第 " + (k*1+1) + "题无选项");
					return;
				}
				result['questions'][k]['options'] = [];
				for(var m = 1; m < options.length; m++){
					var name = options[m].getAttribute("id").split("div")[0];
					var option = $("input[name=" + name + "]").val();
					var mm = name.split("o")[0].split("_")[1];
					var cf = document.getElementById(i+"_"+mm+"cf");
					var rele = document.getElementById(i+"_"+mm+"optrele");
					if(option == "") {alert("第"+ (k*1+1) + "题存在选项内容为空");return;}
					result['questions'][k]['options'][m-1] = {};
					result['questions'][k]['options'][m-1]['id'] = m;
					result['questions'][k]['options'][m-1]['option'] = option;
					if(cf.checked){
						result['questions'][k]['options'][m-1]['hasWords'] = true;
					}
					else result['questions'][k]['options'][m-1]['hasWords'] = false;
					if(rele.innerHTML!=""){
						var relearray = rele.getElementsByTagName("SPAN")[0].innerHTML.split(" ");
						relearray.pop();
						result['questions'][k]['options'][m-1]['relevancy'] = [];
						result['questions'][k]['options'][m-1]['relevancy'] = relearray;
					}
					var imgsrc = document.getElementById(i+"_"+mm+"imgpreview").src
					result['questions'][k]['options'][m-1]['img'] = encodeURIComponent(imgsrc);
				}
				break;
			case '2':
				result['questions'][k]['type'] = 'Multiple';
				var option_form = document.getElementById(i + "container");
				var options = option_form.childNodes;
				if(options.length == 1){
					alert("第" + (k*1+1) + "题无选项");
					return;
				}
				//get the number of options
				var num = (document.getElementById(i + "container")).getAttribute("value");
				num=num*1;
				if(num == 0 ){alert("第" + (k*1+1) + "题至少需要有一个选项");return;}
				//get min & max
				var min = $("input[name='" + i + "min']").val();
				var max = $("input[name='" + i + "max']").val();
				if(min==""){min=0;}
				if(max==""){max=options.length-1;}
				min=min*1;
				max=max*1;
				if(min > max) {alert("第"+ (k*1+1) + "题最小可选不得超过最大");return;}
				if(min < 0) {alert("第"+ (k*1+1) + "题最小可选必须不小于0");return;}
				if(max > num) {alert("第"+ (k*1+1) + "题最大选项不可超过总选项数");return;}
				result['questions'][k]['min'] = min;
				result['questions'][k]['max'] = max;
 				//get all the options
				result['questions'][k]['options'] = [];
				for(var m = 1; m < options.length; m++){
					var name = options[m].getAttribute("id").split("div")[0];
					var option = $("input[name=" + name + "]").val();
					if(option == "") {alert("第"+ (k*1+1) + "题中存在选项为空");return;}
					result['questions'][k]['options'][m-1] = {};
					result['questions'][k]['options'][m-1]['id'] = m;
					result['questions'][k]['options'][m-1]['option'] = option;
					var mm = name.split("o")[0].split("_")[1];
					var cf = document.getElementById(i+"_"+mm+"cf");
					var rele = document.getElementById(i+"_"+mm+"optrele");
					if(cf.checked){
						result['questions'][k]['options'][m-1]['hasWords'] = true;
					}
					else result['questions'][k]['options'][m-1]['hasWords'] = false;
					if(rele.innerHTML!=""){
						var relearray = rele.getElementsByTagName("SPAN")[0].innerHTML.split(" ");
						relearray.pop();
						result['questions'][k]['options'][m-1]['relevancy'] = [];
						result['questions'][k]['options'][m-1]['relevancy'] = relearray;
					}
					var imgsrc = document.getElementById(i+"_"+mm+"imgpreview").src
					result['questions'][k]['options'][m-1]['img'] = encodeURIComponent(imgsrc);
				}
				
				break;
			case '3':
				result['questions'][k]['type'] = 'Slider';
				//get min & max
				var min = $("input[name='" + i + "min']").val();
				if(min==""){alert("第" +  (k*1+1) + "题最小数值为空");return;}
				var max = $("input[name='" + i + "max']").val();
				if(max==""){alert("第" +  (k*1+1) + "题最大数值为空");return;}
				var mintext = $("input[name='" + i + "mintext']").val();
				if(mintext==""){alert("第" +  (k*1+1) + "题最小值标签为空");return;}
				var maxtext = $("input[name='" + i + "maxtext']").val();
				if(maxtext==""){alert("第" +  (k*1+1) + "题最大值标签为空");return;}
				min=min*1;
				max=max*1;
				if(min > max) {alert("第" +  (k*1+1) + "题最小值不得超过最大值");return;}
				result['questions'][k]['min'] = min;
				result['questions'][k]['max'] = max;
				result['questions'][k]['mintext'] = mintext;
				result['questions'][k]['maxtext'] = maxtext;
				break;
			}
		}
		if(FLAG==1){
			bootbox.confirm({
				buttons : {
					confirm : {
						label : '确认'
					},
					cancel : {
						label : '取消'
					}
				},
				message : '这会删除此前的所有已答答卷，是否更新问卷？',
				callback : function(test) {
					if (test) {
						jQuery.ajax({
							 type: "post",
							url : 'addQuestionnaire',
							processData : true,
							dataType : "text",
							data : {
								title:encodeURI(encodeURI(title)),
								id:QUES_ID,
								preview:1,
								content : encodeURI(encodeURI(JSON.stringify(result))),
								allowDup : allowDup,
								result : resultPublished
							},
							success : function(data) {
								location.href = 'PreviewQuestionnaire?quesid='+data;
							}
						});
					}
					
					}});
			return;
		}
		alert(resultPublished);
		jQuery.ajax({
			 type: "post",
			url : 'addQuestionnaire',
			processData : true,
			dataType : "text",
			data : {
				title:encodeURI(encodeURI(title)),
				id:QUES_ID,
				preview:1,
				content : encodeURI(encodeURI(JSON.stringify(result))),
				allowDup : allowDup,
				result : resultPublished
			},
			success : function(data) {
				location.href = 'PreviewQuestionnaire?quesid='+data;
			}
		});
	});	
	$("#publishconfirm").click(function(e) {
		var form = document.getElementById("form");
		if(form == null){
			alert("未创建任何问题");
			return;
		}
		var childs = form.childNodes;  
		if(childs.length == 0){
			alert("未创建任何问题");
			return;
		}
		var result = {};
		if(document.getElementById("allowDup").checked==true){
			var allowDup=1;
		}
		else{
			var allowDup=0;
		}
		if(document.getElementById("resultPublished").checked==true){
			var resultPublished="public";
		}
		else{
			var resultPublished="private";
		}
		var title = $("input[name='title']").val();
		if(title=="") {alert("标题不可为空");return;}
		var intro = $("input[name='introduction']").val();
		result['introduction'] = intro;
		result['questions'] = [];
		for(var k = 0 ; k < childs.length ; k++ ){
			result['questions'][k] = {};
			result['questions'][k]['id'] = k;
			var i = childs[k].getAttribute("id").split("div")[0];
			var stem = $("input[name=" + i + "]").val();
			if(stem ==""){alert("第 " + (k*1+1) + "题题干为空");return;}
			result['questions'][k]['stem'] = stem;
			//get the required
			var required = document.getElementById(i + "required");
			if(required.checked){
				result['questions'][k]['required'] = true;
			}
			else result['questions'][k]['required'] = false;
			var imgpreview = document.getElementById(i+"imgpreview").src;
			imgpreview = encodeURIComponent(imgpreview);
			result['questions'][k]['img'] = imgpreview;
			result['questions'][k]['video'] = $("#"+i+"video").val();
			result['questions'][k]['audio'] = $("#"+i+"audio").val();
			//get the question type
			var type = (document.getElementById(i + "div")).getAttribute("value");
			switch(type){
			case '0':
				result['questions'][k]['type'] = 'Subjective';
				break;
			case '1':
				result['questions'][k]['type'] = 'Single';
				//get all the options
				var option_form = document.getElementById(i + "container");
				var options = option_form.childNodes;
				if(options.length == 1){
					alert("第 " + (k*1+1) + "题无选项");
					return;
				}
				result['questions'][k]['options'] = [];
				for(var m = 1; m < options.length; m++){
					var name = options[m].getAttribute("id").split("div")[0];
					var option = $("input[name=" + name + "]").val();
					var mm = name.split("o")[0].split("_")[1];
					var cf = document.getElementById(i+"_"+mm+"cf");
					var rele = document.getElementById(i+"_"+mm+"optrele");
					if(option == "") {alert("第"+ (k*1+1) + "题存在选项内容为空");return;}
					result['questions'][k]['options'][m-1] = {};
					result['questions'][k]['options'][m-1]['id'] = m;
					result['questions'][k]['options'][m-1]['option'] = option;
					if(cf.checked){
						result['questions'][k]['options'][m-1]['hasWords'] = true;
					}
					else result['questions'][k]['options'][m-1]['hasWords'] = false;
					if(rele.innerHTML!=""){
						var relearray = rele.getElementsByTagName("SPAN")[0].innerHTML.split(" ");
						relearray.pop();
						result['questions'][k]['options'][m-1]['relevancy'] = [];
						result['questions'][k]['options'][m-1]['relevancy'] = relearray;
					}
					var imgsrc = document.getElementById(i+"_"+mm+"imgpreview").src
					result['questions'][k]['options'][m-1]['img'] = encodeURIComponent(imgsrc);
				}
				break;
			case '2':
				result['questions'][k]['type'] = 'Multiple';
				var option_form = document.getElementById(i + "container");
				var options = option_form.childNodes;
				if(options.length == 1){
					alert("第" + (k*1+1) + "题无选项");
					return;
				}
				//get the number of options
				var num = (document.getElementById(i + "container")).getAttribute("value");
				num=num*1;
				if(num == 0 ){alert("第" + (k*1+1) + "题至少需要有一个选项");return;}
				//get min & max
				var min = $("input[name='" + i + "min']").val();
				var max = $("input[name='" + i + "max']").val();
				if(min==""){min=0;}
				if(max==""){max=options.length-1;}
				min=min*1;
				max=max*1;
				if(min > max) {alert("第"+ (k*1+1) + "题最小可选不得超过最大");return;}
				if(min < 0) {alert("第"+ (k*1+1) + "题最小可选必须不小于0");return;}
				if(max > num) {alert("第"+ (k*1+1) + "题最大选项不可超过总选项数");return;}
				result['questions'][k]['min'] = min;
				result['questions'][k]['max'] = max;
 				//get all the options
				result['questions'][k]['options'] = [];
				for(var m = 1; m < options.length; m++){
					var name = options[m].getAttribute("id").split("div")[0];
					var option = $("input[name=" + name + "]").val();
					if(option == "") {alert("第"+ (k*1+1) + "题中存在选项为空");return;}
					result['questions'][k]['options'][m-1] = {};
					result['questions'][k]['options'][m-1]['id'] = m;
					result['questions'][k]['options'][m-1]['option'] = option;
					var mm = name.split("o")[0].split("_")[1];
					var cf = document.getElementById(i+"_"+mm+"cf");
					var rele = document.getElementById(i+"_"+mm+"optrele");
					if(cf.checked){
						result['questions'][k]['options'][m-1]['hasWords'] = true;
					}
					else result['questions'][k]['options'][m-1]['hasWords'] = false;
					if(rele.innerHTML!=""){
						var relearray = rele.getElementsByTagName("SPAN")[0].innerHTML.split(" ");
						relearray.pop();
						result['questions'][k]['options'][m-1]['relevancy'] = [];
						result['questions'][k]['options'][m-1]['relevancy'] = relearray;
					}
					var imgsrc = document.getElementById(i+"_"+mm+"imgpreview").src
					result['questions'][k]['options'][m-1]['img'] = encodeURIComponent(imgsrc);
				}
				
				break;
			case '3':
				result['questions'][k]['type'] = 'Slider';
				//get min & max
				var min = $("input[name='" + i + "min']").val();
				if(min==""){alert("第" +  (k*1+1) + "题最小数值为空");return;}
				var max = $("input[name='" + i + "max']").val();
				if(max==""){alert("第" +  (k*1+1) + "题最大数值为空");return;}
				var mintext = $("input[name='" + i + "mintext']").val();
				if(mintext==""){alert("第" +  (k*1+1) + "题最小值标签为空");return;}
				var maxtext = $("input[name='" + i + "maxtext']").val();
				if(maxtext==""){alert("第" +  (k*1+1) + "题最大值标签为空");return;}
				min=min*1;
				max=max*1;
				if(min > max) {alert("第" +  (k*1+1) + "题最小值不得超过最大值");return;}
				result['questions'][k]['min'] = min;
				result['questions'][k]['max'] = max;
				result['questions'][k]['mintext'] = mintext;
				result['questions'][k]['maxtext'] = maxtext;
				break;
			}
		}
		var isPublic = $("#selectf1").val();
		if(isPublic == "是"){
			isPublic = 1;
		}
		else{
			isPublic = 0;
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
		var releaseTime = $("input[name='releasetime']").val();
		var endTime = $("input[name='endtime']").val();
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
		if(FLAG==1){
			bootbox.confirm({
				buttons : {
					confirm : {
						label : '确认'
					},
					cancel : {
						label : '取消'
					}
				},
				message : '这会删除此前的所有已答答卷，是否更新问卷？',
				callback : function(test) {
					if (test) {
						jQuery.ajax({
							 type: "post",
							url : 'addQuestionnaire',
							processData : true,
							dataType : "text",
							data : {
								title:encodeURI(encodeURI(title)),
								id:QUES_ID,
								content : encodeURI(encodeURI(JSON.stringify(result))),
								isPublic : isPublic,
								status : status,
							    endTime : endTime,
							    releaseTime : releaseTime,
							    allowDup : allowDup,
							    result : resultPublished,
							    preview:0
							},
							success : function(data) {
								bootbox.alert({
									message : '更新成功并已发布<br>'+
									'<input id="qnhref" class="form-control" value="localhost:8080/questionnaire/FillQuestionnaire?quesid='+data
									+'"type="text"><input class="btn btn-default" type="button" onClick="copyUrl()" value="点击复制问卷链接" />'
									+'<p id="copytip"></p>',
								    callback : function() {
								    	location.href = 'FrontPage';
									}
								});
							}
						});
					}
					
					}});
			return;
		}
		jQuery.ajax({
			 type: "post",
			url : 'addQuestionnaire',
			processData : true,
			dataType : "text",
			data : {
				title:encodeURI(encodeURI(title)),
				id:QUES_ID,
				content : encodeURI(encodeURI(JSON.stringify(result))),
				isPublic : isPublic,
				status : status,
			    endTime : endTime,
			    releaseTime : releaseTime,
			    allowDup : allowDup,
			    result : resultPublished,
			    preview:0
			},
			success : function(data) {
				bootbox.alert({
					message : '发布成功<br>'+
					'<input id="qnhref" class="form-control" value="localhost:8080/questionnaire/FillQuestionnaire?quesid='+data
					+'"type="text"><input class="btn btn-default" type="button" onClick="copyUrl()" value="点击复制问卷链接" />'
					+'<p id="copytip"></p>',
				    callback : function() {
				    	location.href = 'FrontPage';
					}
				});
			}
		});
	});	
	$('#modal2').on('hide.bs.modal', function () {
		if(document.getElementById("relacloser").dataset.id!=""){
			document.getElementById(document.getElementById("relacloser").dataset.id+"relevancy").checked=false;
		}
	});	
	$("#relatconfirm").click(function(e) {
		var opts = document.getElementById("specoptiondiv").getElementsByTagName("INPUT");
		var optlabels = document.getElementById("specoptiondiv").getElementsByTagName("LABEL");
		var quess = document.getElementById("laterques").getElementsByTagName("INPUT");
		var queslabels = document.getElementById("laterques").getElementsByTagName("LABEL");
		var index = document.getElementById("formerques").selectedIndex;
		var releques = document.getElementById("formerques").options[index].innerHTML;
		var formquess = document.getElementById("form").childNodes;
		var optids = "";
		var quesids = e.currentTarget.dataset.id+" ";
		for(var i=0;i<opts.length;i++){
			if(opts[i].checked==true){
				optids += optlabels[i].innerHTML+" ";
			}
		}
		if(optids==""){
			document.getElementById(document.getElementById("relacloser").dataset.id+"relevancy").checked=false;
			$("#relacloser").attr("data-id", "");
			$("#relatconfirm").attr("data-id", "");
			$('#modal2').modal('hide');
			return;
		}
		for(var i=0;i<quess.length;i++){
			if(quess[i].checked==true){
				var j = queslabels[i].innerHTML.split(".")[0];
				for(var k=0;k<formquess.length;k++){
			    	if($("#"+formquess[k].id.split("d")[0]+"divfont").html() == j){
			    		j = formquess[k].id.split("d")[0];
			    		break;
			    	}
			    }
				quesids += j+" ";
			}
		}
		var quesidarray = quesids.split(" ");
		for(var i=0;i<quesidarray.length-1;i++){
			$("#"+quesidarray[i]+"showrelevancy").html(
				"关联：本题在 <span>" +
				releques+
				"</span> 中的以下选项中某一项被选中时出现: <span>" +
				optids+"</span>");
			document.getElementById(quesidarray[i]+"relevancy").checked=true;
		}
		var relequesid = releques.split(".")[0];
		for(var k=0;k<formquess.length;k++){
	    	if($("#"+formquess[k].id.split("d")[0]+"divfont").html() == relequesid){
	    		relequesid = formquess[k].id.split("d")[0];
	    		break;
	    	}
	    }
		optids="";
		for(var i=0;i<opts.length;i++){
			if(opts[i].checked==true){
				optids += document.getElementById(relequesid+"container").childNodes[i+1].id.split("_")[1].split("o")[0]+" ";
			}
		}
		var optidarray = optids.split(" ");
		quesids = $("#"+e.currentTarget.dataset.id+"divfont").html()+" ";
		for(var i=0;i<quess.length;i++){
			if(quess[i].checked==true){
				var j = queslabels[i].innerHTML.split(".")[0];
				quesids += j+" ";
			}
		}		
		for(var i=0;i<optidarray.length-1;i++){
			if($("#"+relequesid+"_"+optidarray[i]+"optrele").html()==""){
			$("#"+relequesid+"_"+optidarray[i]+"optrele").html(
				"本选项与以下题号所代表的题目关联: <span>" +
				quesids+
				"</span>"
				);
			}
			else{
				$("#"+relequesid+"_"+optidarray[i]+"optrele").html(
						"本选项与以下题号所代表的题目关联: <span>" +
						document.getElementById(relequesid+"_"+optidarray[i]+"optrele").getElementsByTagName("SPAN")[0].innerHTML+quesids+
						"</span>"
				);
			}
		}
		$("#relacloser").attr("data-id", "");
		$("#relatconfirm").attr("data-id", "");
		$('#modal2').modal('hide');
	});
});
function seekQuesByQuesNo(quesid){
	var quess = document.getElementById("form").childNodes;
	for(var i=0;i<quess.length;i++){
    	if($("#"+quess[i].id.split("d")[0]+"divfont").html() == quesid){
    		quesid = quess[i].id.split("d")[0];
    		break;
    	}
    }
	return quesid;
}
function addOption(value, isMultiple = false){
	if(isMultiple) 	$("input[name='"+value+"max'").val($("input[name='"+value+"max'").val() * 1 + 1 * 1) ;
	

	
	var div = document.getElementById(value + "container");
	var num = div.getAttribute("value");
	var newdiv = document.createElement("div");
	newdiv.id = value + "_" +num + "optiondiv";
	div.appendChild(newdiv);
	$("#" + value + "_" + num + "optiondiv").html("" +
			"<div class='container'>" +
			"<div class='row container col-lg-8'>" +
			"<input class='form-control' name='" + value +"_" + num + "option' onfocusout='changeReleInQues("+value+","+num+")'  onfocusin='onchangingReleInQues("+value+","+num+")'>" +
			"</div>" +
			"<div class='col-lg-2'><div id='" + value +"_" + num +"button'>" +
			"</div></div>" +
			"<div class='col-lg-2'>" +
			"<label>需要填写文本</label>" +
			"<input type='checkbox' id='" + value + "_" + num + "cf'>" +
			"</div>" +
			"<div class='col-lg-12' id='" + value + "_" + num + "optrele'></div>"+
			"<div class='row' style='height:5px'></div>" +
			"<div class='row container'><div class='col-lg-4'><input class='btn btn-default'  type='file' id='" + value + "_" + num + "img' onchange='readLocalFile(\"" + value + "_" + num + "\")' accept='.jpg,.jpeg,.bmp,.png'><img id='" + value + "_" + num + "imgpreview'></div>" +
			"<div class='col-lg-2'><button class='btn btn-default' type='button' id='"+ value + "_" + num +"imgcancel' onclick='cancelFile(\""+ value + "_" + num +"\")'><i class='fa fa-times'>取消</i></button></div></div>" +
			"</div>");

	div.setAttribute("value",  num * 1 + 1);	
	//create button to delete an question
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){deleteOption(value, num)};
	document.getElementById(value +"_" + num +"button").appendChild(button);	
	var upbutton = document.createElement("button");
	upbutton.className = "btn btn-default";
	upbutton.type = "button";
	upbutton.style="floating:left";
	upbutton.onclick = function(){upOption(value, num)};
	document.getElementById(value +"_" + num +"button").appendChild(upbutton);	
	var downbutton = document.createElement("button");
	downbutton.className = "btn btn-default";
	downbutton.type = "button";
	downbutton.style="floating:left";
	downbutton.onclick = function(){downOption(value, num)};
	document.getElementById(value +"_" + num +"button").appendChild(downbutton);	
	var appendbutton = document.createElement("button");
	appendbutton.className = "btn btn-default";
	appendbutton.type = "button";
	appendbutton.style="floating:left";
	appendbutton.onclick = function(){appendOption(value, num)};
	document.getElementById(value +"_" + num +"button").appendChild(appendbutton);	
	var i = document.createElement("i");
	i.className = "fa fa-times";
	button.appendChild(i);
	var iup = document.createElement("i");
	iup.className = "fa fa-chevron-up";
	upbutton.appendChild(iup);
	var idown = document.createElement("i");
	idown.className = "fa fa-chevron-down";
	downbutton.appendChild(idown);
	var iappend = document.createElement("i");
	iappend.className = "fa fa-plus";
	appendbutton.appendChild(iappend);
	
	//document.getElementById(value+"_"+num+"optiondiv").scrollIntoView();
}
function getRelesFromOpt(optrele){
	if(optrele.innerHTML==""){
		return null;
	}
	return optrele.getElementsByTagName("SPAN")[0].innerHTML.split(" ");
}
function deleteRelevancyByQuestion(value){
	if(document.getElementById(value+"showrelevancy").innerHTML==""){
		return false;
	}
	var quesno = document.getElementById(value+"showrelevancy").getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
	var optcontents = document.getElementById(value+"showrelevancy").getElementsByTagName("SPAN")[1].innerHTML.split(" ");
	quesno = seekQuesByQuesNo(quesno);
	var optsnum = document.getElementById(quesno+"container").childNodes.length-1;
	var subopts = document.getElementById(quesno+"container").childNodes;
	for(var m=1;m<=optsnum;m++){
		var i = subopts[m].id.split("_")[1].split("o")[0];
		var input = $("input[name='"+quesno+"_"+i+"option'").val();
		for(var j=0;j<optcontents.length-1;j++){
			if(optcontents[j]==input){
				if(document.getElementById(quesno+"_"+i+"optrele").innerHTML!=""){
				var idarray = document.getElementById(quesno+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
				if(idarray.indexOf($("#"+value+"divfont").html())!=-1){
				idarray.splice(idarray.indexOf($("#"+value+"divfont").html()),1);
				}
				var tmpid = "";
				for(var k=0;k<idarray.length-1;k++){
					tmpid+=idarray[k]+" ";
				}
				if(tmpid!=""){
					document.getElementById(quesno+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
				}
				else{
					$("#"+quesno+"_"+i+"optrele").html("");
				}
			}
		}
	}
	}
	$("#"+value+"showrelevancy").html("");
}
function deleteRelevancyByOption(id){
	var quesrelearray = getRelesFromOpt(document.getElementById(id+"optrele"));
	var optvalue = $("#"+id+"option").val();
	for(var i=0; i<quesrelearray.length-1; i++){
		var thisquesid = seekQuesByQuesNo(quesrelearray[i]);
		var thisquesrele = document.getElementById(thisquesid+"showrelevancy").getElementsByTagName("SPAN");
		var relequesid = seekQuesByQuesNo(thisquesrele[0].innerHTML.split(".")[0]);
		var optcontents = thisquesrele[1].innerHTML.split(" ");
		var index = optcontents.indexOf($("#"+id+"divfont").html());
		if(index=-1){
			optcontents.splice(index,1);
		}
		var newoptcontents = "";
		for(var j=0;j<optcontents.length-1;j++){
			newoptcontents += optcontents[j]+" ";
		}
		if(newoptcontents != ""){
			thisquesrele[1].innerHTML = newoptcontents;
		}
		else{
			document.getElementById(thisquesid+"relevancy").checked = false;
			$("#"+thisquesid+"showrelevancy").html("");
		}
	}
}
function deleteQuestion(value){
	var victim = document.getElementById(value +"div");
	deleteRelevancyByQuestion(value);
	if(victim.getAttributeNode("value").value==1||victim.getAttributeNode("value").value==2){
		var opts = document.getElementById(value +"container").childNodes;
		for(var i=1;i<opts.length;i++){
			var preid = opts[i].id.split("o")[0];
			if($("#"+preid+"optrele").html()!=""){
				deleteRelevancyByOption(preid);
			}
		}
	}
	var victimno = document.getElementById(value +"divfont").innerHTML;
	document.getElementById(value +"divfont").innerHTML = -1;
	var next = victim.nextSibling;
	while(next !=null){
		var id = next.getAttribute("id");
		var font = document.getElementById(id +"font");
		var nextno = font.innerText;
		font.innerText = font.innerText * 1 - 1;		
		var rele = document.getElementById(next.getAttribute("id").split("d")[0]+"showrelevancy");
		if(rele.innerHTML!=""){
			var releno = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
			if(releno>victimno){
				var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
				rele.getElementsByTagName("SPAN")[0].innerHTML = (releno-1) + "."+relecontent;
				var quesid = seekQuesByQuesNo(releno-1);
				var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
				var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
				var subopts = document.getElementById(quesid+"container").childNodes;
				for(var m=1;m<=optsnum;m++){
					var i = subopts[m].id.split("_")[1].split("o")[0];
					var input = $("input[name='"+quesid+"_"+i+"option'").val();
					for(var j=0;j<optcontents.length-1;j++){
						if(optcontents[j]==input){
							if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
							var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
							if(idarray.indexOf(nextno)!=-1){
							idarray.splice(idarray.indexOf(nextno),1,nextno-1);
							}
							var tmpid = "";
							for(var k=0;k<idarray.length-1;k++){
								tmpid+=idarray[k]+" ";
							}
							document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
						}
					}
				}
				}
			}
			else if(releno<victimno){
				var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
				rele.getElementsByTagName("SPAN")[0].innerHTML = (releno) + "."+relecontent;
				var quesid = seekQuesByQuesNo(releno);
				var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
				var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
				var subopts = document.getElementById(quesid+"container").childNodes;
				for(var m=1;m<=optsnum;m++){
					var i = subopts[m].id.split("_")[1].split("o")[0];
					var input = $("input[name='"+quesid+"_"+i+"option'").val();
					for(var j=0;j<optcontents.length-1;j++){
						if(optcontents[j]==input){
							if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
							var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
							if(idarray.indexOf(nextno)!=-1){
							idarray.splice(idarray.indexOf(nextno),1,nextno-1);
							}
							var tmpid = "";
							for(var k=0;k<idarray.length-1;k++){
								tmpid+=idarray[k]+" ";
							}
							document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
						}
					}
				}
				}
			}
		}		
		next = next.nextSibling;
	}
	var form = document.getElementById("form");
	form.removeChild(victim);
	DELETE_NUM_QUESTION += 1;
}
function deleteOption(value, num){
	if($("input[name='"+value+"max'").val()) 	$("input[name='"+value+"max'").val($("input[name='"+value+"max'").val() - 1 * 1) ;
	var container = document.getElementById(value +"container");
	var victim = document.getElementById(value +"_" + num+"optiondiv");
	if($("#"+value+"_"+num+"optrele").html()!=""){
		deleteRelevancyByOption(value+"_"+num);
	}
	container.removeChild(victim);
}
function upOption(value, num){
	var option_form = document.getElementById(value +"container");
	var options = option_form.childNodes;
	if(options[1].id.split("_")[1].split("o")[0]==num){
		return false;
	}
	for(var i=2;i<options.length;i++){
		if(options[i].id.split("_")[1].split("o")[0]==num){
			num = i-1;
			break;
		}
	}
	var name1 = options[num*1+1].getAttribute("id").split("div")[0];
	var option1 = $("input[name=" + name1 + "]").val();
	var id1 = name1.split("option")[0];
	var img1 = document.getElementById(id1+"imgpreview").src;
	var cf1 = document.getElementById(id1+"cf");
	var name2 = options[num*1].getAttribute("id").split("div")[0];
	var option2 = $("input[name=" + name2 + "]").val();
	var id2 = name2.split("option")[0];
	var cf2 = document.getElementById(id2+"cf");
	var img2 = document.getElementById(id2+"imgpreview").src;
	$("input[name=" + name1 + "]").val(option2);
	$("input[name=" + name2 + "]").val(option1);
	var tmp = cf1.checked;
	cf1.checked = cf2.checked;
	cf2.checked = tmp;
	if(img2){
		document.getElementById(id1+"imgpreview").src = img2;
	}
	else{
		document.getElementById(id1+"imgpreview").removeAttribute("src");
	}
	if(img1){
		document.getElementById(id2+"imgpreview").src = img1;
	}
	else{
		document.getElementById(id2+"imgpreview").removeAttribute("src");
	}
	$("#"+id1+"img").val("");
	$("#"+id2+"img").val("");
	var releques1 = $("#"+id1+"optrele").html();
	var releques2 = $("#"+id2+"optrele").html();
	$("#"+id1+"optrele").html(releques2);
	$("#"+id2+"optrele").html(releques1);	
}
function downOption(value, num){
	var option_form = document.getElementById(value +"container");
	var options = option_form.childNodes;
	if(options[options.length-1].id.split("_")[1].split("o")[0]==num){
		return false;
	}
	for(var i=2;i<options.length;i++){
		if(options[i].id.split("_")[1].split("o")[0]==num){
			num = i-1;
			break;
		}
	}
	var name1 = options[num*1+1].getAttribute("id").split("div")[0];
	var option1 = $("input[name=" + name1 + "]").val();
	var id1 = name1.split("option")[0];
	var cf1 = document.getElementById(id1+"cf");
	var img1 = document.getElementById(id1+"imgpreview").src;
	var name2 = options[num*1+2].getAttribute("id").split("div")[0];
	var option2 = $("input[name=" + name2 + "]").val();
	var id2 = name2.split("option")[0];
	var cf2 = document.getElementById(id2+"cf");
	var img2 = document.getElementById(id2+"imgpreview").src;
	$("input[name=" + name1 + "]").val(option2);
	$("input[name=" + name2 + "]").val(option1);
	var tmp = cf1.checked;
	cf1.checked = cf2.checked;
	cf2.checked = tmp;
	var releques1 = $("#"+id1+"optrele").html();
	var releques2 = $("#"+id2+"optrele").html();
	if(img2){
		document.getElementById(id1+"imgpreview").src = img2;
	}
	else{
		document.getElementById(id1+"imgpreview").removeAttribute("src");
	}
	if(img1){
		document.getElementById(id2+"imgpreview").src = img1;
	}
	else{
		document.getElementById(id2+"imgpreview").removeAttribute("src");
	}
	$("#"+id1+"img").val("");
	$("#"+id2+"img").val("");
	$("#"+id1+"optrele").html(releques2);
	$("#"+id2+"optrele").html(releques1);	
}
function appendOption(value, oldnum){
	var div = document.getElementById(value + "container");
	var num = div.getAttribute("value");
	var newdiv = document.createElement("div");
	newdiv.id = value + "_" +num + "optiondiv";
	var olddiv = document.getElementById(value+"_"+oldnum+"optiondiv").nextSibling;
	if(olddiv==null){
		div.appendChild(newdiv);
	}
	else{
		div.insertBefore(newdiv, olddiv);
	}
	$("#" + value + "_" + num + "optiondiv").html("" +
			"<div class='container'>" +
			"<div class='row container col-lg-8'>" +
			"<input class='form-control' name='" + value +"_" + num + "option' onfocusout='changeReleInQues("+value+","+num+")' onfocusin='onchangingReleInQues("+value+","+num+")'>" +
			"</div>" +
			"<div class='col-lg-2'><div id='" + value +"_" + num +"button'>" +
			"</div></div>" +
			"<div class='col-lg-2'>" +
			"<label>是否需要填写文本</label>" +
			"<input type='checkbox' id='" + value + "_" + num + "cf'>" +
			"</div>"+
			"<div class='col-lg-12' id='" + value + "_" + num + "optrele'></div>"+
			"<div class='row container'><div class='col-lg-12'><input type='file' id='" + value + "_" + num + "img' onchange='readLocalFile(\"" + value + "_" + num + "\")' accept='.jpg,.jpeg,.bmp,.png'><img id='" + value + "_" + num + "imgpreview'><button type='button' id='"+ value + "_" + num +"imgcancel' onclick='cancelFile(\""+ value + "_" + num +"\")'>取消</button></div></div>" +
			"</div>");
	div.setAttribute("value",  num * 1 + 1);	
	//create button to delete an question
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){deleteOption(value, num)};
	document.getElementById(value +"_" + num +"button").appendChild(button);	
	var upbutton = document.createElement("button");
	upbutton.className = "btn btn-default";
	upbutton.type = "button";
	upbutton.style="floating:left";
	upbutton.onclick = function(){upOption(value, num)};
	document.getElementById(value +"_" + num +"button").appendChild(upbutton);	
	var downbutton = document.createElement("button");
	downbutton.className = "btn btn-default";
	downbutton.type = "button";
	downbutton.style="floating:left";
	downbutton.onclick = function(){downOption(value, num)};
	document.getElementById(value +"_" + num +"button").appendChild(downbutton);	
	var appendbutton = document.createElement("button");
	appendbutton.className = "btn btn-default";
	appendbutton.type = "button";
	appendbutton.style="floating:left";
	appendbutton.onclick = function(){appendOption(value, num)};
	document.getElementById(value +"_" + num +"button").appendChild(appendbutton);	
	var i = document.createElement("i");
	i.className = "fa fa-times";
	button.appendChild(i);
	var iup = document.createElement("i");
	iup.className = "fa fa-chevron-up";
	upbutton.appendChild(iup);
	var idown = document.createElement("i");
	idown.className = "fa fa-chevron-down";
	downbutton.appendChild(idown);
	var iappend = document.createElement("i");
	iappend.className = "fa fa-plus";
	appendbutton.appendChild(iappend);
}
function addBlank() {
	var body = document.body;
	var value = body.getAttribute("value");
	//create form
	if(value=="0"){
	var form = document.createElement("form");
	form.id = 'form';
	form.role = "role";
	body.appendChild(form);
	$("#form").sortable({
		axis: "y" ,
		cursor: "move",
		stop: function( event, ui ) {
			var children = form.childNodes;
			var thisid = ui.item.attr("id").split("d")[0];
			var oldno = $("#"+thisid+"divfont").html();
			var rele = document.getElementById(thisid+"showrelevancy");
			var initquesid = "";
			if(rele.innerHTML!=""){
				initquesid = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
				initquesid = seekQuesByQuesNo(initquesid);
			}
			for(var i=0;i<children.length;i++){
				var id = children[i].getAttribute("id");
				$("#"+id+"font").html(i+1);
			}			
			var thisno = $("#"+thisid+"divfont").html();
			if(rele.innerHTML!=""){
				var quesid = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
				if(thisno*1<=quesid*1){
					$("#form").sortable("cancel");
					for(var i=0;i<children.length;i++){
						var id = children[i].getAttribute("id");
						$("#"+id+"font").html(i+1);
					}
					return;
				}
			}
			if(ui.item.attr("value")==1||ui.item.attr("value")==2){
				var opts = document.getElementById(ui.item.attr("id").split("d")[0]+"container").childNodes;
				for(var i=1;i<opts.length;i++){
					var quesrelearray = getRelesFromOpt(document.getElementById(opts[i].id.split("o")[0]+"optrele"));
					if(quesrelearray!=null){
						for(var j=0;j<quesrelearray.length-1;j++){
							if(thisno*1>=quesrelearray[j]*1){
								$("#form").sortable("cancel");
								for(var i=0;i<children.length;i++){
									var id = children[i].getAttribute("id");
									$("#"+id+"font").html(i+1);
								}
								return;
							}
						}
					}					
				}
			}
			if(oldno>thisno){
				if(initquesid!=""){
					var quesid = initquesid;
					var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
					var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
					var subopts = document.getElementById(quesid+"container").childNodes;
					for(var m=1;m<=optsnum;m++){
						var i = subopts[m].id.split("_")[1].split("o")[0];						
						var input = $("input[name='"+quesid+"_"+i+"option'").val();
						for(var j=0;j<optcontents.length-1;j++){							
							if(optcontents[j]==input){
								if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
								var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
								if(idarray.indexOf(oldno)!=-1){
								idarray.splice(idarray.indexOf(oldno),1,thisno);
								}
								var tmpid = "";
								for(var k=0;k<idarray.length-1;k++){
									tmpid+=idarray[k]+" ";
								}
								document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
							}
						}
					}
					}
				}				
				for(var i=thisno-1;i<children.length;i++){
					var rele = document.getElementById(children[i].getAttribute("id").split("d")[0]+"showrelevancy");
					if(rele.innerHTML!=""){
						var releno = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];						
						var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
						if(releno==oldno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = thisno+"."+relecontent;
						}
						else if(releno<oldno&&releno>=thisno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = (releno*1+1)+"."+relecontent;
							if(i<oldno&&i>=thisno){
								var quesid = seekQuesByQuesNo(releno*1+1);
							}
							else{
								var quesid = seekQuesByQuesNo(releno*1);
							}
							if(document.getElementById(quesid+"div").getAttribute("value")=="1"||document.getElementById(quesid+"div").getAttribute("value")=="2"){
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
											if(idarray.indexOf(String(i))!=-1){
											idarray.splice(idarray.indexOf(String(i)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}
						}
						}
						else if(releno<thisno){							
								var quesid = seekQuesByQuesNo(releno*1);
								if(document.getElementById(quesid+"div").getAttribute("value")=="1"||document.getElementById(quesid+"div").getAttribute("value")=="2"){
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){										
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");											
											if(idarray.indexOf(String(i))!=-1){
												idarray.splice(idarray.indexOf(String(i)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}
						}
						}						
					}
				}
			}
			else if(oldno<thisno){
				if(initquesid!=""){
					var quesid = initquesid;
					var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
					var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
					var subopts = document.getElementById(quesid+"container").childNodes;
					for(var m=1;m<=optsnum;m++){
						var i = subopts[m].id.split("_")[1].split("o")[0];
						var input = $("input[name='"+quesid+"_"+i+"option'").val();
						for(var j=0;j<optcontents.length-1;j++){
							if(optcontents[j]==input){
								if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
								var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
								if(idarray.indexOf(oldno)!=-1){
								idarray.splice(idarray.indexOf(oldno),1,thisno);
								}
								var tmpid = "";
								for(var k=0;k<idarray.length-1;k++){
									tmpid+=idarray[k]+" ";
								}
								document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
							}
						}
					}
					}
				}
				for(var i=oldno-1;i<children.length;i++){
					var rele = document.getElementById(children[i].getAttribute("id").split("d")[0]+"showrelevancy");
					if(rele.innerHTML!=""){
						var releno = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
						var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
						if(releno==oldno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = thisno+"."+relecontent;
						}
						else if(releno>oldno&&releno<=thisno){
							if(i>=oldno-1&&i<thisno-1){
								var quesid = seekQuesByQuesNo(releno*1-1);
							}
							else{
								var quesid = seekQuesByQuesNo(releno*1);
							}
							rele.getElementsByTagName("SPAN")[0].innerHTML = (releno*1-1)+"."+relecontent;
							if(document.getElementById(quesid+"div").getAttribute("value")=="1"||document.getElementById(quesid+"div").getAttribute("value")=="2"){
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];									
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){										
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
											if(idarray.indexOf(String(i+2))!=-1){
											idarray.splice(idarray.indexOf(String(i+2)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}
						}
						}
						else if(releno<oldno){							
							var quesid = seekQuesByQuesNo(releno*1);
							if(document.getElementById(quesid+"div").getAttribute("value")=="1"||document.getElementById(quesid+"div").getAttribute("value")=="2"){
							var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
							var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
							var subopts = document.getElementById(quesid+"container").childNodes;
							for(var m=1;m<=optsnum;m++){
								var n = subopts[m].id.split("_")[1].split("o")[0];
								var input = $("input[name='"+quesid+"_"+n+"option'").val();
								for(var j=0;j<optcontents.length-1;j++){									
									if(optcontents[j]==input){
										if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
										var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");										
										if(idarray.indexOf(String(i+2))!=-1){
											idarray.splice(idarray.indexOf(String(i+2)),1,(i*1+1));
										}
										var tmpid = "";
										for(var k=0;k<idarray.length-1;k++){
											tmpid+=idarray[k]+" ";
										}
										document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
									}
								}
							}
							}
						}
					}
					}
				}
			}			
		}
	});
	}
	else{
		var form = document.getElementById("form");
	}	
	//create div
	var div = document.createElement("div");
	div.id = value + "div";
	div.setAttribute("value", "0");
	form.appendChild(div);
	$("#"+value+"div").html("" +
			"<div class='form-group container' style='background:#fff;border:1px solid #c0c0c0;border-radius:5px'><br><div class='row'>" +
			"<div class='col-lg-8'><label><font size='5' id='" + value + "divfont'>" + (value-DELETE_NUM_QUESTION) +"</font><font size='3'>" + "  填空题  点击输入框编辑题目" + "</label></div>" +
			"<div class='col-lg-2' >" +
			"<label><font size='3'>必答</font></label>" +
			"<input type='checkbox' id='" + value + "required' checked='true'>" +
			"</div>" +
			"<div class='col-lg-2' id='" + value + "button'></div></div>" +
			"<div class='row container'>" +
			"<div class='col-lg-10'>" +
			"<input class='form-control' name='" + value +"' ></div>" +
			"<div class='col-lg-2'>" +
			"<input type='checkbox' id='" + value +"relevancy' onclick='relevancy("+value+")'><label><font size='3'>添加关联</font></label></div>"+
			"</div>" +
			"<div class='col-lg-12' id='" + value +"showrelevancy'></div>" +
			"<div class='row' style='height:5px'></div>" +
			"<div class='row container'><div class='col-lg-4'><input class='btn btn-default' type='file' id='"+value+"img' onchange='readLocalFile("+value+")' accept='.jpg,.jpeg,.bmp,.png'><img id='"+value+"imgpreview'></div>" +
			"<div class='col-lg-2'><button class='btn btn-default' type='button' id='"+value+"imgcancel' onclick='cancelFile("+value+")'><i class='fa fa-times'>取消</i></button></div></div>"+
			'<div class="row container"><div class="col-lg-4"><label><font size="3">添加视频路径（通用地址代码）<\label></div><div class="col-lg-12"><input class="form-control" id="'+value+'video"></div></div>'+
			'<div class="row container"><div class="col-lg-4"><label><font size="3">添加音频路径（通用地址代码）<\label></div><div class="col-lg-12"><input class="form-control" id="'+value+'audio"></div></div>'+
			"<div class='row' style='height:5px'></div>" +
			"<div  id='" + value + "container' value='0'>" +
			"</div></div>");	
	//create button to delete an question
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){deleteQuestion(value)};
	document.getElementById(value + "button").appendChild(button);	
	var i = document.createElement("i");
	i.className = "fa fa-times";
	i.innerText = "删除本题";
	button.appendChild(i);	
	body.setAttribute("value", value * 1 + 1);
	document.getElementById(value+"div").scrollIntoView();
};
function addSingle() {
	var body = document.body;
	var value = body.getAttribute("value");
	//create form
	if(value=="0"){
	var form = document.createElement("form");
	form.id = 'form';
	form.role = "role";
	body.appendChild(form);
	$("#form").sortable({
		axis: "y" ,
		cursor: "move",
		stop: function( event, ui ) {
			var children = form.childNodes;
			var thisid = ui.item.attr("id").split("d")[0];
			var oldno = $("#"+thisid+"divfont").html();
			var rele = document.getElementById(thisid+"showrelevancy");
			var initquesid = "";
			if(rele.innerHTML!=""){
				initquesid = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
				initquesid = seekQuesByQuesNo(initquesid);
			}
			for(var i=0;i<children.length;i++){
				var id = children[i].getAttribute("id");
				$("#"+id+"font").html(i+1);
			}			
			var thisno = $("#"+thisid+"divfont").html();
			if(rele.innerHTML!=""){
				var quesid = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
				if(thisno*1<=quesid*1){
					$("#form").sortable("cancel");
					for(var i=0;i<children.length;i++){
						var id = children[i].getAttribute("id");
						$("#"+id+"font").html(i+1);
					}
					return;
				}
			}
			if(ui.item.attr("value")==1||ui.item.attr("value")==2){
				var opts = document.getElementById(ui.item.attr("id").split("d")[0]+"container").childNodes;
				for(var i=1;i<opts.length;i++){
					var quesrelearray = getRelesFromOpt(document.getElementById(opts[i].id.split("o")[0]+"optrele"));
					if(quesrelearray!=null){
						for(var j=0;j<quesrelearray.length-1;j++){
							if(thisno*1>=quesrelearray[j]*1){
								$("#form").sortable("cancel");
								for(var i=0;i<children.length;i++){
									var id = children[i].getAttribute("id");
									$("#"+id+"font").html(i+1);
								}
								return;
							}
						}
					}					
				}
			}
			if(oldno>thisno){
				if(initquesid!=""){
					var quesid = initquesid;
					var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
					var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
					var subopts = document.getElementById(quesid+"container").childNodes;
					for(var m=1;m<=optsnum;m++){
						var i = subopts[m].id.split("_")[1].split("o")[0];						
						var input = $("input[name='"+quesid+"_"+i+"option'").val();
						for(var j=0;j<optcontents.length-1;j++){							
							if(optcontents[j]==input){
								if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
								var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
								if(idarray.indexOf(oldno)!=-1){
								idarray.splice(idarray.indexOf(oldno),1,thisno);
								}
								var tmpid = "";
								for(var k=0;k<idarray.length-1;k++){
									tmpid+=idarray[k]+" ";
								}
								document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
							}
						}
					}
					}
				}
				for(var i=thisno-1;i<children.length;i++){
					var rele = document.getElementById(children[i].getAttribute("id").split("d")[0]+"showrelevancy");
					if(rele.innerHTML!=""){
						var releno = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];						
						var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
						if(releno==oldno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = thisno+"."+relecontent;
						}
						else if(releno<oldno&&releno>=thisno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = (releno*1+1)+"."+relecontent;
							if(i<oldno&&i>=thisno){
								var quesid = seekQuesByQuesNo(releno*1+1);
							}
							else{
								var quesid = seekQuesByQuesNo(releno*1);
							}
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
											if(idarray.indexOf(String(i))!=-1){
											idarray.splice(idarray.indexOf(String(i)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}							
						}
						else if(releno<thisno){							
								var quesid = seekQuesByQuesNo(releno*1);							
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){										
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");											
											if(idarray.indexOf(String(i))!=-1){
												idarray.splice(idarray.indexOf(String(i)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}
						}						
					}
				}
			}
			else if(oldno<thisno){
				if(initquesid!=""){
					var quesid = initquesid;
					var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
					var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
					var subopts = document.getElementById(quesid+"container").childNodes;
					for(var m=1;m<=optsnum;m++){
						var i = subopts[m].id.split("_")[1].split("o")[0];
						var input = $("input[name='"+quesid+"_"+i+"option'").val();
						for(var j=0;j<optcontents.length-1;j++){
							if(optcontents[j]==input){
								if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
								var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
								if(idarray.indexOf(oldno)!=-1){
								idarray.splice(idarray.indexOf(oldno),1,thisno);
								}
								var tmpid = "";
								for(var k=0;k<idarray.length-1;k++){
									tmpid+=idarray[k]+" ";
								}
								document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
							}
						}
					}
					}
				}
				for(var i=oldno-1;i<children.length;i++){
					var rele = document.getElementById(children[i].getAttribute("id").split("d")[0]+"showrelevancy");
					if(rele.innerHTML!=""){
						var releno = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
						var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
						if(releno==oldno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = thisno+"."+relecontent;
						}
						else if(releno>oldno&&releno<=thisno){
							if(i>=oldno-1&&i<thisno-1){
								var quesid = seekQuesByQuesNo(releno*1-1);
							}
							else{
								var quesid = seekQuesByQuesNo(releno*1);
							}
							rele.getElementsByTagName("SPAN")[0].innerHTML = (releno*1-1)+"."+relecontent;						
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];									
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){										
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
											if(idarray.indexOf(String(i+2))!=-1){
											idarray.splice(idarray.indexOf(String(i+2)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}							
						}
						else if(releno<oldno){							
							var quesid = seekQuesByQuesNo(releno*1);						
							var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
							var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
							var subopts = document.getElementById(quesid+"container").childNodes;
							for(var m=1;m<=optsnum;m++){
								var n = subopts[m].id.split("_")[1].split("o")[0];
								var input = $("input[name='"+quesid+"_"+n+"option'").val();
								for(var j=0;j<optcontents.length-1;j++){									
									if(optcontents[j]==input){
										if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
										var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
										
										if(idarray.indexOf(String(i+2))!=-1){
											idarray.splice(idarray.indexOf(String(i+2)),1,(i*1+1));
										}
										var tmpid = "";
										for(var k=0;k<idarray.length-1;k++){
											tmpid+=idarray[k]+" ";
										}
										document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
									}
								}
							}
							}
					}
					}
				}
			}			
		}
	});
	}
	else{
		var form = document.getElementById("form");
	}	
	var div = document.createElement("div");
	div.id = (value+"div");
	div.setAttribute("value", "1");
	form.appendChild(div);
	$("#"+value+"div").html("" +
			"<div class='form-group container' style='padding-bottom:5px;background:#fff;border:1px solid #c0c0c0;border-radius:5px'><br><div class='row'>" +
			"<div class='col-lg-8'><label><font size='5' id='" + value + "divfont'>" + (value-DELETE_NUM_QUESTION) +"</font><font size='3'>" + "  单选题  点击输入框编辑题目" + "</label></div>" +
			"<div class='col-lg-2' >" +
			"<label><font size='3'>必答</font></label>" +
			"<input type='checkbox' id='" + value + "required' checked='true'>" +
			"</div>" +
			"<div class='col-lg-2' id='" + value + "deleteQuesButton'></div></div>" +
			"<div class='row container'>" +
			"<div class='col-lg-10'>" +
			"<input class='form-control' name='" + value +"' onchange='changeReleQInQues("+value+")'></div>" +
			"<div class='col-lg-2'>" +
			"<input type='checkbox' id='" + value +"relevancy' onclick='relevancy("+value+")'><label><font size='3'>添加关联</font></label></div>"+
			"</div>" +
			"<div class='col-lg-12' id='" + value +"showrelevancy'></div>" +
			"<div class='row' style='height:5px'></div>" +
			"<div class='row container'><div class='col-lg-4'><input class='btn btn-default' type='file' id='"+value+"img' onchange='readLocalFile("+value+")' accept='.jpg,.jpeg,.bmp,.png'><img id='"+value+"imgpreview'></div>" +
			"<div class='col-lg-2'><button class='btn btn-default' type='button' id='"+value+"imgcancel' onclick='cancelFile("+value+")'><i class='fa fa-times'>取消</i></button></div></div>"+
			'<div class="row container"><div class="col-lg-4"><label><font size="3">添加视频路径（通用地址代码）<\label></div><div class="col-lg-12"><input class="form-control" id="'+value+'video"></div></div>'+
			'<div class="row container"><div class="col-lg-4"><label><font size="3">添加音频路径（通用地址代码）<\label></div><div class="col-lg-12"><input class="form-control" id="'+value+'audio"></div></div>'+
			"<div class='row' style='height:5px'></div>" +
			"<div  id='" + value + "container' value='0'>" +
			"<div class='col-lg-10'><label><font size='3'>添加并填写选项</font></label></div></div><div class='col-lg-2' id='" + value + "button'></div>" +
			
	"</div></div>");	
	//create button to add an option
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){addOption(value)};
	document.getElementById(value + "button").appendChild(button);	
	var i = document.createElement("i");
	i.className = "fa fa-plus";
	i.innerText = "添加选项"
	button.appendChild(i);	
	//create button to delete an question
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){deleteQuestion(value)};
	document.getElementById(value + "deleteQuesButton").appendChild(button);	
	var i = document.createElement("i");
	i.className = "fa fa-times";
	i.innerText = "删除本题";
	button.appendChild(i);	
	body.setAttribute("value", value * 1 + 1);
	
	//$("#"+value+"div").scrollIntoView(true);
	document.getElementById(value+"div").scrollIntoView();
};
function addMultiple() {
	var body = document.body;
	var value = body.getAttribute("value");
	//create form
	if(value=="0"){
	var form = document.createElement("form");
	form.id = 'form';
	form.role = "role";
	body.appendChild(form);
	$("#form").sortable({
		axis: "y" ,
		cursor: "move",
		stop: function( event, ui ) {
			var children = form.childNodes;
			var thisid = ui.item.attr("id").split("d")[0];
			var oldno = $("#"+thisid+"divfont").html();
			var rele = document.getElementById(thisid+"showrelevancy");
			var initquesid = "";
			if(rele.innerHTML!=""){
				initquesid = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
				initquesid = seekQuesByQuesNo(initquesid);
			}
			for(var i=0;i<children.length;i++){
				var id = children[i].getAttribute("id");
				$("#"+id+"font").html(i+1);
			}			
			var thisno = $("#"+thisid+"divfont").html();
			if(rele.innerHTML!=""){
				var quesid = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
				if(thisno*1<=quesid*1){
					$("#form").sortable("cancel");
					for(var i=0;i<children.length;i++){
						var id = children[i].getAttribute("id");
						$("#"+id+"font").html(i+1);
					}
					return;
				}
			}
			if(ui.item.attr("value")==1||ui.item.attr("value")==2){
				var opts = document.getElementById(ui.item.attr("id").split("d")[0]+"container").childNodes;
				for(var i=1;i<opts.length;i++){
					var quesrelearray = getRelesFromOpt(document.getElementById(opts[i].id.split("o")[0]+"optrele"));
					if(quesrelearray!=null){
						for(var j=0;j<quesrelearray.length-1;j++){
							if(thisno*1>=quesrelearray[j]*1){
								$("#form").sortable("cancel");
								for(var i=0;i<children.length;i++){
									var id = children[i].getAttribute("id");
									$("#"+id+"font").html(i+1);
								}
								return;
							}
						}
					}					
				}
			}
			if(oldno>thisno){
				if(initquesid!=""){
					var quesid = initquesid;
					var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
					var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
					var subopts = document.getElementById(quesid+"container").childNodes;
					for(var m=1;m<=optsnum;m++){
						var i = subopts[m].id.split("_")[1].split("o")[0];						
						var input = $("input[name='"+quesid+"_"+i+"option'").val();
						for(var j=0;j<optcontents.length-1;j++){							
							if(optcontents[j]==input){
								if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
								var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
								if(idarray.indexOf(oldno)!=-1){
								idarray.splice(idarray.indexOf(oldno),1,thisno);
								}
								var tmpid = "";
								for(var k=0;k<idarray.length-1;k++){
									tmpid+=idarray[k]+" ";
								}
								document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
							}
						}
					}
					}
				}
				for(var i=thisno-1;i<children.length;i++){
					var rele = document.getElementById(children[i].getAttribute("id").split("d")[0]+"showrelevancy");
					if(rele.innerHTML!=""){
						var releno = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];						
						var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
						if(releno==oldno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = thisno+"."+relecontent;
						}
						else if(releno<oldno&&releno>=thisno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = (releno*1+1)+"."+relecontent;
							if(i<oldno&&i>=thisno){
								var quesid = seekQuesByQuesNo(releno*1+1);
							}
							else{
								var quesid = seekQuesByQuesNo(releno*1);
							}
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
											if(idarray.indexOf(String(i))!=-1){
											idarray.splice(idarray.indexOf(String(i)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}							
						}
						else if(releno<thisno){							
								var quesid = seekQuesByQuesNo(releno*1);							
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){										
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");											
											if(idarray.indexOf(String(i))!=-1){
												idarray.splice(idarray.indexOf(String(i)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}
						}						
					}
				}
			}
			else if(oldno<thisno){
				if(initquesid!=""){
					var quesid = initquesid;
					var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
					var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
					var subopts = document.getElementById(quesid+"container").childNodes;
					for(var m=1;m<=optsnum;m++){
						var i = subopts[m].id.split("_")[1].split("o")[0];
						var input = $("input[name='"+quesid+"_"+i+"option'").val();
						for(var j=0;j<optcontents.length-1;j++){
							if(optcontents[j]==input){
								if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
								var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
								if(idarray.indexOf(oldno)!=-1){
								idarray.splice(idarray.indexOf(oldno),1,thisno);
								}
								var tmpid = "";
								for(var k=0;k<idarray.length-1;k++){
									tmpid+=idarray[k]+" ";
								}
								document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
							}
						}
					}
					}
				}
				for(var i=oldno-1;i<children.length;i++){
					var rele = document.getElementById(children[i].getAttribute("id").split("d")[0]+"showrelevancy");
					if(rele.innerHTML!=""){
						var releno = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
						var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
						if(releno==oldno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = thisno+"."+relecontent;
						}
						else if(releno>oldno&&releno<=thisno){
							if(i>=oldno-1&&i<thisno-1){
								var quesid = seekQuesByQuesNo(releno*1-1);
							}
							else{
								var quesid = seekQuesByQuesNo(releno*1);
							}
							rele.getElementsByTagName("SPAN")[0].innerHTML = (releno*1-1)+"."+relecontent;		
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];									
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){										
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
											if(idarray.indexOf(String(i+2))!=-1){
											idarray.splice(idarray.indexOf(String(i+2)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}							
						}
						else if(releno<oldno){							
							var quesid = seekQuesByQuesNo(releno*1);					
							var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
							var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
							var subopts = document.getElementById(quesid+"container").childNodes;
							for(var m=1;m<=optsnum;m++){
								var n = subopts[m].id.split("_")[1].split("o")[0];
								var input = $("input[name='"+quesid+"_"+n+"option'").val();
								for(var j=0;j<optcontents.length-1;j++){									
									if(optcontents[j]==input){
										if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
										var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
										
										if(idarray.indexOf(String(i+2))!=-1){
											idarray.splice(idarray.indexOf(String(i+2)),1,(i*1+1));
										}
										var tmpid = "";
										for(var k=0;k<idarray.length-1;k++){
											tmpid+=idarray[k]+" ";
										}
										document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
									}
								}
							}
							}
					}
					}
				}
			}		
		}
	});
	}
	else{
		var form = document.getElementById("form");
	}
	var div = document.createElement("div");
	div.setAttribute("value", "2");
	div.id = (value+"div");
	form.appendChild(div);
	$("#"+value+"div").html("" +
			"<div class='form-group container' style='padding-bottom:5px;background:#fff;border:1px solid #c0c0c0;border-radius:5px'><br><div class='row'>" +
			"<div class='col-lg-3'><label><font size='5' id='" + value + "divfont'>" + (value-DELETE_NUM_QUESTION) +"</font><font size='3'>"+"  多选题  点击输入框编辑题目" + "</font></label></div>" +
			"<div class='col-lg-1'><label><font size='3'>最大可选</font></label></div>" +
			"<div class='col-lg-1'><input class='form-control' type='number' step='1' name='" + value +"max' value=0></div>" +
			"<div class='col-lg-1'><label><font size='3'>最小可选</font></label></div>" +
			"<div class='col-lg-1'><input class='form-control' type='number' step='1' name='" + value +"min'  value=1></div>" +
					"<div class='col-lg-1'></div>" +
			"<div class='col-lg-2'>" +
			"<label><font size='3'>必答</font></label>" +
			"<input type='checkbox' id='" + value + "required' checked='true'>" +
			"</div>" +
			"<div class='col-lg-2'><div id='" + value + "button'></div></div></div>" +
			"<div class='row container'>" +
			"<div class='col-lg-10'>" +
			"<input class='form-control' name=" + value + " onchange='changeReleQInQues("+value+")'></div>" +
			"<div class='col-lg-2'>" +
			"<input type='checkbox' id='" + value +"relevancy' onclick='relevancy("+value+")'><label><font size='3'>添加关联</label></div>"+
			"</div>" +
			"<div class='col-lg-12' id='" + value +"showrelevancy'></div>" +
			"<div class='row' style='height:5px'></div>" +
			"<div class='row container'><div class='col-lg-4'><input class='btn btn-default' type='file' id='"+value+"img' onchange='readLocalFile("+value+")' accept='.jpg,.jpeg,.bmp,.png'><img id='"+value+"imgpreview'></div>" +
			"<div class='col-lg-2'><button class='btn btn-default' type='button' id='"+value+"imgcancel' onclick='cancelFile("+value+")'><i class='fa fa-times'>取消</i></button></div></div>"+
			'<div class="row container"><div class="col-lg-4"><label><font size="3">添加视频路径（通用地址代码）<\label></div><div class="col-lg-12"><input class="form-control" id="'+value+'video"></div></div>'+
			'<div class="row container"><div class="col-lg-4"><label><font size="3">添加音频路径（通用地址代码）<\label></div><div class="col-lg-12"><input class="form-control" id="'+value+'audio"></div></div>'+
			"<div class='row' style='height:5px'></div>" +
			"<div  id='" + value + "container' value='0'>" +
			"<div class='col-lg-10'><label><font size='3'>添加并填写选项</font></label></div></div><div class='col-lg-2' id='" + value + "addChoiceButton'></div>" +
			"</div></div>");	
	//create button to add an option
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){addOption(value, true)};
	document.getElementById(value + "addChoiceButton").appendChild(button);	
	var i = document.createElement("i");
	i.className = "fa fa-plus";
	i.innerText = "添加选项";
	button.appendChild(i);
	body.setAttribute("value", value * 1 + 1);	
	//create button to delete an question
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){deleteQuestion(value)};
	document.getElementById(value + "button").appendChild(button);	
	var i = document.createElement("i");
	i.className = "fa fa-times";
	i.innerText = "删除本题";
	button.appendChild(i);
	document.getElementById(value+"div").scrollIntoView();
};
function addSlider() {
	var body = document.body;
	var value = body.getAttribute("value");
	//create form
	if(value=="0"){
	var form = document.createElement("form");
	form.id = 'form';
	form.role = "role";
	body.appendChild(form);
	$("#form").sortable({
		axis: "y" ,
		cursor: "move",
		stop: function( event, ui ) {
			var children = form.childNodes;
			var thisid = ui.item.attr("id").split("d")[0];
			var oldno = $("#"+thisid+"divfont").html();
			var rele = document.getElementById(thisid+"showrelevancy");
			var initquesid = "";
			if(rele.innerHTML!=""){
				initquesid = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
				initquesid = seekQuesByQuesNo(initquesid);
			}
			for(var i=0;i<children.length;i++){
				var id = children[i].getAttribute("id");
				$("#"+id+"font").html(i+1);
			}			
			var thisno = $("#"+thisid+"divfont").html();
			if(rele.innerHTML!=""){
				var quesid = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
				if(thisno*1<=quesid*1){
					$("#form").sortable("cancel");
					for(var i=0;i<children.length;i++){
						var id = children[i].getAttribute("id");
						$("#"+id+"font").html(i+1);
					}
					return;
				}
			}
			if(ui.item.attr("value")==1||ui.item.attr("value")==2){
				var opts = document.getElementById(ui.item.attr("id").split("d")[0]+"container").childNodes;
				for(var i=1;i<opts.length;i++){
					var quesrelearray = getRelesFromOpt(document.getElementById(opts[i].id.split("o")[0]+"optrele"));
					if(quesrelearray!=null){
						for(var j=0;j<quesrelearray.length-1;j++){
							if(thisno*1>=quesrelearray[j]*1){
								$("#form").sortable("cancel");
								for(var i=0;i<children.length;i++){
									var id = children[i].getAttribute("id");
									$("#"+id+"font").html(i+1);
								}
								return;
							}
						}
					}
					
				}
			}
			if(oldno>thisno){
				if(initquesid!=""){
					var quesid = initquesid;
					var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
					var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
					var subopts = document.getElementById(quesid+"container").childNodes;
					for(var m=1;m<=optsnum;m++){
						var i = subopts[m].id.split("_")[1].split("o")[0];						
						var input = $("input[name='"+quesid+"_"+i+"option'").val();
						for(var j=0;j<optcontents.length-1;j++){							
							if(optcontents[j]==input){
								if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
								var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
								if(idarray.indexOf(oldno)!=-1){
								idarray.splice(idarray.indexOf(oldno),1,thisno);
								}
								var tmpid = "";
								for(var k=0;k<idarray.length-1;k++){
									tmpid+=idarray[k]+" ";
								}
								document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
							}
						}
					}
					}
				}
				for(var i=thisno-1;i<children.length;i++){
					var rele = document.getElementById(children[i].getAttribute("id").split("d")[0]+"showrelevancy");
					if(rele.innerHTML!=""){
						var releno = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];						
						var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
						if(releno==oldno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = thisno+"."+relecontent;
						}
						else if(releno<oldno&&releno>=thisno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = (releno*1+1)+"."+relecontent;
							if(i<oldno&&i>=thisno){
								var quesid = seekQuesByQuesNo(releno*1+1);
							}
							else{
								var quesid = seekQuesByQuesNo(releno*1);
							}
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
											if(idarray.indexOf(String(i))!=-1){
											idarray.splice(idarray.indexOf(String(i)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}							
						}
						else if(releno<thisno){							
								var quesid = seekQuesByQuesNo(releno*1);						
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){										
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
											
											if(idarray.indexOf(String(i))!=-1){
												idarray.splice(idarray.indexOf(String(i)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}
						}						
					}
				}
			}
			else if(oldno<thisno){
				if(initquesid!=""){
					var quesid = initquesid;
					var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
					var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
					var subopts = document.getElementById(quesid+"container").childNodes;
					for(var m=1;m<=optsnum;m++){
						var i = subopts[m].id.split("_")[1].split("o")[0];
						var input = $("input[name='"+quesid+"_"+i+"option'").val();
						for(var j=0;j<optcontents.length-1;j++){
							if(optcontents[j]==input){
								if(document.getElementById(quesid+"_"+i+"optrele").innerHTML!=""){
								var idarray = document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
								if(idarray.indexOf(oldno)!=-1){
								idarray.splice(idarray.indexOf(oldno),1,thisno);
								}
								var tmpid = "";
								for(var k=0;k<idarray.length-1;k++){
									tmpid+=idarray[k]+" ";
								}
								document.getElementById(quesid+"_"+i+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
							}
						}
					}
					}
				}
				for(var i=oldno-1;i<children.length;i++){
					var rele = document.getElementById(children[i].getAttribute("id").split("d")[0]+"showrelevancy");
					if(rele.innerHTML!=""){
						var releno = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[0];
						var relecontent = rele.getElementsByTagName("SPAN")[0].innerHTML.split(".")[1];
						if(releno==oldno){
							rele.getElementsByTagName("SPAN")[0].innerHTML = thisno+"."+relecontent;
						}
						else if(releno>oldno&&releno<=thisno){
							if(i>=oldno-1&&i<thisno-1){
								var quesid = seekQuesByQuesNo(releno*1-1);
							}
							else{
								var quesid = seekQuesByQuesNo(releno*1);
							}
							rele.getElementsByTagName("SPAN")[0].innerHTML = (releno*1-1)+"."+relecontent;							
								var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
								var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
								var subopts = document.getElementById(quesid+"container").childNodes;
								for(var m=1;m<=optsnum;m++){
									var n = subopts[m].id.split("_")[1].split("o")[0];					
									var input = $("input[name='"+quesid+"_"+n+"option'").val();
									for(var j=0;j<optcontents.length-1;j++){							
										if(optcontents[j]==input){
											if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
											var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
											if(idarray.indexOf(String(i+2))!=-1){
											idarray.splice(idarray.indexOf(String(i+2)),1,(i*1+1));
											}
											var tmpid = "";
											for(var k=0;k<idarray.length-1;k++){
												tmpid+=idarray[k]+" ";
											}
											document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
										}
									}
								}
								}					
						}
						else if(releno<oldno){						
							var quesid = seekQuesByQuesNo(releno*1);
							var optcontents = rele.getElementsByTagName("SPAN")[1].innerHTML.split(" ");
							var optsnum = document.getElementById(quesid+"container").childNodes.length-1;
							var subopts = document.getElementById(quesid+"container").childNodes;
							for(var m=1;m<=optsnum;m++){
								var n = subopts[m].id.split("_")[1].split("o")[0];
								var input = $("input[name='"+quesid+"_"+n+"option'").val();
								for(var j=0;j<optcontents.length-1;j++){
									
									if(optcontents[j]==input){
										if(document.getElementById(quesid+"_"+n+"optrele").innerHTML!=""){
										var idarray = document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML.split(" ");
										
										if(idarray.indexOf(String(i+2))!=-1){
											idarray.splice(idarray.indexOf(String(i+2)),1,(i*1+1));
										}
										var tmpid = "";
										for(var k=0;k<idarray.length-1;k++){
											tmpid+=idarray[k]+" ";
										}
										document.getElementById(quesid+"_"+n+"optrele").getElementsByTagName("SPAN")[0].innerHTML = tmpid;
									}
								}
							}
							}
					}
					}
				}
			}
			
		}
	});
	}
	else{
		var form = document.getElementById("form");
	}
	var div = document.createElement("div");
	div.setAttribute("value", "3");
	div.id = (value+"div");
	form.appendChild(div);
	$("#"+value+"div").html("" +
			"<div class='form-group container' style='padding-bottom:5px;background:#fff;border:1px solid #c0c0c0;border-radius:5px'><br><div class='row'>" +
			"<div class='col-lg-8'><label><font size='5' id='" + value + "divfont'>" + (value-DELETE_NUM_QUESTION) +"</font><font size='3'>" + "  滑块题  点击输入框编辑题目" + "</label></div>" +
			"<div class='col-lg-2' >" +
			"<label>必答</label>" +
			"<input type='checkbox' id='" + value + "required' checked='true'>" +
			"</div>" +
			"<div class='col-lg-2'><div id='" + value + "deleteQuesButton'></div></div></div>" +
			"<div class='row container'>" +
			"<div class='col-lg-10'>" +
			"<input class='form-control' name=" + value + "></div>" +
			"<div class='col-lg-2'>" +
			"<input type='checkbox' id='" + value +"relevancy' onclick='relevancy("+value+")'><label><font size='3'>添加关联</font></label></div>"+
			"</div>" +
			"<div class='col-lg-12' id='" + value +"showrelevancy'></div>" +
			"<div class='row' style='height:5px'></div>" +
			"<div class='container'><div class='row'>" +
			"<div class='col-lg-1'><label><font size='3'>最大值</font></label></div>" +
			"<div class='col-lg-3'><input class='form-control' type='number' step='1' name='" + value +"max'></div>" +
			"<div class='col-lg-2'><label><font size='3'>最大值标签</font></label></div>" +
			"<div class='col-lg-5'><input class='form-control' type='text' name='" + value +"maxtext'></div></div>" +
			"<div class='row' style='height:5px'></div>" +
			"<div class='row'>" +
			"<div class='col-lg-1'><label><font size='3'>最小值</font></label></div>" +
			"<div class='col-lg-3'><input class='form-control' type='number' step='1' name='" + value +"min'></div>" +
			"<div class='col-lg-2'><label><font size='3'>最小值标签</font></label></div>" +
			"<div class='col-lg-5'><input class='form-control' type='text' name='" + value +"mintext'></div></div>" +
			
			"</div><div class='row' style='height:5px'></div>" +
			"<div class='row container'><div class='col-lg-4'><input class='btn btn-default' type='file' id='"+value+"img' onchange='readLocalFile("+value+")' accept='.jpg,.jpeg,.bmp,.png'><img id='"+value+"imgpreview'></div>" +
			"<div class='col-lg-2'><button class='btn btn-default' type='button' id='"+value+"imgcancel' onclick='cancelFile("+value+")'><i class='fa fa-times'>取消</i></button></div></div>"+
			'<div class="row container"><div class="col-lg-4"><label><font size="3">添加视频路径（通用地址代码）<\label></div><div class="col-lg-12"><input class="form-control" id="'+value+'video"></div></div>'+
			'<div class="row container"><div class="col-lg-4"><label><font size="3">添加音频路径（通用地址代码）<\label></div><div class="col-lg-12"><input class="form-control" id="'+value+'audio"></div></div>'+
			"<div class='row' style='height:5px'></div>" +
			"<div  id='" + value + "container' value='0'>" +
			"</div>");
	//create button to delete an question
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){deleteQuestion(value)};
	document.getElementById(value + "deleteQuesButton").appendChild(button);
	var i = document.createElement("i");
	i.className = "fa fa-times";
	i.innerText = "删除本题";
	button.appendChild(i);
	body.setAttribute("value", value * 1 + 1);
	document.getElementById(value+"div").scrollIntoView();
};
function modify(result, id){
	$("input[name='title']").val(result['title']);
	$("input[name='introduction']").val(result['introduction']);
	if(result['allowdup']=='0'){
		document.getElementById("allowDup").checked=false;
	}
	if(result['resultPublished']=='private'){
		document.getElementById("resultPublished").checked=false;
	}
	var releqlist = {};
	var releolist = {};
	for(var i = 0; i < result['questions'].length; i++){
		var type = result['questions'][i]['type'];
		if(type=="Subjective"){
			addBlank();
			$("input[name="+i+"]").val(result['questions'][i]['stem']);
			if(result['questions'][i]['required']==false){
				var required = document.getElementById(i+"required");
				required.checked=false;
			}
			$("#"+i+"video").val(result['questions'][i]['video']);
			$("#"+i+"audio").val(result['questions'][i]['audio']);
			if(result['questions'][i]['img']){
				document.getElementById(i+"imgpreview").src = decodeURIComponent(result['questions'][i]['img']);
			}
		}
		else if(type=="Single"){
			addSingle();
			$("input[name="+i+"]").val(result['questions'][i]['stem']);
			$("#"+i+"video").val(result['questions'][i]['video']);
			$("#"+i+"audio").val(result['questions'][i]['audio']);
			if(result['questions'][i]['img']){
				document.getElementById(i+"imgpreview").src = decodeURIComponent(result['questions'][i]['img']);
			}
			if(result['questions'][i]['required']==false){
				var required = document.getElementById(i+"required");
				required.checked=false;
			}
			for(var j = 0; j < result['questions'][i]['options'].length; j++){
				addOption(i);
				$("input[name="+i+"_"+j+"option]").val(result['questions'][i]['options'][j]['option']);
				var cf = document.getElementById(i+"_"+j+"cf");
				cf.checked=result['questions'][i]['options'][j]['hasWords'];
				if(result['questions'][i]['options'][j]['img']){
					document.getElementById(i+"_"+j+"imgpreview").src = decodeURIComponent(result['questions'][i]['options'][j]['img']);
				}
				if(result['questions'][i]['options'][j]['relevancy']!=undefined){
					var relearray = result['questions'][i]['options'][j]['relevancy'];
					var tmp = "本选项与以下题号所代表的题目关联: <span>";
					for(var p=0;p<relearray.length;p++){
						tmp+=relearray[p]+" ";
						if(releqlist[relearray[p]]==undefined){
							releqlist[relearray[p]] = (i+1)+"."+result['questions'][i]['stem'];
						}
						if(releolist[relearray[p]]==undefined){
							releolist[relearray[p]]="";
						}
						releolist[relearray[p]]+=result['questions'][i]['options'][j]['option']+" ";
					}
					tmp += "</span>";
					$("#"+i+"_"+j+"optrele").html(tmp);
				}
			}
		}
		else if(type=="Multiple"){
			addMultiple();
			$("input[name="+i+"]").val(result['questions'][i]['stem']);
			$("#"+i+"video").val(result['questions'][i]['video']);
			$("#"+i+"audio").val(result['questions'][i]['audio']);
			if(result['questions'][i]['img']){
				document.getElementById(i+"imgpreview").src = decodeURIComponent(result['questions'][i]['img']);
			}
			if(result['questions'][i]['required']==false){
				var required = document.getElementById(i+"required");
				required.checked=false;
			}
			$("input[name="+i+"min]").val(result['questions'][i]['min']);
			$("input[name="+i+"max]").val(result['questions'][i]['max']);
			for(var j = 0; j < result['questions'][i]['options'].length; j++){
				addOption(i);
				$("input[name="+i+"_"+j+"option]").val(result['questions'][i]['options'][j]['option']);
				var cf = document.getElementById(i+"_"+j+"cf");
				cf.checked=result['questions'][i]['options'][j]['hasWords'];
				if(result['questions'][i]['options'][j]['img']){
					document.getElementById(i+"_"+j+"imgpreview").src = decodeURIComponent(result['questions'][i]['options'][j]['img']);
				}
				if(result['questions'][i]['options'][j]['relevancy']!=undefined){
					var relearray = result['questions'][i]['options'][j]['relevancy'];
					var tmp = "本选项与以下题号所代表的题目关联: <span>";
					for(var p=0;p<relearray.length;p++){
						tmp+=relearray[p]+" ";
						if(releqlist[relearray[p]]==undefined){
							releqlist[relearray[p]] = (i+1)+"."+result['questions'][i]['stem'];
						}
						if(releolist[relearray[p]]==undefined){
							releolist[relearray[p]]="";
						}
						releolist[relearray[p]]+=result['questions'][i]['options'][j]['option']+" ";
					}
					tmp += "</span>";
					$("#"+i+"_"+j+"optrele").html(tmp);
				}
			}
		}
		else if(type=="Slider"){
			addSlider();
			$("input[name="+i+"]").val(result['questions'][i]['stem']);
			$("#"+i+"video").val(result['questions'][i]['video']);
			$("#"+i+"audio").val(result['questions'][i]['audio']);
			if(result['questions'][i]['img']){
				document.getElementById(i+"imgpreview").src = decodeURIComponent(result['questions'][i]['img']);
			}
			if(result['questions'][i]['required']==false){
				var required = document.getElementById(i+"required");
				required.checked=false;
			}
			$("input[name="+i+"min]").val(result['questions'][i]['min']);
			$("input[name="+i+"mintext]").val(result['questions'][i]['mintext']);
			$("input[name="+i+"max]").val(result['questions'][i]['max']);
			$("input[name="+i+"maxtext]").val(result['questions'][i]['maxtext']);
		}
	}
	for(x in releqlist){
		document.getElementById(x-1+"relevancy").checked = true;
		$("#"+(x*1-1)+"showrelevancy").html(
				"关联：本题在 <span>"
				+releqlist[x]+"</span> 中的以下选项中某一项被选中时出现: <span>"+releolist[x]+"</span>");
	}
};

function update(quesid){
	FLAG=1;
	QUES_ID = quesid;
	jQuery.ajax({
		url : 'getQuestionnaire',  //get content
		processData : true,
		dataType : "json",
		data : {
			id : QUES_ID
		},
		success : function(data) { //把title，id都放在里面
			modify(data, QUES_ID);
		}
	});
}
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
function relevancy(value){
	if(document.getElementById(value+"relevancy").checked==true){
		var num = $("#"+value+"divfont").html();
		if(num == 1){
			bootbox.alert("无可选选项");
			document.getElementById(value+"relevancy").checked=false;
			return;
		}
		var quess = document.getElementById("form").childNodes;
		var opts = "";
		for(var i=0;i<num-1;i++){
			if(quess[i].getAttributeNode("value").value=="1"||quess[i].getAttributeNode("value").value=="2"){
				if(document.getElementById(quess[i].id.split("d")[0]+"container").getElementsByTagName("DIV").length!=0){
				opts+="<option>"+
						$("#"+quess[i].id.split("d")[0]+"divfont").html()+
						"."+
						$("input[name='"+quess[i].id.split("d")[0]+"']").val()
						+"</option>";
				}
			}
		}
		$("#formerques").html(opts);
		$("#relacloser").attr("data-id", value);
		$("#relatconfirm").attr("data-id", value);
		if(document.getElementById("formerques").getElementsByTagName("OPTION").length==0){
			bootbox.alert("无可选选项");
			document.getElementById(value+"relevancy").checked=false;
			return;
		}
		var opts2 = "";
		var firstoptid = document.getElementById("formerques").getElementsByTagName("OPTION")[0].innerHTML.split(".")[0];
		var quess = document.getElementById("form").childNodes;
	    for(var i=0;i<quess.length;i++){
	    	if($("#"+quess[i].id.split("d")[0]+"divfont").html() == firstoptid){
	    		firstoptid = quess[i].id.split("d")[0];
	    		break;
	    	}
	    }
	    var firstsubopts = document.getElementById(firstoptid+"container").childNodes;
		var firstoptnum = firstsubopts.length;
		for(var i=1;i<firstoptnum;i++){
			opts2+="<input type='checkbox'>"+
			"<label>" +
			$("input[name='"+firstsubopts[i].id.split("o")[0]+"option']").val()+
			"</label><br>";
		}
		$("#specoptiondiv").html(opts2);
		var opts3="";
		for(var i=num;i<quess.length;i++){
			if(document.getElementById(quess[i].id.split("d")[0]+"relevancy").checked!=true){
				opts3+="<input type='checkbox'><label>"+
						$("#"+quess[i].id.split("d")[0]+"divfont").html()+
						"."+
						$("input[name='"+quess[i].id.split("d")[0]+"']").val()
						+"</label><br>";
			}
		}
		$("#laterques").html(opts3);
		$('#modal2').modal('show');
	}
	else{
		deleteRelevancyByQuestion(value);
	}
}
function releopts(){
	var index=document.getElementById("formerques").selectedIndex;
    var quesid=document.getElementById("formerques").options[index].innerHTML.split(".")[0];
    var quess = document.getElementById("form").childNodes;
    for(var i=0;i<quess.length;i++){
    	if($("#"+quess[i].id.split("d")[0]+"divfont").html() == quesid){
    		quesid = quess[i].id.split("d")[0];
    		break;
    	}
    }
    var subopts = document.getElementById(quesid+"container").childNodes;
	var optnum = document.getElementById(quesid+"container").childNodes.length;
	var opts2="";
	for(var i=1;i<optnum;i++){
		opts2+="<input type='checkbox'>"+
				"<label>" +
				$("input[name='"+subopts[i].id.split("o")[0]+"option']").val()+
				"</label><br>";
	}
	$("#specoptiondiv").html(opts2);
}
function onchangingReleInQues(num, value){
	var quesarray = getRelesFromOpt(document.getElementById(num+"_"+value+"optrele"));
	var opt = $("input[name='" + num+"_"+value+"option']").val();
	if(quesarray!=null){
		for(var i=0;i<quesarray.length-1;i++){
			var rele = document.getElementById(seekQuesByQuesNo(quesarray[i])+"showrelevancy").getElementsByTagName("SPAN")[1];
			var optarray = rele.innerHTML.split(" ");
			for(var j=0;j<optarray.length-1;j++){
				if(optarray[j]==opt){
					optarray.splice(j,1);
					break;
				}
			}
			var tmp = "";
			for(var j=0;j<optarray.length-1;j++){
					tmp+=optarray[j]+" ";
			}
			rele.innerHTML = tmp;
		}
	}
}
function changeReleInQues(num, value){
	var quesarray = getRelesFromOpt(document.getElementById(num+"_"+value+"optrele"));
	var opt = $("input[name='" + num+"_"+value+"option']").val();
	if(quesarray!=null){
		for(var i=0;i<quesarray.length-1;i++){
			var rele = document.getElementById(seekQuesByQuesNo(quesarray[i])+"showrelevancy").getElementsByTagName("SPAN")[1];
			rele.innerHTML = rele.innerHTML + opt + " ";
		}
	}
}
function changeReleQInQues(value){
	var opts = document.getElementById(value+"container").childNodes;
	for(var i=1;i<opts.length;i++){
		var quesarray = getRelesFromOpt(document.getElementById(opts[i].id.split("o")[0]+"optrele"));
		if(quesarray!=null){
			for(var j=0;j<quesarray.length-1;j++){
				var rele = document.getElementById(seekQuesByQuesNo(quesarray[j])+"showrelevancy").getElementsByTagName("SPAN")[0];
				rele.innerHTML = rele.innerHTML.split(".")[0] + "." + $("input[name='"+value+"']").val();
			}
		}
	}
}
function copyUrl()
{
var Url=document.getElementById("qnhref");
Url.select(); // 选择对象
document.execCommand("Copy"); // 执行浏览器复制命令
$("#copytip").html("复制成功");
}
function readLocalFile(i) {
    var localFile = document.getElementById(i+"img").files[0];
    var reader = new FileReader();
    var content;
    reader.onload = function(event) {
        content = event.target.result;
        document.getElementById(i+"imgpreview").src = content;
    }
    if(localFile){
    	content = reader.readAsDataURL(localFile,"UTF-8");
    }
    else {
    	document.getElementById(i+"imgpreview").removeAttribute("src");
    }
    //
}
function cancelFile(i) {
	document.getElementById(i+"imgpreview").removeAttribute("src");
	document.getElementById(i+"img").value="";
}