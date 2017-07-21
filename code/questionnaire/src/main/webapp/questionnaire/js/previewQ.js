var Q = {};
var QUESID = 0;

function getQ(id){
	QUESID = id;
	jQuery.ajax({
		url : 'getQuestionnaire',
		processData : true,
		dataType : "json",
		data : {
			id:id,
		},
		success : function(data) {
			formQ(data);
		}
	});
}

function formQ(data){
	Q = data;
	var title = data['title'];
	var introduction = data['introduction'];
	var questions = data['questions'];
	var length = questions.length;
	var result = [];
	
	//create title & introduction
	$("#questionnaire").html("<h1 class='text-muted' style='color:black' align='center'><font size='10'>" + title + "</font></h1>" +
			"<p align='center'>" + introduction + "</head>");
	//create questions
	for(var i = 0 ; i < length ; i++){
		var question = questions[i];
		addStem(question, i);
		var type = question['type'];
		if(type=="Subjective") result[i] = addSubjective(question, i);
		else if(type=="Single") result[i] = addSingle(question, i);
		else if(type=="Multiple") result[i] = addMultiple(question, i);
		else if(type=="Slider") result[i] = addSlider(question, i);
	}
	//alert(result);
}

function addStem(question, i){
	var form = document.getElementById("form");
	//create stem
	var div = document.createElement("div");
	div.id = i;
	div.className = "container";
	form.appendChild(div);
	if(question['type']=="Multiple"&&question['min']!=undefined&&question['min']!=null&&question['min']!=""){
		$("#"+i).html("<p2><font size='4'>" + (i+1)  + " "+ question['stem'] + "("+question['min']+"~"+question['max']+"项)</font>");
	}
	else $("#"+i).html("<p2><font size='4'>" + (i+1)  + " "+ question['stem'] + "</font>");
	if(question['required']==true){
		$("#"+i).append("<font color='red' size='4'>&nbsp*</font>");
	}
	$("#"+i).append("</p2>");
}

function addSubjective(question, i){
	var div = document.getElementById(i);
	div.setAttribute("value", 0);
	var newDiv = document.createElement("div");
	newDiv.id = i + "div";
	newDiv.className = "container";
	div.appendChild(newDiv);
	if(question['required']==true){
	$("#"+i + "div").html("<div class='col-lg-10'><div><input class='form-control' required name=" + i + "></input></div></div>" +
			"");
	}
	else{
		$("#"+i + "div").html("<div class='col-lg-10'><input class='form-control' name=" + i + "></input></div>" +
		"");
	}
	return;
}

function addSingle(question, i){
	var div = document.getElementById(i);
	div.setAttribute("value", 1);
	var newDiv = document.createElement("div");
	newDiv.id = i + "div";
	newDiv.className = "container";
	div.appendChild(newDiv);
	for(var j = 0 ; j < question['options'].length; j++){
		if(question['options'][j]['hasWords']==true){
			if(question['required']==false){
	$("#"+i + "div").append("<p><div class='radio' ><label  style='float:left'><input type='radio' value=" + j +" name=" + i + ">" +
			"<font size='4'><strong>" + question['options'][j]['option'] + "</strong></font></label>");
		$("#"+i + "div").append("<div><input  name='" + i + "_" + j + "words'></div>");
	}else{
		$("#"+i + "div").append("<p><div class='radio' ><label  style='float:left'><input required type='radio' value=" + j +" name=" + i + ">" +
				"<font size='4'><strong>" + question['options'][j]['option'] + "</strong></font></label>");
			$("#"+i + "div").append("<div><input  name='" + i + "_" + j + "words'></div>");
	}
			}
		else{
			if(question['required']==false){
			$("#"+i + "div").append("<p><div class='radio' ><label><input type='radio' value=" + j +" name=" + i + ">" +
					"<font size='4'><strong>" + question['options'][j]['option'] + "</strong></font></label>");
			}
			else{
				$("#"+i + "div").append("<p><div class='radio' ><label><input required type='radio' value=" + j +" name=" + i + ">" +
						"<font size='4'><strong>" + question['options'][j]['option'] + "</strong></font></label>");
			}
		}
	$("#"+i + "div").append("</div></p>");
	}
	return;
}

function addMultiple(question, i){
	var div = document.getElementById(i);
	div.setAttribute("value", 2);
	var newDiv = document.createElement("div");
	newDiv.id = i + "div";
	newDiv.className = "container";
	div.appendChild(newDiv);
	$("#"+i + "div").append("<strong><div id='" + i + "message' class='error'></div></strong>")
	for(var j = 0 ; j < question['options'].length; j++){
		if(question['options'][j]['hasWords']==true){
			if(question['required']==false){
			$("#"+i + "div").append("<p><label  style='float:left'><input type='checkbox' value=" + j +" name=" + i + 
					 ">" +
					"<font size='4'><strong>" + question['options'][j]['option'] + "</strong></font></label>");
				$("#"+i + "div").append("<div><input  name='" + i + "_" + j + "words'>");
			}
			else{
				$("#"+i + "div").append("<p><label  style='float:left'><input required type='checkbox' value=" + j +" name=" + i +
						">" +
						"<font size='4'><strong>" + question['options'][j]['option'] + "</strong></font></label>");
					$("#"+i + "div").append("<div><input  name='" + i + "_" + j + "words'>");
			}
			}
				else{
					if(question['required']==false){
					$("#"+i + "div").append("<p><label><input type='checkbox' value=" + j +" name=" + i +
							">" +
							"<font size='4'><strong>" + question['options'][j]['option'] + "</strong></font></label>");
					}
					else{
						$("#"+i + "div").append("<p><label><input required type='checkbox' value=" + j +" name=" + i + 
								">" +
								"<font size='4'><strong>" + question['options'][j]['option'] + "</strong></font></label>");
					}
				}
			$("#"+i + "div").append("</p>");
			}
	return;
}

function addSlider(question, i){
	var div = document.getElementById(i);
	div.setAttribute("value", 3);
	var newDiv = document.createElement("div");
	newDiv.id = i + "div";
	newDiv.className = "container";
	div.appendChild(newDiv);
	if(question['required']==true){
	$("#"+i + "div").append("<p><div class='row'><div class='col-lg-6'  style='padding-top:10px'><div id='"+ i + "slider' style='padding-up:100px'></div>" +
			"<div class='col-lg-6'>" + question['min'] + "  " + question['mintext'] + "</div>" +
			"<div class='col-lg-6' align='right'>" + question['maxtext'] + "  " + question['max'] + "</div>" +
			"</div>" +
			"<div class='col-lg-1'><input class='form-control' id='"+ i +"input' name=" + i +" type='number' step='1' min=" + question['min'] + " max=" + question['max'] +"></div></div>" +
			"</p>");
	}
	else{
		$("#"+i + "div").append("<p><div class='row'><div class='col-lg-6'  style='padding-top:10px'><div id='"+ i + "slider' style='padding-up:100px'></div>" +
				"<div class='col-lg-6'>" + question['min'] + "  " + question['mintext'] + "</div>" +
				"<div class='col-lg-6' align='right'>" + question['maxtext'] + "  " + question['max'] + "</div>" +
				"</div>" +
				"<div class='col-lg-1'><input class='form-control' id='"+ i +"input' name=" + i +" type='number' step='1' min=" + (question['min']*1-1) + " max=" + question['max'] +"></div></div>" +
				"</p>");
	}
    var slider = $( "#"+i+"slider" ).slider({
        range: "min",
        min: question['min'] * 1,
        max: question['max'] * 1,
        value: question['min'],
        slide: function( event, ui ) {
            $( "#"+i+"input" ).val(ui.value );
          }
    });
    $( "#"+i+"input" ).val(question['min']*1 -1);
    $( "#"+i+"input" ).change(function() {
        slider.slider( "value", this.value );
      });
	return;
}

function wordexport(){
	var content = $("#questionnaire").html();
	var fc = "";
	var form = document.getElementById("form");
	var questions = form.childNodes;
	var length = questions.length;
	for(var i = 0; i < length; i++){
		var type = document.getElementById(i).getAttribute("value");
		switch(type){
		case'0':
			var question = document.getElementById(i);
			var stem = question.getElementsByTagName("p2")[0];
			if(stem.nextSibling.tagName=="FONT"){
				fc+="<p>"+stem.innerHTML;
				fc+="<font color='red' size='4'>&nbsp;*</font></p>";			}
			else{
				fc+="<p>"+stem.innerHTML+"</p>";
			}
			fc += "<p>____________</p>";
			break;
		case'1':
			var question = document.getElementById(i);
			var stem = question.getElementsByTagName("p2")[0];
			if(stem.nextSibling.tagName=="FONT"){
				fc+="<p>"+stem.innerHTML;
				fc+="<font color='red' size='4'>&nbsp;*</font></p>";			}
			else{
				fc+="<p>"+stem.innerHTML+"</p>";
			}
			var optiondiv = document.getElementById(i+"div");
			var opts = optiondiv.getElementsByTagName("strong");
			var divs = optiondiv.getElementsByTagName("input");
			var options = new Array();
			for(var k=0;k<opts.length;k++){
				options[k] = "<p>○"+opts[k].innerHTML+"</p>";
			}
			for(var k=0;k<divs.length;k++){
				var words = divs[k];
				if(words.name[words.name.length-1]=="s"){
					options[words.name[0]]="<p>○"+opts[words.name[0]].innerHTML+"_________</p>";
				}
			}
			for(var k=0;k<options.length;k++){
				fc+=options[k];
			}
			break;
		case'2':
			var question = document.getElementById(i);
			var stem = question.getElementsByTagName("p2")[0];
			if(stem.nextSibling.tagName=="FONT"){
				fc+="<p>"+stem.innerHTML;
				fc+="<font color='red' size='4'>&nbsp;*</font></p>";			}
			else{
				fc+="<p>"+stem.innerHTML+"</p>";
			}
			var optiondiv = document.getElementById(i+"div");
			var opts = optiondiv.getElementsByTagName("strong");
			var divs = optiondiv.getElementsByTagName("input");
			var options = new Array();
			for(var k=1;k<opts.length;k++){
				options[k] = "<p>☐"+opts[k].innerHTML+"</p>";
			}
			for(var k=0;k<divs.length;k++){
				var words = divs[k];
				if(words.name[words.name.length-1]=="s"){
					options[words.name[0]]="<p>☐"+opts[words.name[0]].innerHTML+"_________</p>";
				}
			}
			for(var k=1;k<options.length;k++){
				fc+=options[k];
			}
			break;
	    	break;
		case'3':
			var question = document.getElementById(i);
			var stem = question.getElementsByTagName("p2")[0];
			if(stem.nextSibling.tagName=="FONT"){
				fc+="<p>"+stem.innerHTML;
				fc+="<font color='red' size='4'>&nbsp;*</font></p>";
			}
			else{
				fc+="<p>"+stem.innerHTML+"</p>";
			}
			var slider = document.getElementById(i + "slider");
			var min = slider.nextSibling.innerText.split(" ")[0];
			var max = slider.nextSibling.nextSibling.innerText.split(" ")[1];
			fc += "<font size='2'>取值范围在" + min + "与" + max + "之间</font>"; 
		}
	}
	content+=fc;
	var header = document.getElementById("questionnaire");
	var filename = header.getElementsByTagName("h1")[0].getElementsByTagName("font")[0].innerHTML;
	exportDoc(content,filename)
}