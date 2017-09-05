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
            <link rel="stylesheet" href="<%=path %>/questionnaire/css/font-awesome.min.css">


        <link href="<%=path %>/questionnaire/css/font-awesome.min.css" rel="stylesheet">
		<link href="<%=path %>/questionnaire/css/validation.css" rel="stylesheet">


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <script src="<%=path %>/questionnaire/js/jquery.min.js"></script>
     <script src="<%=path %>/questionnaire/js/jquery.validate.min.js"></script>
    <script src="<%=path %>/questionnaire/js/messages_zh.js"></script>
    <script src="<%=path %>/questionnaire/js/bootstrap.min.js"></script>
     <script src="<%=path %>/questionnaire/js/bootbox.min.js"></script>
    <script src="<%=path %>/questionnaire/js/user.js"></script>
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
    <nav class="navbar navbar-fixed-top my-navbar" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="allBooksClientPro"><font size=5>LZTR 问卷网</font></a>
            </div>
            <div class="collapse navbar-collapse" id="example-navbar-collapse">
            </div>
            

        </div>
    </nav>

 <div class="bg jumbotron"></div>
    <div class="container">
    
    
    
     <h2 color="#505050" align="center">欢迎注册LZTR问卷网！</h2>
     <p align="right">已有账号？<a href="loginPage"><strong>登陆</strong></a></p>
     <hr style="color:black;border-top:1px solid #C0C0C0">


                        <div class="col-sm-6 col-sm-offset-3 form-box" style="float:none">
                            <div class="form-bottom" >
			                    <form role="form" class="login-form" id="registerform">
			                    	<div class="form-group">
			                    		<label  for="form-username">用户名<font color="red">*</font></label>
			                        	<input type="text" name="username"  class="form-username form-control" id="form-username" required maxlength="255">
			                       
			                        <label id="dupname" style='color:#de615e;font-family:Helvetica Neue,Helvetica,Arial,sans-serif;font-size:14px;'></label>
			                         </div>
			                        <div class="form-group">
			                        	<label for="form-password">密码<font color="red">*</font></label>
			                        	<input type="password" name="password"  class="form-password form-control" id="form-password" required maxlength="255">
			                        </div>
			                        <div class="form-group">
			                        	<label  >请再次输入密码<font color="red">*</font></label>
			                        	<input type="password" name="confirmpassword"  class="form-password form-control" required equalTo="#form-password" maxlength="255">
			                        </div>
			                        <div class="form-group">
			                        	<label for="form-email">邮箱<font color="red">*</font></label>
			                        	<input type="email" name="email"  class="form-email form-control" id="form-email" required maxlength="255">
			                        </div>
			                        	<hr style="color:black;border-top:1px solid #C0C0C0">
			                    	     <div align="center"> <font>以下为个性化信息</font></div>
			                        <div class="form-group">
			                        	<label for="form-age">年龄</label>
			                        	<input type="number" name="age" step="1"  class="form-age form-control" id="form-age" min="0" digits="true">
			                        </div>
			                        <div class="form-group">
			                        	<label  for="form-sex">性别</label>
			                        	<select  id="form-sex" name="sex" class="form-sex form-control">
											<option value="male">男</option>
											<option value="female">女</option>
										</select>
			                        </div>
			                        			                        <div class="form-group">
			                        	<label  for="form-country">国家</label>
			                        	<input type="text" name="country"  class="form-country form-control" id="form-country" maxlength="255">
			                        </div>
			                        			                        <div class="form-group">
			                        	<label  for="form-city">城市</label>
			                        	<input type="text" name="city" class="form-city form-control" id="form-city" maxlength="255">
			                        </div>
			                        			                        <div class="form-group">
			                        	<label  for="form-mobile">电话</label>
			                        	<input type="text" name="mobile"  class="form-mobile form-control" id="form-mobile" oninput="changephonechecker()">
			                        </div>
			                        <div id="phonechecker">
									
									</div>
			                        			                        <div class="form-group">
			                        	<label  for="form-qq">QQ</label>
			                        	<input type="text" name="qq"  class="form-qq form-control" id="form-qq" digits="true">
			                        </div>
			                        			                        <div class="form-group">
			                        	<label  for="form-wechat">微信</label>
			                        	<input type="text" name="wechat"  class="form-wechat form-control" id="form-wechat" maxlength="255">
			                        </div>
			                        			                        			                        <div class="form-group">
			                        	<label  for="form-job">职业</label>
			                        	<input type="text" name="job"  class="form-job form-control" id="form-job" maxlength="255">
			                        </div>

												                        <button type="button" id="register" class="btn btn-primary" style="width:100%">注册！</button>
			                    </form>
		                    </div>
                        </div>

<hr style="color:black;border-top:1px solid #C0C0C0">
      <!-- Site footer -->
      <footer class="footer" style="float:none">
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