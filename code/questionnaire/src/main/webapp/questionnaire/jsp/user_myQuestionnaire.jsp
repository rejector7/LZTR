<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Questionnaire"%>
<%@ page import="model.User"%>
<!DOCTYPE html>
<%
	String path=request.getContextPath();
%>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
	<meta charset="utf-8" />
        <title>LZTR 问卷网</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=path %>/questionnaire/css/bootstrap3.3.7.min.css" rel="stylesheet">


        <link href="<%=path %>/questionnaire/css/font-awesome.min.css" rel="stylesheet">


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <style type="text/css">
        html, body {width:100%;height:100%;}
        .bg {display: table;width: 100%;height: 10%;padding: 20px 0;text-align: center;color: #fff;background: url(questionnaire/img/homepage.jpg) no-repeat bottom center;background-color: #000;background-size: cover;}
        .my-navbar {padding:20px 0;transition: background 0.5s ease-in-out, padding 0.5s ease-in-out;}
        .my-navbar a{background:transparent !important;color:#fff !important}
        .my-navbar a:hover {color:#45bcf9 !important;background:transparent;outline:0}
        .my-navbar a {transition: color 0.5s ease-in-out;}
        .top-nav {padding:0;background:#000;}
        button.navbar-toggle {background-color:#fbfbfb;}
        button.navbar-toggle > span.icon-bar {background-color:#dedede}
        .dropdown-nemu>li>a{color:#333!important;display:block!important;}
        
		.mydiv{
		width:250px;height:auto;border:#909090 1px solid;background:#fff;color:#333;
		filter:progid:DXImageTransform.Microsoft.Shadow(color=#909090,direction=120,strength=3);
		-moz-box-shadow: 2px 2px 10px #909090;
		-webkit-box-shadow: 2px 2px 10px #909090;
		box-shadow:2px 2px 10px #909090;

		}
    </style>
</head>
<body style="background:
#F5F5F5">
<% 
User user = (User) session.getAttribute("user");
%>
    <nav class="navbar navbar-fixed-top my-navbar" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="FrontPage"><font size=5>LZTR 问卷网</font></a>
            </div>
            <div class="collapse navbar-collapse" id="example-navbar-collapse">
                <ul class="nav navbar-nav">
				<% response.setCharacterEncoding("UTF-8"); 
					if(session.getAttribute("user")!=null){ %>
				
				<% String role = user.getRole();
				if(role.equals("admin")){ System.out.println("1111");%>
				<li><a class="navbar-brand" href="<%=path %>/allUser"><span class="glyphicon glyphicon-wrench">系统信息管理</span></a></li>
				<%} }%>
                </ul>
                
                     <form class="navbar-form navbar-right" role="search" action="searchPro" accept-charset="UTF-8">
              			<div class="form-group">
                			<input type="text" class="form-control" name="key" placeholder="搜索问卷名称......">
                			<button type="submit" class="btn btn-default-lg">搜索</button>
                		</div>
              		</form>
                
              <ul class="nav navbar-nav navbar-right">
              <% 
              if(user==null){ %>
              <li data-toggle="modal" data-target="#signin-signup-tab" id="signin-button"><a href="loginPage" class="navbar-brand" >登陆</a></li>
              <li data-toggle="modal" data-target="#signin-signup-tab" id="signup-button"><a href="signupPage" class="navbar-brand" >注册</a></li>
              <li data-toggle="modal" data-target="#signin-signup-tab" id="signup-button"><a href="<%=path %>/HelpContact" class="navbar-brand" >帮助</a></li>
              <%}else{ %>
              	<li><a class="navbar-brand" href="<%=path %>/MyQuestionnaire"><span class="glyphicon glyphicon-list">我的问卷</span></a></li>
              
            	<li class="dropdown">
                <a href="#" class="dropdown-toggle navbar-brand" data-toggle="dropdown" role="button" aria-expanded="false">
                    <span class="glyphicon glyphicon-user"><%=((User)session.getAttribute("user")).getUsername()%></span>
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu" style="background:#333!important" role="menu" >
                	<li><a href="<%=path %>/SelfInfo">个人信息</a></li>
					<li><a href="<%=path %>/allSendMessage">我的消息</a></li>
					<li role="presentation" class="divider"></li>
					<li><a href="<%=path %>/HelpContact">帮助</a></li>
                </ul>
            	</li>
            	
               <li data-toggle="modal" data-target="#signin-signup-tab" id="signin-button"><a href="logoutPro" class="navbar-brand" >登出</a></li>
               <%} %>
              </ul>
            </div>
            

        </div>
    </nav>

 <div class="bg jumbotron">
      </div>
      <div class="container">
       	<div class="row" style="float:left"><font size=5><strong>我的问卷管理</strong></font></div>
       	  <a class="btn btn-success addMultiple"  href="<%=path %>/ReleaseQuestionnaire" type="button" align="right" style="float:right;">
				<i class="fa fa-plus">新建问卷</i> 
		</a>
 	<hr>
<hr style="color:black;border-top:1px solid #C0C0C0" >

      <%
		ArrayList<Questionnaire> myQuesList = new ArrayList<Questionnaire>();
			if (request.getAttribute("MyQuess") != null) {
		myQuesList = (ArrayList<Questionnaire>) request.getAttribute("MyQuess");
			}
	  %>
	  
	  
	  <div id="page-wrapper page-left">
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
										    <th width="6%">序号</th>
											<th>题目</th>
											<th>是否公开</th>
											<th>发布时间</th>
											<th>截止时间</th>
											<th width="8%">状态</th>
											<th></th>
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
													<i class="fa fa-trash"></i>删除&nbsp
												</button>
												<button class="btn btn-default edit" type="button"
												<%if(ques.getStatus().equals("ban")){%> disabled<%} %> 
													data-id="<%=ques.getId()%>"
													data-title="<%=ques.getTitle()%>"
													data-userid="<%=ques.getUserid()%>"
													data-ispublic="<%=ques.getIsPublic()%>"
													data-releasetime="<%=ques.getReleaseTime()%>"
													data-endtime="<%=ques.getEndTime()%>"
													data-status="<%=ques.getStatus()%>"
													>
													<i class="fa fa-cog"></i>发布状态&nbsp
												</button>
												<a class="btn btn-default" href="getInfoQuestionnaire?id=<%=ques.getId() %>" role="button"><i class="fa fa-edit"></i>修改内容</a>
												<br>
												<a class="btn btn-default" href="PreviewQuestionnaire?quesid=<%=ques.getId() %>" role="button"><i class="fa fa-eye"></i>预览</a>

												<a class="btn btn-default" href="getAnswerByQuesid?quesid=<%=ques.getId() %>" role="button"><i class="fa fa-bar-chart"></i>查看数据</a>

												<button class="btn btn-default link" type="button" value="localhost:8080/questionnaire/FillQuestionnaire?quesid=<%=ques.getId() %>"><i class="fa fa-copy"></i>复制链接</button>
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
							<form role="form" id="form"> 
								<div class="form-group">
									<label>标题</label>
									<input class="form-control" name="title">
								</div>
								<p id="titlea"></p>
								<div class="form-group">
									<label>是否公开</label>
									<select class="form-control" id="selectf1" name = "ispublic">
										<option selected>是</option>
										<option>否</option>
									</select>
								</div>
								<div class="form-group">
									<label>发布时间</label>
									<input class="form-control" name="releasetime" type="date"  oninput="statechanger()" required>
									<p id="starta"></p>
								</div>
								<div class="form-group">
									<label>结束时间（若不设定可不填写）</label>
									<input class="form-control" name="endtime" type="date" oninput="statechanger()">
									<p id="enda"></p>
								</div>
								<div class="form-group">
									<label>状态 说明：</label>
									<p id="state">已发布</p>
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
    
	  
	  
	  
<hr style="color:black;border-top:1px solid #C0C0C0">
      <!-- Site footer -->
      <footer class="footer">
        <p>&copy; 2017 LZTR Group.</p>
      </footer>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="<%=path %>/questionnaire/js/ie10-viewport-bug-workaround.js"></script>
            <script>
        $(window).scroll(function () {
            if ($(".navbar").offset().top > 50) {$(".navbar-fixed-top").addClass("top-nav");
            }else {$(".navbar-fixed-top").removeClass("top-nav");}
        })
        </script>
  </body>
</html>