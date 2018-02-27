<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <head>
		<%
	String path=request.getContextPath();
	%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>登录</title>
        <!-- CSS -->
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/css.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=path %>/questionnaire/css/form-elements.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/style.css">
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="<%=path %>/questionnaire/img/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=path %>/questionnaire/img/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=path %>/questionnaire/img/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=path %>/questionnaire/img/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="<%=path %>/questionnaire/img/apple-touch-icon-57-precomposed.png">
    </head>
    <body>
        <!-- Top content -->
        <div class="top-content">
            <div class="inner-bg">
                <div class="container">
                    <div class="row" >   
                          <div class="col-sm-8">
                          <br><br>
                                    <h1><font color="white">现在登录</font></h1>
                                    <h1><font color="white">LZTR在线问卷网站！</font></h1>
                            		<p><font color="white">输入您的账户名与密码</font></p>
                            		<p><font color="white">没有账号？</font><a href="signupPage"><strong>注册</strong></a></p>
                            		<%
                            			if(request.getAttribute("flag") == "0"){
                            		%>
                            		<p><font color="red" class="error">用户名或密码错误，请重新输入</font>
                            		<%
                            			} else if(request.getAttribute("flag") == "1"){
                            		%>
                            		<p><font color="red" class="error">您的账户尚未激活，请确认您的邮箱</font>
                            		                            		<%
                            			} 
                            		%>
                          </div>
                        <div class="col-sm-4 form-box" >
                            <div class="form-bottom" >
			                    <form role="form" action="<%=path %>/loginPro" method="post" class="login-form" onsubmit="md5pass()">
			                    	<div class="form-group">
			                    		<label for="form-username">账户名</label>
			                        	<input type="text" name="username"  class="form-username form-control" id="form-username">
			                        </div>
			                        <div class="form-group">
			                        	<label  for="form-password">密码</label>
			                        	<input type="password" name="password"  class="form-password form-control" id="form-password">
			                        </div>
			                        <button type="submit" class="btn btn-success">登录！</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
        <!-- Javascript -->
        <script src="<%=path %>/questionnaire/js/jquery.min.js"></script>
         <script src="<%=path %>/questionnaire/js/jquery.validate.min.js"></script>
    <script src="<%=path %>/questionnaire/js/messages_zh.js"></script>
        <script src="<%=path %>/questionnaire/js/bootstrap.min.js"></script>
        <script src="<%=path %>/questionnaire/js/jquery.backstretch.min.js"></script>
        <script src="<%=path %>/questionnaire/js/scripts.js"></script>
        <script src="<%=path %>/questionnaire/js/md5.js"></script>
        <script src="<%=path %>/questionnaire/js/user.js"></script>
        <script>
        window.onload = function(){
        <%if(request.getAttribute("flag")!=null){
        if(request.getAttribute("flag").equals(2)){%>
			alert("激活成功!");
			<%}else if(request.getAttribute("flag").equals(3)){%>
			alert("不要重复激活!");
			<%}}%>
        }
        </script>
    </body>
</html>