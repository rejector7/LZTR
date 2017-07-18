var DELETE_NUM_QUESTION = -1;
var QUES_ID = 0;

$(function() {	
	$(".cancel").click(function(e){
		bootbox.confirm({
			buttons : {
				confirm : {
					label : 'Confirm'
				},
				cancel : {
					label : 'Cancel'
				}
			},
			message : "Sure to Leave? Your changes won't be saved",
			callback : function(result) {
				location.href = 'FrontPage';
			}
		});
	});
	
	$(".submit").click(function(e) {
		var form = document.getElementById("form");
		if(form == null){
			alert("no question");
			return;
		}
		var childs = form.childNodes;  
		if(childs.length == 0){
			alert("no question");
			return;
		}
		var result = {};
		
		var title = $("input[name='title']").val();
		if(title=="") {alert("Title can not be empty");return;}
		var intro = $("input[name='introduction']").val();
		//result['title'] = title;
		result['introduction'] = intro;
		result['questions'] = [];
		for(var k = 0 ; k < childs.length ; k++ ){
			result['questions'][k] = {};
			result['questions'][k]['id'] = k;
			var i = childs[k].getAttribute("id").split("div")[0];
			//result += "{id :" + i;
			//get the question stem
			//alert($("input[name=" + i + "]").val());
			var stem = $("input[name=" + i + "]").val();
			if(stem ==""){alert("the stem of question " + i + " is empty");return;}
			result['questions'][k]['stem'] = stem;
			//get the required
			var required = document.getElementById(i + "required");
			if(required.checked){
				result['questions'][k]['required'] = true;
			}
			else result['questions'][k]['required'] = false;
			//get the question type
			var type = (document.getElementById(i + "div")).getAttribute("value");
			switch(type){
			case '0':
				//alert("blank");
				result['questions'][k]['type'] = 'Subjective';
				break;
			case '1':
				result['questions'][k]['type'] = 'Single';
				//alert("single");
				//get all the options
				var option_form = document.getElementById(i + "container");
				var options = option_form.childNodes;
				if(options.length == 1){
					alert("question " + (i-DELETE_NUM_QUESTION) + " no option");
					return;
				}
				result['questions'][k]['options'] = [];
				for(var m = 1; m < options.length; m++){
					//alert($("input[name='" + i + "_" + j + "option']").val())
					var name = options[m].getAttribute("id").split("div")[0];
					var option = $("input[name=" + name + "]").val();
					var cf = document.getElementById(i+"_"+(m-1)+"cf");
					if(option == "") {alert("the content of question "+ i + " option "  + (m-1) + " is empty");return;}
					result['questions'][k]['options'][m-1] = {};
					result['questions'][k]['options'][m-1]['id'] = m;
					result['questions'][k]['options'][m-1]['option'] = option;
					if(cf.checked){
						result['questions'][k]['options'][m-1]['hasWords'] = true;
					}
					else result['questions'][k]['options'][m-1]['hasWords'] = false;
				}
				break;
			case '2':
				result['questions'][k]['type'] = 'Multiple';
				var option_form = document.getElementById(i + "container");
				var options = option_form.childNodes;
				if(options.length == 1){
					alert("question " + (i-DELETE_NUM_QUESTION) + " no option");
					return;
				}
				//get the number of options
				var num = (document.getElementById(i + "container")).getAttribute("value");
				if(num == 0 ){alert("question " + i + " must have at least 1 option");return;}
				//get min & max
				var min = $("input[name='" + i + "min']").val();
				var max = $("input[name='" + i + "max']").val();
				if(min > max) {alert("min must smaller than max");return;}
				if(min < 0) {alert("min must bigger than 0");return;}
				if(max > num) {alert("max must bigger than the number of options");return;}
				result['questions'][k]['min'] = min;
				result['questions'][k]['max'] = max;
 				//alert(min);alert(max);
				//alert("multiple");
 				//get all the options
				result['questions'][k]['options'] = [];
				for(var m = 1; m < options.length; m++){
					//alert($("input[name='" + i + "_" + j + "option']").val())
					var name = options[m].getAttribute("id").split("div")[0];
					var option = $("input[name=" + name + "]").val();
					if(option == "") {alert("the content of question "+ i + " option "  + j + " is empty");return;}
					result['questions'][k]['options'][m-1] = {};
					result['questions'][k]['options'][m-1]['id'] = m;
					result['questions'][k]['options'][m-1]['option'] = option;
					var cf = document.getElementById(i+"_"+(m-1)+"cf");
					if(cf.checked){
						result['questions'][k]['options'][m-1]['hasWords'] = true;
					}
					else result['questions'][k]['options'][m-1]['hasWords'] = false;
				}
				break;
			case '3':
				result['questions'][k]['type'] = 'Slider';
				//get min & max
				var min = $("input[name='" + i + "min']").val();
				if(min==""){alert("the min of question is empty");return;}
				var max = $("input[name='" + i + "max']").val();
				if(max==""){alert("the max of question is empty");return;}
				var mintext = $("input[name='" + i + "mintext']").val();
				if(mintext==""){alert("the min label of question is empty");return;}
				var maxtext = $("input[name='" + i + "maxtext']").val();
				if(maxtext==""){alert("the max label of question is empty");return;}
				if(min > max) {alert("min must smaller than max");return;}
				result['questions'][k]['min'] = min;
				result['questions'][k]['max'] = max;
				result['questions'][k]['mintext'] = mintext;
				result['questions'][k]['maxtext'] = maxtext;
				break;
			}
		}
		jQuery.ajax({
			url : 'addQuestionnaire',
			processData : true,
			dataType : "text",
			data : {
				title:encodeURI(encodeURI(title)),
				id:QUES_ID,
				content : encodeURI(encodeURI(JSON.stringify(result)))
			},
			success : function(data) {
				bootbox.alert({
					message : 'success',
				    callback : function() {
				    	location.href = 'FrontPage';
					}
				});
			}
		});
	});
	
	$(".addBlank").click(function(e){addBlank()});
	
	$(".addSingle").click(function(e){addSingle()});
	
	$(".addMultiple").click(function(e) {addMultiple()});
	
	$(".addSlider").click(function(e) {addSlider()});
	
});

function addOption(value){
	var div = document.getElementById(value + "container");
	var num = div.getAttribute("value");
	var newdiv = document.createElement("div");
	newdiv.id = value + "_" +num + "optiondiv";
	div.appendChild(newdiv);
	$("#" + value + "_" + num + "optiondiv").html("" +
			"<div class='container'>" +
			"<div class='row container col-lg-8'>" +
			"<input class='form-control' name='" + value +"_" + num + "option'>" +
			"</div>" +
			"<div class='col-lg-2'><div id='" + value +"_" + num +"button'>" +
			"</div></div>" +
			"<div class='col-lg-2'>" +
			"<label>comment field</label>" +
			"<input type='checkbox' id='" + value + "_" + num + "cf'>" +
			"</div>"+
			"");
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

function deleteQuestion(value){
	var victim = document.getElementById(value +"div");
	var next = victim.nextSibling;
	while(next !=null){
		var id = next.getAttribute("id");
		var font  = document.getElementById(id +"font");
		font.innerText = font.innerText * 1 - 1;
		next = next.nextSibling;
	}
	var form = document.getElementById("form");
	form.removeChild(victim);
	DELETE_NUM_QUESTION += 1;
}


function deleteOption(value, num){
	var container = document.getElementById(value +"container");
	var victim = document.getElementById(value +"_" + num+"optiondiv");
	container.removeChild(victim);
}

function upOption(value, num){
	if(num==0){
		return false;
	}
	var option_form = document.getElementById(value +"container");
	var options = option_form.childNodes;
	var name1 = options[num*1+1].getAttribute("id").split("div")[0];
	var option1 = $("input[name=" + name1 + "]").val();
	var id1 = name1.split("option")[0];
	var cf1 = document.getElementById(id1+"cf");
	var name2 = options[num].getAttribute("id").split("div")[0];
	var option2 = $("input[name=" + name2 + "]").val();
	var id2 = name2.split("option")[0];
	var cf2 = document.getElementById(id2+"cf");
	$("input[name=" + name1 + "]").val(option2);
	$("input[name=" + name2 + "]").val(option1);
	var tmp = cf1.checked;
	cf1.checked = cf2.checked;
	cf2.checked = tmp;
}

function downOption(value, num){
	var option_form = document.getElementById(value +"container");
	var options = option_form.childNodes;
	if(num==(options.length-2)){
		return false;
	}
	var name1 = options[num*1+1].getAttribute("id").split("div")[0];
	var option1 = $("input[name=" + name1 + "]").val();
	var id1 = name1.split("option")[0];
	var cf1 = document.getElementById(id1+"cf");
	var name2 = options[num*1+2].getAttribute("id").split("div")[0];
	var option2 = $("input[name=" + name2 + "]").val();
	var id2 = name2.split("option")[0];
	var cf2 = document.getElementById(id2+"cf");
	$("input[name=" + name1 + "]").val(option2);
	$("input[name=" + name2 + "]").val(option1);
	var tmp = cf1.checked;
	cf1.checked = cf2.checked;
	cf2.checked = tmp;
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
			"<input class='form-control' name='" + value +"_" + num + "option'>" +
			"</div>" +
			"<div class='col-lg-2'><div id='" + value +"_" + num +"button'>" +
			"</div></div>" +
			"<div class='col-lg-2'>" +
			"<label>comment field</label>" +
			"<input type='checkbox' id='" + value + "_" + num + "cf'>" +
			"</div>"+
			"");
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
			for(var i=0;i<children.length;i++){
				var id = children[i].getAttribute("id");
				$("#"+id+"font").html(i+1);
			}
		}
	});
	}
	else{
		var form = document.getElementById("form");
	}
	
	//create div
	var div = document.createElement("div");
	div.className = "form-group container";
	div.id = value + "div";
	div.setAttribute("value", "0");
	form.appendChild(div);
	
	//create stem label
	var div7 = document.createElement("div");
	div7.className = "row";
	div.appendChild(div7);
	
	var div5 = document.createElement("div");
	div5.className = "col-lg-10";
	div7.appendChild(div5);
	
	var label = document.createElement("label");
	div5.appendChild(label);
	
	var font = document.createElement("font");
	font.size = 5;
	font.id = value + "divfont";
	font.innerText = value-DELETE_NUM_QUESTION;
	label.appendChild(font);
	
	//create button to delete an question
	var div6 = document.createElement("div");
	div6.className = "col-lg-2";
	div7.appendChild(div6);
	
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){deleteQuestion(value)};
	div6.appendChild(button);
	
	var i = document.createElement("i");
	i.className = "fa fa-times";
	button.appendChild(i);
	
	//create div for input and required
	var div2 = document.createElement("div");
	div2.className = "row container";
	div.appendChild(div2);
	
	//create input
	var div3 = document.createElement("div");
	div3.className = "col-lg-10";
	div2.appendChild(div3);	
	var input = document.createElement("input");
	input.className = "form-control";
	input.name = value;
	div3.appendChild(input);
	
	//create required label
	var div4 = document.createElement("div");
	div4.className = "col-lg-2";
	div4.style="float:right";
	div5.appendChild(div4);
	var label2 = document.createElement("label");
	label2.innerText="required";
	div4.appendChild(label2);
	//create required option
	var input2 = document.createElement("input");
	input2.type = "checkbox";
	input2.id = value + "required";
	label2.appendChild(input2);
	
	body.setAttribute("value", value * 1 + 1);
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
			for(var i=0;i<children.length;i++){
				var id = children[i].getAttribute("id");
				$("#"+id+"font").html(i+1);
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
			"<div class='form-group container'><div class='row'>" +
			"<div class='col-lg-10'><label><font size='5' id='" + value + "divfont'>" + (value-DELETE_NUM_QUESTION) +"</font></label>" +
			"<div class='col-lg-2' style='float:right'>" +
			"<label>required</label>" +
			"<input type='checkbox' id='" + value + "required'>" +
			"</div></div>" +
			"<div class='col-lg-2' id='" + value + "button'></div></div>" +
			"<div class='row container'>" +
			"<div class='col-lg-10'>" +
			"<input class='form-control' name=" + value +"></div>" +
			"</div>" +
			"<div class='container' id='" + value + "container' value='0'>" +
			"<label><font size='5'>input your option</font></label></div>" +
			"<\label>" +
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
	button.appendChild(i);
	
	//create button to delete an question
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){deleteQuestion(value)};
	document.getElementById(value + "button").appendChild(button);
	
	var i = document.createElement("i");
	i.className = "fa fa-times";
	button.appendChild(i);
	
	body.setAttribute("value", value * 1 + 1);
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
			for(var i=0;i<children.length;i++){
				var id = children[i].getAttribute("id");
				$("#"+id+"font").html(i+1);
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
			"<div class='container'><div class='row'>" +
			"<div class='col-lg-4'><label><font size='5' id='" + value + "divfont'>" + (value-DELETE_NUM_QUESTION) +"</font></label></div>" +
			"<div class='col-lg-1'><label><font size='5'>max</font></label></div>" +
			"<div class='col-lg-1'><input class='form-control' type='number' step='1' name='" + value +"max'></div>" +
			"<div class='col-lg-1'><label><font size='5'>min</font></label></div>" +
			"<div class='col-lg-1'><input class='form-control' type='number' step='1' name='" + value +"min'></div>" +
			"<div class='col-lg-2'>" +
			"<label>required</label>" +
			"<input type='checkbox' id='" + value + "required'>" +
			"</div>" +
			"<div class='col-lg-2'><div id='" + value + "button'></div></div></div>" +
			"<div class='row container'>" +
			"<div class='col-lg-10'>" +
			"<input class='form-control' name=" + value + "></div>" +
			"</div>" +
			"<div class='container' id='" + value + "container' value='0'>" +
			"<label><font size='5'>input your option</font></label></div>" +
			"<\label>" +
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
	button.appendChild(i);
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
			for(var i=0;i<children.length;i++){
				var id = children[i].getAttribute("id");
				$("#"+id+"font").html(i+1);
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
			"<div class='container'><div class='row'>" +
			"<div class='col-lg-10'><label><font size='5' id='" + value + "divfont'>" + (value-DELETE_NUM_QUESTION) +"</font></label>" +
			"<div class='col-lg-2'><div id='" + value + "button'></div></div></div>" +
			"<div class='row container'>" +
			"<div class='col-lg-11'>" +
			"<input class='form-control' name=" + value + "></div>" +
			"<div class='col-lg-1'>" +
			"<label>required</label>" +
			"<input type='checkbox' id='" + value + "required'>" +
			"</div></div>" +
			"<div class='container'><div class='row'>" +
			"<div class='col-lg-1'><label><font size='5'>max</font></label></div>" +
			"<div class='col-lg-2'><input class='form-control' type='number' step='1' name='" + value +"max'></div>" +
			"<div class='col-lg-2'><label><font size='5'>max label</font></label></div>" +
			"<div class='col-lg-7'><input class='form-control' type='text' name='" + value +"maxtext'></div></div>" +
			"<div class='row'>" +
			"<div class='col-lg-1'><label><font size='5'>min</font></label></div>" +
			"<div class='col-lg-2'><input class='form-control' type='number' step='1' name='" + value +"min'></div>" +
			"<div class='col-lg-2'><label><font size='5'>min label</font></label></div>" +
			"<div class='col-lg-7'><input class='form-control' type='text' name='" + value +"mintext'></div></div>" +
			"</div></div></div>");
	
	
	//create button to delete an question
	var button = document.createElement("button");
	button.className = "btn btn-default";
	button.type = "button";
	button.style="floating:left";
	button.onclick = function(){deleteQuestion(value)};
	document.getElementById(value + "button").appendChild(button);
	
	var i = document.createElement("i");
	i.className = "fa fa-times";
	button.appendChild(i);
	
	body.setAttribute("value", value * 1 + 1);
};

function modify(result, id){
	$("input[name='title']").val(result['title']);
	$("input[name='introduction']").val(result['introduction']);
	//alert(result[0]['stem']);
	for(var i = 0; i < result['questions'].length; i++){
		var type = result['questions'][i]['type'];
		if(type=="Subjective"){
			addBlank();
			$("input[name="+i+"]").val(result['questions'][i]['stem']);
			if(result['questions'][i]['required']==true){
				var required = document.getElementById(i+"required");
				required.checked=true;
			}
		}
		else if(type=="Single"){
			addSingle();
			$("input[name="+i+"]").val(result['questions'][i]['stem']);
			if(result['questions'][i]['required']==true){
				var required = document.getElementById(i+"required");
				required.checked=true;
			}
			for(var j = 0; j < result['questions'][i]['options'].length; j++){
				addOption(i);
				$("input[name="+i+"_"+j+"option]").val(result['questions'][i]['options'][j]['option']);
				var cf = document.getElementById(i+"_"+j+"cf");
				cf.checked=result['questions'][i]['options'][j]['hasWords'];
			}
		}
		else if(type=="Multiple"){
			addMultiple();
			$("input[name="+i+"]").val(result['questions'][i]['stem']);
			if(result['questions'][i]['required']==true){
				var required = document.getElementById(i+"required");
				required.checked=true;
			}
			$("input[name="+i+"min]").val(result['questions'][i]['min']);
			$("input[name="+i+"max]").val(result['questions'][i]['max']);
			for(var j = 0; j < result['questions'][i]['options'].length; j++){
				addOption(i);
				$("input[name="+i+"_"+j+"option]").val(result['questions'][i]['options'][j]['option']);
				var cf = document.getElementById(i+"_"+j+"cf");
				cf.checked=result['questions'][i]['options'][j]['hasWords'];
			}
		}
		else if(type=="Slider"){
			addSlider();
			$("input[name="+i+"]").val(result['questions'][i]['stem']);
			if(result['questions'][i]['required']==true){
				var required = document.getElementById(i+"required");
				required.checked=true;
			}
			$("input[name="+i+"min]").val(result['questions'][i]['min']);
			$("input[name="+i+"mintext]").val(result['questions'][i]['mintext']);
			$("input[name="+i+"max]").val(result['questions'][i]['max']);
			$("input[name="+i+"maxtext]").val(result['questions'][i]['maxtext']);
		}
	}
};


function update(quesid){
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
