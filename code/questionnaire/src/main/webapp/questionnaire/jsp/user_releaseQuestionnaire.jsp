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
            <li><a href="<%=path %>/allSendMessage">消息</a></li>
            <li><a href="<%=path %>/HelpContact">帮助</a></li>
            
            <li><a href="<%=path %>/logoutPro">登出</a></li>
            <%if(((String)session.getAttribute("role")).equals("admin")){%>
				<li><a href="<%=path %>/allUser" ></i>系统信息管理</a></li>
			<%}%>
          </ul>
        </nav>
      </div>
      
      
		<button class="btn btn-default addBlank" type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">填空题</i>
		</button>
		<button class="btn btn-default addSingle"  type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">单选题</i>
		</button>
		<button class="btn btn-default addMultiple"  type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">多选题</i>
		</button>
		<button class="btn btn-default addSlider"  type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">滑块题</i>
		</button>
		
		<div class="row pre-scrollable">
			 <label ><font size="5">标题</font></label>
			 <input type="text" name="title"  class="form-control">
		</div>
		<div class="row">
			 <label  ><font size="5">简介</font></label>
			 <input type="text" name="introduction"  class="form-control">
		</div>
		<div class="row">
			 <input type="checkbox" id="allowDup" checked>
			 <label ><font size="5">是否允许同一IP重复作答?</font></label>
		</div>
		<button class="btn btn-default submit" type="button" style="floating:right">
				保存</i>
		</button>
		<button class="btn btn-default cancel" type="button" style="floating:right">
				取消</i>
		</button>
		<button class="btn btn-default preview" type="button" style="floating:right">
				预览</i>
		</button>
		<button class="btn btn-default publish" type="button" style="floating:right">
				
				<%if(request.getAttribute("quesinfo")!=null){%>
				重发布
				<%} else{%>
				发布<%} %></i>
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
								<label>是否公开</label>
								<select class="form-control" id="selectf1" name = "ispublic">
										<option>是</option>
										<option>否</option>
								</select>
								</div>
								<div class="form-group">
									<label>发布时间</label>
									<input class="form-control" name="releasetime" type="date" oninput="statechanger()" required>
									<p id="starta"></p>
								</div>
								<div class="form-group">
									<label>结束时间（若不设定可不填写）</label>
									<input class="form-control" name="endtime" type="date" oninput="statechanger()">
									<p id="enda"></p>
								</div>
								<div class="form-group">
									<label>当前状态:</label>
									<p id="state">已发布</p>
								</div>
						</form>
						</div></div></div>
						<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="publishconfirm">确认</button>
				</div>
			</div>
		</div>
	</div>
	 <div class="modal fade" id="modal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" id="relacloser">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="modalTitle"></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
						<form id="form3">
							<div class="form-group">
								<label>选择想要关联的问题</label>
								<select class="form-control" id="formerques" onchange="releopts()">
										
								</select>
							</div>
							<label>当以下选项被选中时</label>
							<div class="form-group" id="specoptiondiv">
								
							</div>
							<label>本问题会出现</label>
							<label>将本关联复制到后续问题</label>
							<div class="form-group" id="laterques">
								
							</div>
						</form>
						</div></div></div>
						<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="relatconfirm">确认</button>
				</div>
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
