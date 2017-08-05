<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="model.User" %>
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

    <title>LZTR 问卷网</title>
	<link href="<%=path%>/questionnaire/css/bootstrap.min.css" 			rel="stylesheet">
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
    	<script src="questionnaire/js/jquery.min.js"></script>
    	<script src="questionnaire/js/jquery.validate.min.js"></script>
    	     <link rel="stylesheet" href="questionnaire/css/validation.css">
	<script src="questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="questionnaire/js/dataTables.bootstrap.min.js"></script>
		<script src="questionnaire/js/bootstrap.min.js"></script>
		<script src="questionnaire/js/bootbox.min.js"></script>
	    <link href="questionnaire/css/font-awesome.min.css" rel="stylesheet">
	         <link rel="stylesheet" href="questionnaire/css/validation.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<% 
User user = (User) session.getAttribute("user");
%>


  <body>

    <div class="container">

      <!-- The justified navigation menu is meant for single line per list item.
           Multiple lines will require custom code not provided by Bootstrap. -->
      <div class="masthead">
        <h1 class="text-muted">LZTR 问卷网 </h1>
        <nav>
          <ul class="nav nav-justified">
            <li><a href="<%=path %>/FrontPage">首页</a></li>
            <li class="active"><a href="">个人信息</a></li>
            <li><a href="<%=path %>/MyQuestionnaire">我的问卷</a></li>
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

	<div class="row conatiner"><div class="col-lg-2"></div><div class="col-lg-8">
	<h3>Account : <%=user.getUsername()%></h3>
	<%if (user.getEmail()!="") {%> <h3>Email : <%=user.getEmail()%></h3><%}%>
	<%if (user.getSex()!="") {%> <h3>Sex : <%=user.getSex()%></h3><%}%>
	<%if (user.getMobile()!="") {%><h3>Phone : <%=user.getMobile()%></h3><%}%>
	<%if (user.getCountry()!="") {%> <h3>Country : <%=user.getCountry()%></h3><%}%>
	<%if (user.getCity()!="") {%> <h3>City : <%=user.getCity()%></h3><%}%>
	<%if (user.getJob()!="") {%> <h3>Job : <%=user.getJob()%></h3><%}%>
	<%if (user.getQq()!="") {%> <h3>QQ : <%=user.getQq()%></h3><%}%>
	<%if (user.getWechat()!="") {%> <h3>Wechat : <%=user.getWechat()%></h3><%}%>
	<%if (user.getAge()!=0) {%><h3>Age : <%=user.getAge()%></h3><%}%>
	
	
													<button class="btn btn-default edit" type="button"
													data-id="<%=user.getId()%>"
													data-sex="<%=user.getSex()%>"
													data-mobile="<%=user.getMobile()%>"
													data-country="<%=user.getCountry()%>"
													data-city="<%=user.getCity()%>"
													data-email="<%=user.getEmail()%>"
													data-age="<%=user.getAge()%>"
													data-job="<%=user.getJob()%>"
													data-qq="<%=user.getQq()%>"
													data-wechat="<%=user.getWechat()%>"
													data-password="<%=user.getPassword()%>">
													<i class="fa fa-edit">&nbspModify Property</i>
												</button>
											<button class="btn btn-default modifypw" type="button"
											data-id="<%=user.getId()%>"
											>
											<i class="fa fa-edit">&nbspModify Password</i>
											</button>	
						</div>						
</div>


      <!-- Site footer -->
      <footer class="footer">
        <p>&copy; 2017 LZTR Group.</p>
      </footer>

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
							<form role="form" id="infoform">
								<div class="form-group">
			                        	<label>Sex</label>
			                        	<select  id="form-sex" name="sex" class="form-control">
											<option value="male">Male</option>
											<option value="female">Female</option>
										</select>
			                        </div>
																<div class="form-group">
									<label>Mobile</label> <input class="form-control" mobile
										name="mobile" required id="mobile"  oninput="changephonechecker()">
								</div>
								<div id="phonechecker">
									
								</div>
																<div class="form-group">
									<label>Country</label> <input class="form-control"
										name="country">
								</div>
																<div class="form-group">
									<label>City</label> <input class="form-control"
										name="city">
								</div>
																<div class="form-group">
									<label>Age</label> <input class="form-control" min="0"
										name="age" number step="1" digits>
								</div>
																<div class="form-group">
									<label>Job</label> <input class="form-control"
										name="job">
								</div>
																								<div class="form-group">
									<label>Wechat</label> <input class="form-control"
										name="wechat">
								</div>
																								<div class="form-group">
									<label>QQ</label> <input class="form-control"
										name="qq">
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

<div class="modal fade" id="modal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="modalTitle2"></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
						<form id="passwordform">
						 <div class="form-group">
			                        	<label >旧密码</label>
			                        	<input type="password" name="oldpassword" placeholder="" class="form-control" required>
			                        </div>
			                        <div class="form-group">
			                        	<label >新密码</label>
			                        	<input type="password" name="newpassword" placeholder="" class="form-control" id="form-password" required>
			                        </div>
			                        <div class="form-group">
			                        	<label >确认新密码</label>
			                        	<input type="password" name="confirmpassword" placeholder="" class="form-control" required equalTo="#form-password">
			                        </div>
						</form>
						</div></div></div>
						<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="modify">确认</button>
				</div>
			</div>
		</div>

    	</div>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="<%=path %>/questionnaire/js/ie10-viewport-bug-workaround.js"></script>

    <script src="<%=path %>/questionnaire/js/user.js"></script>

  </body>
</html>