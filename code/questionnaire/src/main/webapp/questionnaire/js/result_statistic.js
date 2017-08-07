function getStatistic(quesid){
	jQuery.ajax({
		url : 'getStatistic',
		processData : true,
		dataType : "json",
		data : {
			quesid:quesid,
		},
		success : function(data) {
			formStatistic(data);
		}
	});
}

function formStatistic(data){
	var questions=	data['question']['questions'];
	var answers = data['answers'];
	for(var i = 0 ; i < questions.length; i++){
		var ques = questions[i];
		$("#container").append("<p><font size='4'>" + (i+1) + " : " + ques['stem'] + "</font></p>" +
				"<div class='container' id =" + i + "></div>");
		var type = ques['type'];
		
		$("#" + i).append('<div class="container"> ' +
				'<!-- /.row -->' +
				'<div class="row">' +
				'	<div class="col-lg-12">' +
					'	<div class="panel panel-default">' +
					'		<!-- /.panel-heading -->' +
					'		<div class="panel-body">' +
					'			<div class="dataTable_wrapper">' +
					'				<table class="table table-striped table-bordered table-hover"' +
					'					id="dataTables">' +
					'					<thead>' +
					'						<tr>' +
					'						    <th width="40%">Key</th>' +
					'							<th width="60%">Value</th>' +
					'						</tr>' +
					'					</thead>' +
					'					<tbody id ="' + i + 'body">')
		if(type=="Subjective"){
			for(var j = 0 ; j < answers.length; j++){
				$("#" + i + "body").append('<tr id="' + i + '_' + j + 'tr">');
				$("#" + i+ "_" + j+ "tr").append('<td>' + j + "</td>");
				$("#" + i+ "_" + j+ "tr").append('<td>' + answers[j][i]['words'] + "</td>");
				$("#" + i+ "body").append('</tr>');
			}
		}
		else if(type=="Single"){
			var result = [];
			var label = [];
			for(var j = 0 ; j < ques['options'].length; j++){
				result[j] = 0;
				label[j] = ques['options'][j]['option'];
			}
			for(var j = 0 ; j < answers.length; j++){
				var id = answers[j][i]['option'];
				if(id!=""){
					result[id] += 1;
				}
			}
			for(var j = 0 ; j < ques['options'].length; j++){
				$("#" + i + "body").append('<tr id="' + i + '_' + j + 'tr">');
				$("#" + i+ "_" + j+ "tr").append('<td>' + ques['options'][j]['option'] + "</td>");
				$("#" + i+ "_" + j+ "tr").append('<td>' + result[j] + "</td>");
				$("#" + i+ "body").append('</tr>');
			}
			var div = document.createElement("div");
			div.id = i + "div";
			div.className = "col-lg-6";
			document.getElementById(i).appendChild(div);
			var canvas = document.createElement("canvas");
			canvas.id = i + "canvas";
			div.appendChild(canvas);
			draw(label, result, i);
			var button = document.createElement("button");
			button.className="btn btn-default";
			alert(canvas.id);
			button.onclick=function(){downloadimg(canvas.id)};
			button.innerText="下载图片";
			div.appendChild(button);
		}
		else if(type=="Multiple"){
			var result = [];
			var label = [];
			for(var j = 0 ; j < ques['options'].length; j++){
				result[j] = 0;
				label[j] = ques['options'][j]['option'];
			}
			for(var j = 0 ; j < answers.length; j++){
				var option = answers[j][i]['option'];
				if(option!=""){
					var ids = option.split(",");
					for(var k = 0; k < ids.length-1; k++){
						result[ids[k]] += 1;
					}
				}
			}
			for(var j = 0 ; j < ques['options'].length; j++){
				$("#" + i + "body").append('<tr id="' + i + '_' + j + 'tr">');
				$("#" + i+ "_" + j+ "tr").append('<td>' + ques['options'][j]['option'] + "</td>");
				$("#" + i+ "_" + j+ "tr").append('<td>' + result[j] + "</td>");
				$("#" + i+ "body").append('</tr>');
			}
			var div = document.createElement("div");
			div.id = i + "div";
			div.className = "col-lg-6";
			document.getElementById(i).appendChild(div);
			var canvas = document.createElement("canvas");
			canvas.id = i + "canvas";
			div.appendChild(canvas);
			draw(label, result, i);
		}
		else if(type=="Slider"){
			for(var j = 0 ; j < answers.length; j++){
				$("#" + i + "body").append('<tr id="' + i + '_' + j + 'tr">');
				$("#" + i+ "_" + j+ "tr").append('<td>' + j + "</td>");
				$("#" + i+ "_" + j+ "tr").append('<td>' + answers[j][i]['number'] + "</td>");
				$("#" + i+ "body").append('</tr>');
			}
		}
		$("#" + i).append('									</tbody> '+
				'</table>'+
				'</div>'+
			'</div>'+
			'<!-- /.panel-body -->'+
		'</div>'+
		'<!-- /.panel -->'+
	'</div>'+
	'<!-- /.col-lg-12 -->'+
'</div>'+
'<!-- /.row -->'+
'</div>');
	}
	return;
}


function draw(label, result, i){
	var ctx = document.getElementById(i + "canvas");
	var j=0;
	for(var i=0;i<result.length;i++){
		j+=result[i];
	}
	for(var i=0;i<result.length;i++){
		result[i]/=j;
	}
	var myChart = new Chart(ctx, {
	    type: "pie",
	    data: {
	        labels: label,
	        datasets: [{
	            label: "sold book number",
	            data: result,
	            backgroundColor: 'rgba(151,187,205,0.5)',
	            borderColor: 'rgba(151,187,205,1)',
	            fill : 'false'
	        }]
	    },
	    options: {
	        
	    }
	});
}

function downloadthis(){
		var content="";
		var headers = document.getElementsByTagName("p");
		content += "<p>"+headers[0].innerHTML+"</p>";
		content += "<p>"+headers[1].innerHTML+"</p>";
		var table = $("#container").html();
		content += table; 
		exportDoc(content,headers[1].getElementsByTagName("strong")[0].innerHTML.split("：")[1]);
}

function downloadimg(id){
	alert(id);
	var imgData = document.getElementById(id).toDataURL("image/png");
	download(imgData,id+".png","image/png");
}