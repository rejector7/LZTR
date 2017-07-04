$(function() {
	
	
	$(".submit").click(function(e) {
		var form = document.getElementById("form");
		for(var i = 0; i < form.length/2; i++){
			alert($("input[name=" + i + "]").val());
			var required = document.getElementById(i + "required");
			if(required.checked){alert("checked");}
		}
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
		
		//create div
		var div = document.createElement("div");
		div.className = "form-group container";
		form.appendChild(div);
		
		//create label
		var label = document.createElement("label");
		label.innerText="input your question";
		div.appendChild(label);
		
		//create div for input and required
		var div2 = document.createElement("div");
		div2.className = "row container";
		div.appendChild(div2);
		
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
		
		//create input
		var div3 = document.createElement("div");
		div3.className = "col-lg-10";
		div2.appendChild(div3);
		var input = document.createElement("input");
		input.className = "form-control";
		input.name = value;
		div3.appendChild(input);
		
		body.setAttribute("value", value * 1 + 1);

	});
});