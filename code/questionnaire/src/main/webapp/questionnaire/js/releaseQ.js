$(function() {
	
	
	$(".submit").click(function(e) {
		var form = document.getElementById("form");
		for(var i = 0; i < form.length/2; i++){
			alert($("input[name=" + i + "]").val());
			var required = document.getElementById(i + "required");
			if(required.checked){alert("checked");}
		}
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
		form.appendChild(div);
		
		//create label
		var label = document.createElement("label");
		div.appendChild(label);
		
		var font = document.createElement("font");
		font.size = 5;
		font.innerText = "input your blank-filling question";
		label.appendChild(font);
		
		//create div for input and required
		var div2 = document.createElement("div");
		div2.className = "row container";
		div.appendChild(div2);
		
		//create input
		var div5 = document.createElement("div");
		div5.className = "col-lg-1";
		div2.appendChild(div5);	
		var newlabel = document.createElement("label");
		div5.appendChild(newlabel);	
		var font2 = document.createElement("font");
		font2.size = '3';
		font2.innerText = value;
		newlabel.appendChild(font2);	
		var div3 = document.createElement("div");
		div3.className = "col-lg-9";
		div2.appendChild(div3);	
		var input = document.createElement("input");
		input.className = "form-control";
		input.name = value;
		div3.appendChild(input);
		
		//create required label
		var div4 = document.createElement("div");
		div4.className = "col-lg-2";
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
		form.appendChild(div);
		$("#"+value+"div").html("" +
				"<div class='form-group container'><div class='row'>" +
				"<div class=col-lg-9><label><font size='5'>input your single option question</font></label></div>" +
				"<div class=col-lg-3><div id=" + value + "></div></div></div>" +
				"<div class='row container'>" +
				"<div class='col-md-1'><label><font size='3'>" + value +"</font></label></div>" +
				"<div class='col-md-9'>" +
				"<input class='form-control' ></div>" +
				"<div class='col-md-2'>" +
				"<label>required</label>" +
				"<input type='checkbox' id=" + value + "required'>" +
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
		document.getElementById(value).appendChild(button);
		
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
			"<input class='form-control'>" +
			"<\label></div></div></div>");
	div.setAttribute("value",  num * 1 + 1);
}

