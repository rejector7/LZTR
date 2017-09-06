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
					<h1 class="page-header">问卷
					<button class="btn btn-default backup" type="button"
												data-id="0"
												>
												<i class="fa fa-copy"></i>全部备份
												</button>
					</h1>
					
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
										    <th>问卷ID</th>
											<th>用户ID</th>
											<th>标题</th>
											<th>是否公开</th>
											<th  width="10%">发布时间</th>
											<th width="10%">结束时间</th>
											<th width="10%">发布状态</th>
											<th>操作</th>
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
											<%if(ques.getIsPublic()==1){%>
											<td>公开</td>
											<%}else{%>
											<td>私密</td>
											<%}%>
											<td><%=ques.getReleaseTime()%></td>
											<td><%=ques.getEndTime()%></td>
											<%if(ques.getStatus().equals("pub")){%>
											<td><%="已发布"%></td>
											<%}else if(ques.getStatus().equals("end")){%>
											<td><%="已结束"%></td>
											<%}else if(ques.getStatus().equals("ban")){%>
											<td><%="禁用"%></td>
											<%}else if(ques.getStatus().equals("unp")){%>
											<td><%="未发布"%></td>
											<%}%>
											
											<td>
												<!-- data-id what are they？ -->
												<button class="btn btn-default delete" type="button"
													data-id="<%=ques.getId()%>">
													<i class="fa fa-trash"></i>删除
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
													<i class="fa fa-edit"></i>编辑
												</button>
												<button class="btn btn-default backup" type="button"
												data-id="<%=ques.getId() %>"
												>
												<i class="fa fa-copy"></i>备份
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
	<form action="<%=path %>/backupimport" method="post" enctype="multipart/form-data" id="uploadtxt">
			<input type="file" name="file" id="file">
			<input type="submit" value="导入">
			<div id="uploadalert"></div>
	</form>
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
									<label>Status</label>
									<select class="form-control" id="selectf" name = "status">
										<option>未发布</option>
										<option>已发布</option>
										<option>已结束</option>
										<option>禁用</option>
									</select>
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
	<script src="<%=path%>/questionnaire/js/download.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaireExport.js"></script>
	<script src="<%=path%>/questionnaire/js/admin_ques.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaireExport.js"></script>

	<script>
		$(document).ready(function() {
			$('#dataTables').DataTable({
				responsive : true
			});
		});
	</script>

</body>

</html>