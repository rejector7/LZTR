<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Questionnaire"%>
<!DOCTYPE html>

<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>LZTR 问卷网</title>
	<%
	String path=request.getContextPath();
	%>
	<link href="<%=path%>/questionnaire/css/dataTables.bootstrap.css" 	rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/dataTables.responsive.css" 	rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/questionnaire.css" 			rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/font-awesome.min.css" 		rel="stylesheet" type="text/css">
    <!-- Bootstrap core CSS -->
    <link href="<%=path %>/questionnaire/css/bootstrap3.3.7.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="<%=path %>/questionnaire/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<%=path %>/questionnaire/css/justified-nav.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="<%=path %>/questionnaire/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="container">

      <!-- The justified navigation menu is meant for single line per list item.
           Multiple lines will require custom code not provided by Bootstrap. -->
      <div class="masthead">
        <h1 class="text-muted">LZTR 问卷网 </h1>
        <nav>
          <ul class="nav nav-justified">
            <li><a href="<%=path %>/FrontPage">首页</a></li>
            <li><a href="<%=path %>/SelfInfo">个人信息</a></li>
            <li class="active"><a href="">我的问卷</a></li>
            <li><a href="<%=path %>/ReleaseQuestionnaire">问卷发布</a></li>
            <li><a href="<%=path %>/FillQuestionnaire">填写问卷</a></li>
            <li><a href="<%=path %>/HelpContact">帮助</a></li>
            <li><a href="<%=path %>/logoutPro">登出</a></li>
            <%if(((String)session.getAttribute("role")).equals("admin")){%>
				<li><a href="<%=path %>/allUser" ><i class="fa fa-table fa-fw"></i>系统信息管理</a></li>
			<%}%>
          </ul>
        </nav>
      </div>

      <%
		ArrayList<Questionnaire> myQuesList = new ArrayList<Questionnaire>();
			if (request.getAttribute("MyQuess") != null) {
		myQuesList = (ArrayList<Questionnaire>) request.getAttribute("MyQuess");
			}
	  %>
	  
	  <div id="page-wrapper page-left">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">我的问卷</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<a class="btn btn-lg btn-success" href="<%=path %>/ReleaseQuestionnaire" role="button"><i class="fa fa-plus-square-o"></i>  新建问卷</a>
				</div>
			</div>
			</br>
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
											for (int i = 0; i < myQuesList.size(); i++) {
																				Questionnaire ques = myQuesList.get(i);
										%>
										<tr>
										    <td><%=ques.getId()%></td>
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
													data-ispublic="<%=ques.getIsPublic()%>"
													data-releasetime="<%=ques.getReleaseTime()%>"
													data-endtime="<%=ques.getEndTime()%>"
													data-status="<%=ques.getStatus()%>"
													>
													<i class="fa fa-cog"></i>
												</button>
												<a class="btn btn-default" href="getInfoQuestionnaire?id=<%=ques.getId() %>" role="button"><i class="fa fa-edit"></i> edit content</a>

												<a class="btn btn-default" href="getAnswerByQuesid?quesid=<%=ques.getId() %>" role="button"><i class="fa fa-bar-chart"></i> view result</a>

												<a class="btn btn-default" href="#" role="button"><i class="fa fa-bar-chart"></i> view result</a>
												<a class="btn btn-default" href="PreviewQuestionnaire?quesid=<%=ques.getId() %>" role="button">preview</a>

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
									<label>Title</label>
									<input class="form-control" name="title">
								</div>
								<div class="form-group">
									<label>IsPublic</label>
									<select class="form-control" id="selectf1" name = "inpublic">
										<option>1</option>
										<option>0</option>
									</select>
								</div>
								<div class="form-group">
									<label>Release Time</label>
									<input class="form-control" name="releasetime" type="date">
								</div>
								<div class="form-group">
									<label>End Time</label>
									<input class="form-control" name="endtime" type="date">
								</div>
								<div class="form-group">
									<label>Status 说明：</label>
									<p>unp ： 未发布；  pub ： 已发布</p>
									<p>end ： 已结束；  ban ： 禁用</p>
									<select class="form-control" id="selectf2" name = "status">
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

	<script src="<%=path%>/questionnaire/js/user_ques.js"></script>
	

	<script>
		$(document).ready(function() {
			$('#dataTables').DataTable({
				responsive : true
			});
		});
	</script>
	  
	  
	  

      <!-- Site footer -->
      <footer class="footer">
        <p>&copy; 2017 LZTR Group.</p>
      </footer>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="<%=path %>/questionnaire/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>