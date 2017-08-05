<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="model.Questionnaire"%>
<%
	String path=request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create your new Questionnaire!</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=path %>/questionnaire/css/bootstrap3.3.7.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="<%=path %>/questionnaire/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<%=path %>/questionnaire/css/justified-nav.css" rel="stylesheet">
    
    <link href="<%=path %>/questionnaire/css/font-awesome.min.css" rel="stylesheet">
	 <link href="<%=path %>/questionnaire/css/jquery-ui.min.css" rel="stylesheet">
	 <style>
	 .portlet-placeholder {
    	border: 1px dotted black;
    	margin: 0 1em 1em 0;
    	height: 50px;
  	 }
	 </style>
  </head>

  <body value="0">
	
    <div class="container">

      <!-- The justified navigation menu is meant for single line per list item.
           Multiple lines will require custom code not provided by Bootstrap. -->
      <div class="masthead">
        <h1 class="text-muted">LZTR 问卷网 </h1>
        <nav>
          <ul class="nav nav-justified">
            <li><a href="<%=path %>/FrontPage">首页</a></li>
            <li><a href="<%=path %>/SelfInfo">个人信息</a></li>
            <li><a href="">我的问卷</a></li>
            <li class="active"><a href="<%=path %>/ReleaseQuestionnaire">问卷发布</a></li>
            <li><a href="<%=path %>/FillQuestionnaire">填写问卷</a></li>
            <li><a href="<%=path %>/HelpContact">帮助</a></li>
            <li><a href="<%=path %>/logoutPro">登出</a></li>
            <%if(((String)session.getAttribute("role")).equals("admin")){%>
				<li><a href="<%=path %>/allUser" ><i class="fa fa-table fa-fw"></i>系统信息管理</a></li>
			<%}%>
          </ul>
        </nav>
      </div>
      
      
		<button class="btn btn-default addBlank" type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">Blank-filling Question</i>
		</button>
		<button class="btn btn-default addSingle"  type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">Single Option Question</i>
		</button>
		<button class="btn btn-default addMultiple"  type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">Multiple Option Question</i>
		</button>
		<button class="btn btn-default addSlider"  type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">Slider Question</i>
		</button>
		
		<div class="row pre-scrollable">
			 <label ><font size="5">Title</font></label>
			 <input type="text" name="title"  class="form-control">
		</div>
		<div class="row">
			 <label  ><font size="5">Introduction</font></label>
			 <input type="text" name="introduction"  class="form-control">
		</div>
		
		<button class="btn btn-default submit" type="button" style="floating:right">
				<i class="fa fa-check fa-2x">confirm</i>
		</button>
		<button class="btn btn-default cancel" type="button" style="floating:right">
				<i class="fa fa-check fa-2x">cancel</i>
		</button>
		<button class="btn btn-default publish" type="button" style="floating:right">
				<i class="fa fa-check fa-2x">
				<%if(request.getAttribute("quesinfo")!=null){%>
				republish now
				<%} else{%>
				publish now<%} %></i>
		</button>
    </div> <!-- /container -->
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
						<form id="form2">
							<div class="form-group">
								<label>IsPublic</label>
								<select class="form-control" id="selectf1" name = "ispublic">
										<option>yes</option>
										<option>no</option>
								</select>
								</div>
								<div class="form-group">
									<label>Release Time</label>
									<input class="form-control" name="releasetime" type="date" oninput="statechanger()" required>
									<p id="starta"></p>
								</div>
								<div class="form-group">
									<label>End Time(You can leave this blank blank if you didn't decide when to close)</label>
									<input class="form-control" name="endtime" type="date" oninput="statechanger()">
									<p id="enda"></p>
								</div>
								<div class="form-group">
									<label>State:</label>
									<p id="state">pub</p>
								</div>
						</form>
						</div></div></div>
						<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
					<button type="button" class="btn btn-primary" id="publishconfirm">confirm</button>
				</div>
			</div>
		</div>
    <script src="questionnaire/js/jquery-1.11.1.min.js"></script>
    <script src="questionnaire/js/jquery-ui.min.js"></script>
    <script src="questionnaire/js/bootstrap.min.js"></script>
    <script src="questionnaire/js/bootbox.min.js"></script>
	<script src="questionnaire/js/releaseQ.js"></script>
	<script>
	<%if(request.getAttribute("quesinfo")!=null){%>
	update(<%=((Questionnaire)request.getAttribute("quesinfo")).getId() %>);
	<%}%>
	</script>

  </body>
</html>
