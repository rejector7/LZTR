$(function() {
	$("#form").validate({
		messages:{
			username:{
				required:"用户名必填"
			},
			age:{
				min:"请输入一个不小于0的整数",
				digits:"请输入整数"
			},
			email:{
				required:"邮箱必填",
				email:"请输入一个有效的邮箱"
			},
			mobile:{
				required:"手机号码必填"
			},
			qq:{
				min:"请输入一个QQ账号",
				digits:"请输入一个QQ账号"
			}
		}
	});
	$("#save").click(function(e) {
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
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
		var role = $("#form-role").val();
		if(role=="管理员"){role="admin";}
		else if(role=="用户"){role="user";}
		if(!$("#form").validate({
			messages:{
				username:{
					required:"用户名必填"
				},
				age:{
					min:"请输入一个不小于0的整数",
					digits:"请输入整数。"
				},
				email:{
					required:"邮箱必填",
					email:"请输入一个有效的邮箱"
				},
				mobile:{
					required:"手机号码必填"
				},
				qq:{
					min:"请输入一个QQ账号",
					digits:"请输入一个QQ账号"
				}
			}
		}).form()){
			return false;
		}
		if(mobile!="" && !isPhoneNo(mobile)){
			return false;
		}
		jQuery.ajax({
			url : 'updateUser',
			processData : true,
			dataType : "text",
			data : {
				        id 	: id,
				        username : encodeURI(username),
				        password:password,
				        age:age,
				        sex:sex,
				        city:encodeURI(city),
				        country:encodeURI(country),
				        email:email,
				        mobile:mobile,
				        qq:qq,
				        wechat:encodeURI(wechat),
				        job:encodeURI(job),
				        role:role
			},
			success : function(data) {
				bootbox.alert({
					message : '修改成功!',
					callback : function() {
						location.href="allUser";
					}
				});
			}
		});
		$('#modal').modal('hide');
	});
	$(".delete").click(function(e) {
		bootbox.confirm({
			buttons : {
				confirm : {
					label : '删除'
				},
				cancel : {
					label : '取消'
				}
			},
			message : '是否删除?',
			callback : function(result) {
				if (result) {

					var dataset = e.currentTarget.dataset;
					var id = dataset.id;
					jQuery.ajax({
						url : 'deleteUser',
						processData : true,
						dataType : "text",
						data : {
							id : id
						},
						success : function(data) {
							bootbox.alert({
								message : '删除成功! ',
								callback : function() {
									location.reload();
								}
							});
						}
					});
				}
			}
		});
	});
	$(".edit").click(function(e) {
		$('#modalTitle').html("修改用户信息");
		var dataset = e.currentTarget.dataset;
		$("#form-id").html(dataset.id);
		$("input[name='username']").val(dataset.username);
		$("input[name='password']").val(dataset.password);
		$("input[name='email']").val(dataset.email);
		$("input[name='mobile']").val(dataset.mobile);
		$("input[name='country']").val(dataset.country);
		$("input[name='city']").val(dataset.city);
		$("input[name='qq']").val(dataset.qq);
		$("input[name='wechat']").val(dataset.wechat);
		$("input[name='job']").val(dataset.job);
		$("#form-sex").val(dataset.sex);
		if(dataset.age=="0")$("input[name='age']").val();
		else $("input[name='age']").val(dataset.age);
		if(dataset.role=="user")
		{$("#form-role").val("用户");}
		else if(dataset.role=="admin")
		{$("#form-role").val("管理员");}
		$("#save").attr("data-id", dataset.id);
		$('#modal').modal('show');
	});
});
function isPhoneNo(phone) { 
	var pattern = /^1[34578]\d{9}$/; 
	return pattern.test(phone)||(phone==""); 
}
function changephonechecker(){
	if(!isPhoneNo($("input[name='mobile']").val())){
		$("#phonechecker").html("<label >请输入一个正确的手机号码</label>");
	}
	else{
		$("#phonechecker").html("");
	}
}