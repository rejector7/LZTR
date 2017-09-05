$(function(){
	$("#registerform").validate({
		messages:{
			username:{
				required:"用户名必填"
			},
			password:{
				required:"密码必填"
			},
			age:{
				digits:"请输入整数。"
			},
			confirmpassword:{
				required:"请再次输入密码",
				equalTo:"请再次输入相同的密码"
			},
			email:{
				required:"邮箱必填",
				email:"请输入一个有效的邮箱"
			},
			qq:{
				digits:"请输入一个QQ账号"
			}
		}
	});

	$("#infoform").validate({
		messages:{
			qq:{
				digits:"请输入一个正确的QQ号"
			},
			age:{
				digits:"请输入整数。",
				min:"请输入一个非负整数"
			}
		}
	});
	
	$("#passwordform").validate({
		messages:{
			oldpassword:{
				required:"请输入你的旧密码。"
			},
			newpassword:{
				required:"请输入你的新密码。"
			},
			confirmpassword:{
				required:"请再次输入密码确认。",
				equalTo:"输入的密码与新密码不同。"
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
					required:"用户名必填"
				},
				password:{
					required:"密码必填"
				},
				age:{
					digits:"请输入整数。"
				},
				confirmpassword:{
					required:"请再次输入密码",
					equalTo:"请再次输入相同的密码"
				},
				email:{
					required:"邮箱必填",
					email:"请输入一个有效的邮箱"
				},
				qq:{
					digits:"请输入一个QQ账号"
				}
			}
		}).form()){
			return false;
		}
		jQuery.ajax({
			url : 'signupPro',
			dataType : "text",
			data : {
				username:encodeURI(username),
				password:password,
				email:email,
				mobile:mobile,
				qq:qq,
				wechat:encodeURI(wechat),
				country:encodeURI(country),
				city:encodeURI(city),
				age:age,
				sex:sex,
				job:encodeURI(job)
			},
			success : function(data) {
				if(data=="dupusername"){
					document.getElementById("dupname").innerHTML=
						"用户已存在";
					return;
				}
				else if(data=="dupemail"){
					document.getElementById("dupname").innerHTML=
						"邮箱已被注册";
					return;
				}
				else{
					var addr = "https://mail." + email.split("@")[1];
					bootbox.alert({
						message : '我们发了一封激活用的邮件到你的邮箱，请接收',
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
		if(!$("#passwordform").validate({
			messages:{
			oldpassword:{
				required:"请输入你的旧密码。"
			},
			newpassword:{
				required:"请输入你的新密码。"
			},
			confirmpassword:{
				required:"请再次输入密码确认。",
				equalTo:"输入的密码与新密码不同。"
			},
			
		}
		}).form()){
			return false;
		}
		
		jQuery.ajax({
			url : 'updatePasswordPro',
			processData : true,
			dataType : "text",
			data : {
				id : id,
				oldpassword : oldpassword,
				password : newpassword
			},
			success : function(data) {
				console.log(id);
				if(data=="false"){
					bootbox.alert({
						message : '原密码输入错误',
					});
				}
				else{
				bootbox.alert({
					message : '修改成功！ ',
					callback : function() {
						location.href='loginPage';
					}
				});
			}
			}
			
		});
	});

	$("#save").click(function(e) {
		var sex = $("#form-sex").val();
		var mobile = $("input[name='mobile']").val();
		var country = $("input[name='country']").val();
		var city = $("input[name='city']").val();
		var age = $("input[name='age']").val();
		var job = $("input[name='job']").val();
		var qq = $("input[name='qq']").val();
		var wechat = $("input[name='wechat']").val();
		console.log(sex, mobile, country, city,  age, job, wechat, qq);

		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		if(!$("#infoform").validate({
		messages:{
			qq:{
				digits:"请输入一个正确的QQ号"
			},
			age:{
				digits:"请输入整数。",
				min:"请输入一个非负整数"
			}
		}
		}).form()){
			return false;
		}
		if(mobile!="" && !isPhoneNo(mobile)){
			return false;
		}
		if (id != "") { // Edit
			jQuery.ajax({
				url : 'updateUser',
				processData : true,
				dataType : "text",
				data : {
					id : id,
					sex : sex,
					mobile : mobile,
					country : country,
					city : city,
					age : age,
					job : job,
					wechat : wechat,
					qq : qq
				},
				success : function(data) {
					console.log(id);
					bootbox.alert({
						message : '修改成功！ ',
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
						message : '添加成功 ',
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

		$("#form-sex").val(dataset.sex);
		if(dataset.mobile=="0")$("input[name='mobile']").val();
		else $("input[name='mobile']").val(dataset.mobile);
		$("input[name='country']").val(dataset.country);
		$("input[name='city']").val(dataset.city);
		if(dataset.age=="0")$("input[name='age']").val();
		else $("input[name='age']").val(dataset.age);
		$("input[name='job']").val(dataset.job);
		$("input[name='qq']").val(dataset.qq);
		$("input[name='wechat']").val(dataset.wechat);

		$("#save").attr("data-id", dataset.id);
		$('#modal').modal('show');
	});

	
	$(".modifypw").click(function(e){
		$('#modalTitle2').html("修改密码");
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		console.log(id);
		
		$("input[name='oldpassword']").val("");
		$("input[name='newpassword']").val("");
		
		$("#modify").attr("data-id", dataset.id);
		$('#modal2').modal('show');
	});

});
function isPhoneNo(phone) { 
	var pattern = /^1[34578]\d{9}$/; 
	return pattern.test(phone)||(phone==""); 
}
function changephonechecker(){
	if(!isPhoneNo($("input[name='mobile']").val())){
		$("#phonechecker").html("<label style='color:#de615e;font-family:Helvetica Neue,Helvetica,Arial,sans-serif;font-size:14px;'>请输入一个正确的11位手机号码</label>");
	}
	else{
		$("#phonechecker").html("");
	}
}