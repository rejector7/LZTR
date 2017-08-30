var colors = [
    'rgba(255, 99, 132, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(255, 206, 86, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(153, 102, 255, 0.2)',
    'rgba(255, 159, 64, 0.2)',
	];

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
					'					<thead id="'+i+'"head>' +
					'						</thead><tbody id ="' + i + 'body">');
		if(type=="Subjective"){
			$("#"+i+"head").append('<th width="40%">答卷号</th>' +
			'							<th width="60%">答案</th>' +
			'						</tr>');
			for(var j = 0 ; j < answers.length; j++){
				if(answers[j][i]['words']!=null&&answers[j][i]['words']!=undefined&&answers[j][i]['words']!=""){
					$("#" + i + "body").append('<tr id="' + i + '_' + j + 'tr">');
					$("#" + i+ "_" + j+ "tr").append('<td>' + (j+1) + "</td>");
					$("#" + i+ "_" + j+ "tr").append('<td>' + answers[j][i]['words'] + "</td>");
					$("#" + i+ "body").append('</tr>');
				}
			}
		}
		else if(type=="Single"){
			$("#"+i+"head").append('<th width="40%">选项号</th>' +
					'							<th width="60%">选择数</th>' +
					'						</tr>');
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
			/*draw(label, result, i);
			var button = document.createElement("button");
			button.className="btn btn-default";
			//alert(canvas.id);
			button.onclick=function(){downloadimg(canvas.id)};
			button.innerText="下载图片";
			div.appendChild(button);*/
			drawButton(i, label, result);
		}
		else if(type=="Multiple"){
			$("#"+i+"head").append('<th width="40%">选项号</th>' +
					'							<th width="60%">选择数</th>' +
					'						</tr>');
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
			drawButton(i, label, result);
		}
		else if(type=="Slider"){
			$("#"+i+"head").append('<th width="40%">填写数量</th>' +
					'							<th width="60%">平均值</th>' +
					'						</tr>');
			var totamt = 0;
			var tot = 0;
			var avg = 0;
			for(var j = 0 ; j < answers.length; j++){
				if(answers[j][i]['number'] >= ques["min"]){
					totamt += 1;
					tot += answers[j][i]['number']*1;
				}	
			}
			avg = (tot/totamt).toFixed(2)
			$("#" + i + "body").append('<tr id="' + i + '_' + 0 + 'tr">');
			$("#" + i+ "_" + 0+ "tr").append('<td>' + totamt + "</td>");
			$("#" + i+ "_" + 0+ "tr").append('<td>' + avg + "</td>");
			$("#" + i+ "body").append('</tr>');
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


function drawPie(label, result, i){
	var canvas = document.getElementById(i + "canvas");
	if(canvas!=null){
		document.getElementById(i+"beforecanvas").remove();
	}
	$("#" + i).append("<div id='" + i + "beforecanvas'><div class='col-lg-4'></div>" +
			"<div class='col-lg-4'>" +
					"<canvas id='"+i+"canvas'" +
					"</div></div>");
	canvas = document.getElementById(i + "canvas");
	
	
	label = label.split(",");
	result = result.split(",");
	for(var i = 7 ; i < result.size; i++){
		colors[i] =  'rgba(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) +', 0.2'+ ')';
	}
	
	
	var myChart = new Chart(canvas, {
	    type: "pie",
	    data: {
	        labels: label,
	        datasets: [{
	            label: "number",
	            data: result,
	            backgroundColor: colors,
	            fill : 'false'
	        }]
	    }
	});
}

function drawBar(label, result, i){
	var canvas = document.getElementById(i + "canvas");
	if(canvas!=null){
		document.getElementById(i+"beforecanvas").remove();
	}
	$("#" + i).append("<div id='" + i + "beforecanvas'><div class='col-lg-3'></div>" +
			"<div class='col-lg-6'>" +
					"<canvas id='"+i+"canvas'" +
					"</div></div>");
	canvas = document.getElementById(i + "canvas");
	
	label = label.split(",");
	result = result.split(",");

	for(var i = 7 ; i < result.size; i++){
		colors[i] =  'rgba(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) +', 0.2'+ ')';
	}
	
	
	var myChart = new Chart(canvas, {
	    type: "bar",
	    data: {
	        labels: label,
	        datasets: [{
	            label: "number",
	            data: result,
	            backgroundColor: colors,
	            fill : 'false'
	        }]
	    },
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        }
	    }
	});
}

function drawDoughnut(label, result, i){
	var canvas = document.getElementById(i + "canvas");
	if(canvas!=null){
		document.getElementById(i+"beforecanvas").remove();
	}
	$("#" + i).append("<div id='" + i + "beforecanvas'><div class='col-lg-4'></div>" +
			"<div class='col-lg-4'>" +
					"<canvas id='"+i+"canvas'>" +
					"</div></div>");
	canvas = document.getElementById(i + "canvas");
	
	label = label.split(",");
	result = result.split(",");
	
	for(var i = 7 ; i < result.size; i++){
		colors[i] =  'rgba(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) +', 0.2'+ ')';
	}
	
	var myChart = new Chart(canvas, {
	    type: 'doughnut',
	    data: {
	        labels: label,
	        datasets: [{
	            label: "number",
	            data: result,
	            backgroundColor: colors,
	            fill : 'false'
	        }]
	    }
	});
}

function drawLine(label, result, i){
	var canvas = document.getElementById(i + "canvas");
	if(canvas!=null){
		document.getElementById(i+"beforecanvas").remove();
	}
	$("#" + i).append("<div id='" + i + "beforecanvas'><div class='col-lg-3'></div>" +
			"<div class='col-lg-6'>" +
					"<canvas id='"+i+"canvas'" +
					"</div></div>");
	canvas = document.getElementById(i + "canvas");
	
	label = label.split(",");
	result = result.split(",");
	
	var myChart = new Chart(canvas, {
	    type: 'line',
	    data: {
	        labels: label,
	        datasets: [{
	            label: "number",
	            data: result,
	            backgroundColor: 'rgba(151,187,205,0.5)',
	            borderColor: 'rgba(151,187,205,1)',
	            fill:false
	        }]
	    },
	    options: {
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        }
	    }
	});
}

function downloadthis(){
		var content="";
		
		/*var styles = document.getElementsByTagName("LINK");
		var style = "<style>";
		for(var i=0;i<styles.length;i++){
			var len = document.styleSheets[i].cssRules.length;
			for(var j=0;j<len;j++){
				style+=document.styleSheets[i].cssRules[j].cssText;
			}
		}
		style+="</style>";
		content+=style;*/
		var styles = document.getElementsByTagName("LINK");
		var style = "<style>";
		
		style+="table, td, th {border-collapse: collapse;border: 1px solid black;}</style>";
		content+=style;
		content+="</head><body>";
		var headers = document.getElementsByTagName("P");
		content += "<p>"+headers[0].innerHTML+"</p>";
		content += "<p>"+headers[1].innerHTML+"</p>";
		var table = $("#container").html();
		var canvas = document.getElementById("1canvas");
		$("#container").append("<img src = "+canvas.toDataURL('image/jpeg')+">");
		content += $("#container").html(); 
		content+=table+"</body>";
		exportDoc(content,headers[1].getElementsByTagName("strong")[0].innerHTML.split("：")[1]);
}

function downloadimg(id){
	//alert(id);
	var imgData = document.getElementById(id).toDataURL("image/png");
	download(imgData,id+".png","image/png");
}

function drawButton(i, label, result){
	$("#" + i).append("<div class='container row' align='right'>" +
			"<button class='btn btn-default' type='button' >" +
			"<i class='fa fa-bar-chart-o' onclick=\"drawBar('"+ label + "','" + result + "',"  + i + ")\">柱状图</i>" + 
			"</button>" +
			"<button class='btn btn-default' type='button' >" +
			"<i class='fa fa-pie-chart' onclick=\"drawPie('"+ label + "','" + result + "',"  + i + ")\">饼状图</i>" + 
			"</button>" +
			"<button class='btn btn-default' type='button' >" +
			"<i class='fa fa-circle-o-notch' onclick=\"drawDoughnut('"+ label + "','" + result + "',"  + i + ")\">圆环图</i>" + 
			"</button>" +
			"<button class='btn btn-default' type='button' >" +
			"<i class='fa fa-line-chart' onclick=\"drawLine('"+ label + "','" + result + "',"  + i + ")\">折线图</i>" + 
			"</button>" +
					"</div>");
}