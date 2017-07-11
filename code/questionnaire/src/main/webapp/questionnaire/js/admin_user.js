/**
 * 
 */
$(function() {

	$("#save").click(function(e) {
		var dataset = e.currentTarget.dataset;
		var id = dataset.id;
		var username=dataset.username;
		var age=dataset.age;
		var sex=dataset.sex;
		var city=dataset.city;
		var country=dataset.country;
		var email=dataset.email;
		var mobile=dataset.mobile;
		var qq=dataset.qq;
		var wechat=dataset.wechat;
		var role=dataset.role;
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
		var id = dataset.id;
		var username=dataset.username;
		var age=dataset.age;
		var sex=dataset.sex;
		var city=dataset.city;
		var country=dataset.country;
		var email=dataset.email;
		var mobile=dataset.mobile;
		var qq=dataset.qq;
		var wechat=dataset.wechat;
		var role=dataset.role;
		console.log(id,username,age,sex,city,country,email,qq,wechat,role);

		/*$("select[name='status']").val(dataset.status);*/

		$("#save").attr("data-id", dataset.id);
		$('#modal').modal('show');
	});

});
