/**
 * 
 */
$(function() {

	$("#save").click(function(e) {
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		var username = $("input[name='username']").val();
		var email = $("input[name='email']").val();
		var mobile = $("input[name='mobile']").val();
		var country = $("input[name='country']").val();
		var city = $("input[name='city']").val();
		var qq = $("input[name='qq']").val();
		var wechat = $("input[name='wechat']").val();
		var sex = $("input[name='sex']").val();
		var age = $("input[name='age']").val();
		var role = $("#role").val();
		/*var status = $("#selectf").val();*/
		
		console.log(id,username,age,sex,city,country,email,qq,wechat,role);

		jQuery.ajax({
			url : 'updateUser',
			processData : true,
			dataType : "text",
			data : {
				        id 	: id,
				        username : username,
				        age:age,
				        sex:sex,
				        city:city,
				        country:country,
				        email:email,
				        mobile:mobile,
				        qq:qq,
				        wechat:wechat,
				        role:role
			},
			success : function(data) {
				console.log(id);
				bootbox.alert({
					message : 'Change successfully!',
					callback : function() {
						location.reload();
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
					label : 'Delete'
				},
				cancel : {
					label : 'Cancel'
				}
			},
			message : 'Sure to delete?',
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
							console.log(id);
							bootbox.alert({
								message : 'Delete Successfully! ',
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
		$("input[name='username']").val(dataset.username);
		$("input[name='email']").val(dataset.age);
		$("input[name='mobile']").val(dataset.mobile);
		$("input[name='country']").val(dataset.country);
		$("input[name='city']").val(dataset.city);
		$("input[name='qq']").val(dataset.qq);
		$("input[name='wechat']").val(dataset.wechat);
		$("input[name='sex']").val(dataset.sex);
		$("input[name='age']").val(dataset.age);
		$("#role"),val(dataset.role);

		/*$("select[name='status']").val(dataset.status);*/

		$("#save").attr("data-id", dataset.id);
		$('#modal').modal('show');
	});

});
