<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Questionnaire"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
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
		ArrayList<Questionnaire> quesList = new ArrayList<Questionnaire>();
	/*where is the questionnaires from??? */
			if (request.getAttribute("Questionnaires") != null) {
		quesList = (ArrayList<Questionnaire>) request.getAttribute("Questionnaires");
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
				<!-- href ??? -->
					<li><a href="allUser"><i class="fa fa-user fa-fw"></i>
							用户管理</a></li>
					<li><a href="#" class="active"><i
							class="fa fa-book fa-fw"></i> 问卷管理</a></li>
					<li><a href="FrontPage"><i 
							class="fa fa-university fa-fw"></i> 首页</a></li>
					<li><a href="logoutPro"><i 
							class="fa fa-power-off fa-fw"></i> 登出</a></li>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side -->
		</nav>

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">问卷</h1>
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
											<th>User ID</th>
											<th>Title</th>
											<th>IsPublic</th>
											<th>Release Time</th>
											<th>End Time</th>
											<th>Status</th>
											<th>Operation</th>
										</tr>
									</thead>
									<tbody>
										<%
											for (int i = 0; i < quesList.size(); i++) {
																				Questionnaire ques = quesList.get(i);
										%>
										<tr>
										    <td><%=ques.getId()%></td>
											<td><%=ques.getUserid()%></td>
											<td><%=ques.getTitle()%></td>
											<td><%=ques.getIsPublic()%></td>
											<td><%=ques.getReleaseTime()%></td>
											<td><%=ques.getEndTime()%></td>
											<td><%=ques.getStatus()%></td>
											
											<td>
												<!-- data-id what are they？ -->
												<button class="btn btn-default delete" type="button"
													data-id="<%=ques.getId()%>">
													<i class="fa fa-trash"></i>
												</button>
												<button class="btn btn-default edit" type="button"
													data-id="<%=ques.getId()%>"
													data-title="<%=ques.getTitle()%>"
													data-userid="<%=ques.getUserid()%>"
													data-isPublic="<%=ques.getIsPublic()%>"
													data-releaseTime="<%=ques.getReleaseTime()%>"
													data-endTime="<%=ques.getEndTime()%>"
													data-status="<%=ques.getStatus()%>"
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
							<form role="form">
								<div class="form-group">
									<label>Status 说明：</label>
									<p>unp ： 未发布；  pub ： 已发布</p>
									<p>end ： 已结束；  ban ： 禁用</p>
									<select class="form-control" id="selectf" name = "status">
										<option>unp</option>
										<option>pub</option>
										<option>end</option>
										<option>ban</option>
									</select>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="save">Save</button>
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

	<script src="<%=path%>/questionnaire/js/admin_ques.js"></script>
	

	<script>
		$(document).ready(function() {
			$('#dataTables').DataTable({
				responsive : true
			});
		});
	</script>

</body>

</html>