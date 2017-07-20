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
				rangelength:"Please enter a cellphone number.",
				digits:"Please enter a cellphone number.",
				required:"Cellphone number is required."
			},
			qq:{
				digits:"Please enter a cellphone number."
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
					rangelength:"Please enter a cellphone number.",
					digits:"Please enter a cellphone number.",
					required:"Cellphone number is required."
				},
				qq:{
					digits:"Please enter a cellphone number."
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
				}
				else if(data=="dupemail"){
					document.getElementById("dupname").innerHTML=
						"Email exists";
				}
				//else{window.location.href="loginPage";}
			}
		});
	});
});