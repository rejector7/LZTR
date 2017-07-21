$(function(){
	$("#registerform").validate({
		messages:{
			username:{
				required:"Username is required."
			},
			password:{
				required:"Password is required."
			},
			confirmpassword:{
				required:"Confirm Password is required.",
				equalTo:"Please enter the same password again."
			},
			email:{
				required:"Email is required.",
				email:"Please enter a valid email address."
			},
			mobile:{
				rangelength:"Please enter a cellmobile number.",
				digits:"Please enter a cellmobile number.",
				required:"Cellmobile number is required."
			},
			qq:{
				digits:"Please enter a cellmobile number."
			}
		}
	});

	$("#register").click(function(){
		var username = $("input[name='username']").val();
		var password = $("input[name='password']").val();
		var email = $("input[name='email']").val();
		var mobile = $("input[name='mobile']").val();
		var country = $("input[name='country']").val();
		var city = $("input[name='city']").val();
		var qq = $("input[name='qq']").val();
		var wechat = $("input[name='wechat']").val();
		var sex = $("#form-sex").val();
		var age = $("input[name='age']").val();
		var job = $("input[name='job']").val();
		var reg=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
			if(!$("#registerform").validate({
			messages:{
				username:{
					required:"Username is required."
				},
				password:{
					required:"Password is required."
				},
				confirmpassword:{
					required:"Confirm Password is required.",
					equalTo:"Please enter the same password again."
				},
				email:{
					required:"Email is required.",
					email:"Please enter a valid email address."
				},
				mobile:{
					rangelength:"Please enter a cellmobile number.",
					digits:"Please enter a cellmobile number.",
					required:"Cellmobile number is required."
				},
				qq:{
					digits:"Please enter a cellmobile number."
				}
			}
		}).form()){
			return false;
		}
		jQuery.ajax({
			url : 'signupPro',
			dataType : "text",
			data : {
				username:username,
				password:password,
				email:email,
				mobile:mobile,
				qq:qq,
				wechat:wechat,
				country:country,
				city:city,
				age:age,
				sex:sex,
				job:job
			},
			success : function(data) {
				if(data=="dupusername"){
					document.getElementById("dupname").innerHTML=
						"User exists";
					return;
				}
				else if(data=="dupemail"){
					document.getElementById("dupname").innerHTML=
						"Email exists";
					return;
				}
				else{
					var addr = "https://mail." + email.split("@")[1];
					bootbox.alert({
						message : 'We have sent an activation email to your mailbox. Please check it out. ',
					    callback : function() {
					    	window.location.href= addr ;
						}
					});
				}
			}
		});
	});
	
	$('#modify').click(function(e){
		var oldpassword = $("input[name='oldpassword']").val();
		var newpassword = $("input[name='newpassword']").val();
		console.log(oldpassword, newpassword)
		
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		jQuery.ajax({
			url : 'updatePasswordPro',
			processData : true,
			dataType : "text",
			data : {
				id : id,
				old : oldpassword,
				password : newpassword
			},
			success : function(data) {
				console.log(id);
				if(data=="false"){
					bootbox.alert({
						message : 'old password is wrong',
						callback : function() {
							location.reload();
						}
					});
				}
				else{
				bootbox.alert({
					message : 'Modify Successfully! ',
					callback : function() {
						location.href='loginPage';
					}
				});
			}
			}
			
		});
	});

	$("#save").click(function(e) {
		var sex = $("input[name='sex']").val();
		var mobile = $("input[name='mobile']").val();
		var country = $("input[name='country']").val();
		var city = $("input[name='city']").val();
		var email = $("input[name='email']").val();
		var age = $("input[name='age']").val();
		var job = $("input[name='job']").val();
		console.log(sex, mobile, country, city, email, age, job);

		var dataset = e.currentTarget.dataset;
		var id = dataset.id;

		if (id != "") { // Edit
			jQuery.ajax({
				url : 'updateMyInfoPro',
				processData : true,
				dataType : "text",
				data : {
					id : id,
					sex : sex,
					mobile : mobile,
					country : country,
					city : city,
					email : email,
					age : age,
					job : job
				},
				success : function(data) {
					console.log(id);
					alert(age);
					bootbox.alert({
						message : 'Modify Successfully! ',
						callback : function() {
							location.reload();
						}
					});
				}
				
			});
		} else { // Add
			jQuery.ajax({
				url : 'addUserPro',
				processData : true,
				dataType : "text",
				data : {
					username : username,
					password : password,
					role : role
				},
				success : function(data) {
					bootbox.alert({
						message : 'Add Successfully! ',
						callback : function() {
							location.reload();
						}
					});
				}
			})
		}

		$('#modal').modal('hide');
	});
	$(".edit").click(function(e) {
		$('#modalTitle').html("Edit");
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		console.log(id);

		$("input[name='sex']").val(dataset.sex);
		if(dataset.mobile=="0")$("input[name='mobile']").val();
		else $("input[name='mobile']").val(dataset.mobile);
		$("input[name='country']").val(dataset.country);
		$("input[name='city']").val(dataset.city);
		$("input[name='email']").val(dataset.email);
		if(dataset.age=="0")$("input[name='age']").val();
		else $("input[name='age']").val(dataset.age);
		$("input[name='job']").val(dataset.job);

		$("#save").attr("data-id", dataset.id);
		$('#modal').modal('show');
	});

	
	$(".modifypw").click(function(e){
		$('#modalTitle2').html("modify password");
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		console.log(id);
		
		$("input[name='oldpassword']").val("");
		$("input[name='newpassword']").val("");
		
		$("#modify").attr("data-id", dataset.id);
		$('#modal2').modal('show');
	});

});