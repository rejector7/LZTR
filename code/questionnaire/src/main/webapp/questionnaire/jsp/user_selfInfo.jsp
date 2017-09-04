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
	<link href="<%=path%>/questionnaire/css/bootstrap.min.css" 			rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/dataTables.bootstrap.css" 	rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/dataTables.responsive.css" 	rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/questionnaire.css" 			rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/font-awesome.min.css" 		rel="stylesheet" type="text/css">
    <!-- Bootstrap core CSS -->
    <link href="<%=path %>/questionnaire/css/bootstrap3.3.7.min.css" rel="stylesheet">


    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    	<script src="questionnaire/js/jquery.min.js"></script>
    	<script src="questionnaire/js/jquery.validate.min.js"></script>
    	<script src="<%=path %>/questionnaire/js/messages_zh.js"></script>
    	     <link rel="stylesheet" href="questionnaire/css/validation.css">
	<script src="questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="questionnaire/js/dataTables.bootstrap.min.js"></script>
		<script src="questionnaire/js/bootstrap.min.js"></script>
		<script src="questionnaire/js/bootbox.min.js"></script>
	    <link href="questionnaire/css/font-awesome.min.css" rel="stylesheet">
	         <link rel="stylesheet" href="questionnaire/css/validation.css">
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
				
				<%String role = user.getRole();
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

 <div class="bg jumbotron"></div>
    <div class="container" >
    
    
    
 	<div class="row"  style="float:left"><font size=5><strong>安全信息</strong></font></div>
 												<button class="btn btn-default modifypw" type="button" style="float:right;"
											data-id="<%=user.getId()%>"
											>
											<i class="fa fa-edit">&nbsp修改密码</i>
											</button>	
    <hr> <hr style="color:black;border-top:1px solid #C0C0C0">
    <div class="container">
     <label>用户名 : <%=user.getUsername()%></label><p></p>
	 <label>邮箱 : <%=user.getEmail()%></label><br><br><br></div>
	 <div class="row" ><font size=5><strong>个性信息</strong></font></div>
     <hr style="color:black;border-top:1px solid #C0C0C0">


                        <div class="col-sm-6  form-box" style="float:none">
                            <div class="form-bottom" >
			                    <form oninput="buttonable()"  role="form" action="<%=path %>/signupPro" method="post" class="login-form" id="infoform">
			                        			                        <div class="form-group">
			                        	<label  for="form-sex">性别</label>
			                        	<select  id="form-sex" name="sex" class="form-sex" value="<%=user.getSex() %>">
											<option value="male" <%if(!user.getSex().equals("female")){%>selected="selected"<%} %>>男</option>
											<option value="female" <%if(user.getSex().equals("female")){%>selected="selected"<%} %>>女</option>
										</select>
			                        </div>
			                        <div class="form-group">
			                        	<label for="form-age" >年龄</label>
			                        	<input type="number" name="age" step="1" class="form-age " id="form-age" min="0" value="<%=user.getAge() %>" digits>
			                        </div>

			                        			                        <div class="form-group">
			                        	<label  for="form-country">国家</label>
			                        	<input type="text" name="country"  class="form-country " value="<%=user.getCountry() %>" id="form-country">
			                        </div>
			                        			                        <div class="form-group">
			                        	<label  for="form-city">城市</label>
			                        	<input type="text" name="city" class="form-city " value="<%=user.getCity() %>" id="form-city">
			                        </div>
			                        			                        <div class="form-group">
			                        	<label  for="form-mobile">电话</label>
			                        	<input type="text" name="mobile"  class="form-mobile" id="form-mobile" value="<%=user.getMobile() %>" oninput="changephonechecker()" >
			                        </div>
			                        <div id="phonechecker">
									
									</div>
			                        			                        <div class="form-group">
			                        	<label  for="form-qq">QQ&nbsp</label>
			                        	<input type="text" name="qq"  class="form-qq" id="form-qq" value="<%=user.getQq() %>"digits>
			                        </div>
			                        			                        <div class="form-group">
			                        	<label  for="form-wechat">微信</label>
			                        	<input type="text" name="wechat"  class="form-wechat " value="<%=user.getWechat() %>" id="form-wechat">
			                        </div>
			                        			                        			                        <div class="form-group">
			                        	<label  for="form-job">职业</label>
			                        	<input type="text" name="job"  class="form-job " value="<%=user.getJob() %>" id="form-job">
			                        </div>

									<button type="button" class="btn btn-primary" style="width:" id="save" 
									data-id="<%=user.getId()%>" 
									disabled>保存修改</button>
			                    </form>
		                    </div>
                        </div>

<hr style="color:black;border-top:1px solid #C0C0C0">
      <!-- Site footer -->
      <footer class="footer" style="float:none">
        <p>&copy; 2017 LZTR Group.</p>
      </footer>

    </div> <!-- /container -->
    
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
    <script src="<%=path %>/questionnaire/js/user.js"></script>
        <script>
        $(window).scroll(function () {
            if ($(".navbar").offset().top > 50) {$(".navbar-fixed-top").addClass("top-nav");
            }else {$(".navbar-fixed-top").removeClass("top-nav");}
        })
         </script><script>
        function buttonable(){
        	document.getElementById("save").disabled=false;
        };
        
        </script>
        
  </body>
</html>