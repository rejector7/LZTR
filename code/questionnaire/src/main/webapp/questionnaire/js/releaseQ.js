$(function() {
	
	
	$(".submit").click(function(e) {
		var body = document.body;
		var value = body.getAttribute("value");
		for(var i = 0; i < value; i++){
			//get the question stem
			//alert($("input[name=" + i + "]").val());
			var stem = $("input[name=" + i + "]").val();
			if(stem ==""){alert("the stem of question " + i + " is empty");return;}
			//get the required
			var required = document.getElementById(i + "required");
			//if(required.checked){alert("checked");}
			//get the question type
			var type = (document.getElementById(i + "div")).getAttribute("value");
			switch(type){
			case '0':
				//alert("blank");
				break;
			case '1':
				//alert("single");
				//get all the options
				var num = (document.getElementById(i + "container")).getAttribute("value");
				for(var j = 0; j < num; j++){
					//alert($("input[name='" + i + "_" + j + "option']").val())
					var option = $("input[name='" + i + "_" + j + "option']").val();
					if(option == "") {alert("the content of question "+ i + " option "  + j + " is empty");return;}
				}
				break;
			case '2':
				//get the number of options
				var num = (document.getElementById(i + "container")).getAttribute("value");
				if(num == 0 ){alert("question " + i + " must have at least 1 option");return;}
				//get min & max
				var min = $("input[name='" + i + "min']").val();
				var max = $("input[name='" + i + "max']").val();
				if(min > max) {alert("min must smaller than max");return;}
				if(min < 0) {alert("min must bigger than 0");return;}
				if(max > num) {alert("max must bigger than the number of options");return;}
 				//alert(min);alert(max);
				//alert("multiple");
 				//get all the options
				for(var j = 0; j < num; j++){
					var option = $("input[name='" + i + "_" + j + "option']").val();
					if(option == "") {alert("the content of question "+ i + " option "  + j + " is empty");return;}
					//alert($("input[name='" + i + "_" + j + "option']").val());
				}
				break;
			}
		}
		alert("submit successfully");
		/*for(var i = 0; i < form.length/2; i++){
			alert($("input[name=" + i + "]").val());
			var required = document.getElementById(i + "required");
			if(required.checked){alert("checked");}
		}*/
	});
	
	$(".addBlank").click(function(e) {
		var body = document.body;
		var value = body.getAttribute("value");
		//create form
		if(value=="0"){
		var form = document.createElement("form");
		form.id = 'form';
		form.role = "role";
		body.appendChild(form);
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
		
		//create label
		var label = document.createElement("label");
		div.appendChild(label);
		
		var font = document.createElement("font");
		font.size = 5;
		font.innerText = value + " input your blank-filling question";
		label.appendChild(font);
		
		//create div for input and required
		var div2 = document.createElement("div");
		div2.className = "row container";
		div.appendChild(div2);
		
		//create input
		var div3 = document.createElement("div");
		div3.className = "col-lg-11";
		div2.appendChild(div3);	
		var input = document.createElement("input");
		input.className = "form-control";
		input.name = value;
		div3.appendChild(input);
		
		//create required label
		var div4 = document.createElement("div");
		div4.className = "col-lg-1";
		div2.appendChild(div4);
		var label2 = document.createElement("label");
		label2.innerText="required";
		div4.appendChild(label2);
		//create required option
		var input2 = document.createElement("input");
		input2.type = "checkbox";
		input2.id = value + "required";
		label2.appendChild(input2);
		
		body.setAttribute("value", value * 1 + 1);

	});
	
	$(".addSingle").click(function(e) {
		var body = document.body;
		var value = body.getAttribute("value");
		//create form
		if(value=="0"){
		var form = document.createElement("form");
		form.id = 'form';
		form.role = "role";
		body.appendChild(form);
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
				"<div class='col-lg-11'><label><font size='5'>" + value +" input your single option question</font></label></div>" +
				"<div class='col-lg-1'><div id='" + value + "button'></div></div></div>" +
				"<div class='row container'>" +
				"<div class='col-lg-11'>" +
				"<input class='form-control' name=" + value +"></div>" +
				"<div class='col-lg-1'>" +
				"<label>required</label>" +
				"<input type='checkbox' id='" + value + "required'>" +
				"</div></div>" +
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
		i.innerText = "A New Option";
		button.appendChild(i);
		
		body.setAttribute("value", value * 1 + 1);
	});
	
	$(".addMultiple").click(function(e) {
		var body = document.body;
		var value = body.getAttribute("value");
		//create form
		if(value=="0"){
		var form = document.createElement("form");
		form.id = 'form';
		form.role = "role";
		body.appendChild(form);
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
				"<div class='col-lg-5'><label><font size='5'>" + value +" input your multiple option question</font></label></div>" +
				"<div class='col-lg-1'><label><font size='5'>max</font></label></div>" +
				"<div class='col-lg-2'><input class='form-control' type='number' step='1' name='" + value +"max'></div>" +
				"<div class='col-lg-1'><label><font size='5'>min</font></label></div>" +
				"<div class='col-lg-2'><input class='form-control' type='number' step='1' name='" + value +"min'></div>" +
				"<div class='col-lg-1'><div id='" + value + "button'></div></div></div>" +
				"<div class='row container'>" +
				"<div class='col-lg-11'>" +
				"<input class='form-control' name=" + value + "></div>" +
				"<div class='col-lg-1'>" +
				"<label>required</label>" +
				"<input type='checkbox' id='" + value + "required'>" +
				"</div></div>" +
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
		i.innerText = "A New Option";
		button.appendChild(i);
		body.setAttribute("value", value * 1 + 1);
	});
	
});

function addOption(value){
	var div = document.getElementById(value + "container");
	var num = div.getAttribute("value");
	var newdiv = document.createElement("div");
	newdiv.id = value + "_" +num + "optiondiv";
	div.appendChild(newdiv);
	$("#" + value + "_" + num + "optiondiv").html("" +
			"<div class='container'>" +
			"<div class='col-lg-1'><label><font size='3'>" + num + "</font></label></div>"+
			"<div class='row container col-lg-9'>" +
			"<input class='form-control' name='" + value +"_" + num + "option'>" +
			"<\label></div></div></div>");
	div.setAttribute("value",  num * 1 + 1);
}

