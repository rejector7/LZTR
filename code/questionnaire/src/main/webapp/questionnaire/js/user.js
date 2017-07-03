$(function(){
	alert("aaa");

	$("#register").click(function(e){
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
					email:"Please enter a valid email address."
				},
				mobile:{
					rangelength:"Please enter a cellphone number.",
					digits:"Please enter a cellphone number."
				},
				qq:{
					digits:"Please enter a cellphone number."
				}
			}
		}).form()){
			return false;
		}
		alert("111");
		jQuery.ajax({
			url : '/questionnaire/addUser',
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
				sex:sex
			},
			success : function(data) {
				alert(data);
				if(data=="itdepends"){
					document.getElementById("dupname").innerHTML=
						"User exists";
					return;
				}
			}
		});
	});
});