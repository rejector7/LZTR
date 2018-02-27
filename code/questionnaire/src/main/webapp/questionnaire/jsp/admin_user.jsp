<%@ page import="java.util.ArrayList"%>
<%@ page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html >
<head>
<title>LZTR 问卷平台后台管理</title>
<%
	String path = request.getContextPath();
%>
<link href="<%=path%>/questionnaire/css/bootstrap.min.css" 			rel="stylesheet">
<link href="<%=path%>/questionnaire/css/dataTables.bootstrap.css" 	rel="stylesheet">
<link href="<%=path%>/questionnaire/css/dataTables.responsive.css" 	rel="stylesheet">
<link href="<%=path%>/questionnaire/css/questionnaire.css" 			rel="stylesheet">
<link href="<%=path%>/questionnaire/css/font-awesome.min.css" 		rel="stylesheet" type="text/css">
</head>
<body>
	<%
		ArrayList<User> userList = new ArrayList<User>();
		if (request.getAttribute("Users") != null) {
			userList = (ArrayList<User>) request.getAttribute("Users");
		}
	%>
	<div id="wrapper">
		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">问卷系统后台</a>
		</div>
		<div class="navbar-default sidebar" role="navigation">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">
					<li><a href="#" class="active"><i 
							class="fa fa-user fa-fw"></i> 用户管理</a></li>
					<li><a href="allQuestionnaire"><i
							class="fa fa-book fa-fw"></i> 问卷管理</a></li>
					<li><a href="FrontPage"><i 
							class="fa fa-university fa-fw"></i> 首页</a></li>
					<li><a href="logoutPro"><i 
							class="fa fa-power-off fa-fw"></i> 登出</a></li>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side --> </nav>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">用户</h1>
				</div>
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<!-- /.panel-heading -->
						<div class="panel-body">
							<div class="dataTable_wrapper">
								<table class="table table-striped table-bordered table-hover"
									id="dataTables">
									<thead>
										<tr>
										    <th>ID</th>
											<th>用户名</th>
											<th>密码</th>
											<th>年龄</th>
											<th>性别</th>
											<th>城市</th>
											<th>国家</th>
											<th>邮箱</th>
											<th>手机号</th>
											<th>QQ</th>
											<th>微信</th>
											<th>职业</th>
											<th>身份</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<%
											for (int i = 0; i < userList.size(); i++) {
																				User user = userList.get(i);
										%>
										<tr>
										    <td><%=user.getId()%></td>
											<td><%=user.getUsername()%></td>
											<td style="word-wrap:break-word;word-break:break-all" width="100px"><%=user.getPassword() %></td>
											<td><%=user.getAge()%></td>
											<td><%if(user.getSex().equals("male")){%>男<%}else if (user.getSex().equals("female")){%>女<%} %></td>
											<td><%=user.getCity()%></td>
											<td><%=user.getCountry()%></td>
											<td><%=user.getEmail()%></td>
											<td><%=user.getMobile()%></td>
											<td><%=user.getQq()%></td>
											<td><%=user.getWechat()%></td>
											<td><%=user.getJob()%></td>
											<td><%if(user.getRole().equals("admin")){%>管理员<%}else if (user.getRole().equals("user")){%>用户<%} %></td>
											<td>
												<button class="btn btn-default delete" type="button"
													data-id="<%=user.getId()%>">
													<i class="fa fa-trash"></i>
												</button>
												<button class="btn btn-default edit" type="button"
													data-id="<%=user.getId()%>"
													data-username="<%=user.getUsername()%>"
													data-password="<%=user.getPassword() %>"
													data-age="<%=user.getAge()%>"
													data-sex="<%=user.getSex()%>"
													data-city="<%=user.getCity()%>"
													data-country="<%=user.getCountry()%>"
													data-email="<%=user.getEmail()%>"
													data-mobile="<%=user.getMobile() %>"
													data-qq="<%=user.getQq() %>"
													data-wechat="<%=user.getWechat() %>"
													data-job="<%=user.getJob() %>"
													data-role="<%=user.getRole() %>"
													>
													<i class="fa fa-edit"></i>
												</button>
											</td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
	<div class="modal fade" id="modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="modalTitle"></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="form" role="form">
								<div class="form-group">
	  <div class="form-group">
        <label name="id">ID</label><br>
        <p id="form-id"></p>
      </div>
      <div class="form-group">
        <label>用户名</label>
        <input type="text" class="form-control" name="username" required maxlength="255">
      </div>
      <div class="form-group">
      <label>密码</label>
      <input type="text" class="form-control" name="password" required maxlength="255">
      </div>
      <div class="form-group">
        <label>年龄</label>
        <input type="number" class="form-control" name="age" required min="0" digits="true">
      </div>
      <div class="form-group">
			                        	<label  for="form-sex">性别</label>
			                        	<select  id="form-sex" name="sex" class="form-sex form-control">
											<option value="male">男</option>
											<option value="female">女</option>
										</select>
			                        </div>
      <div class="form-group">
        <label>城市</label>
        <input type="text" class="form-control"  name="city"  maxlength="255">
      </div>
      <div class="form-group">
        <label>国家</label>
        <input type="text" class="form-control" name="country" maxlength="255">
      </div>
      <div class="form-group">
        <label>Email</label>
        <input type="email" class="form-control" name="email" required maxlength="255">
      </div>
      <div class="form-group">
        <label>手机号</label>
        <input type="text" class="form-control" name="mobile" oninput="changephonechecker()" >
        <div id="phonechecker">					
		</div>
      </div>
      <div class="form-group">
        <label>QQ号</label>
        <input type="text" class="form-control" name="qq" min="10000" digits="true" maxlength="255">
      </div>
      <div class="form-group">
        <label>微信</label>
        <input type="text" class="form-control" name="wechat" maxlength="255">
      </div>
      <div class="form-group">
			                        	<label  for="form-job">职业</label>
			                        	<input type="text" name="job"  class="form-job form-control" id="form-job" maxlength="255">
			                        </div>
      <div class="form-group">
        <label>用户身份</label>
			<select class="form-control" id="form-role">
				<option>管理员</option>
				<option>用户</option>
			</select>
      </div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="save">保存</button>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=path%>/questionnaire/js/jquery.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="<%=path%>/questionnaire/js/dataTables.bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootbox.min.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaire.js"></script>
	<script src="<%=path %>/questionnaire/js/jquery.validate.min.js"></script>
    <script src="<%=path %>/questionnaire/js/messages_zh.js"></script>
    <script src="<%=path %>/questionnaire/js/md5.js"></script>
	<script src="<%=path%>/questionnaire/js/admin_user.js"></script>
	<script>
		$(document).ready(function() {
			$('#dataTables').DataTable({
				responsive : true
			});
		});
	</script>
</body>
</html>
