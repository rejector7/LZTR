<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
        	<link href="<%=path%>/questionnaire/css/dataTables.bootstrap.css" 	rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/dataTables.responsive.css" 	rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/questionnaire.css" 			rel="stylesheet">
    <link href="<%=path %>/questionnaire/css/jquery-ui.min.css" rel="stylesheet">
    <!-- Bootstrap core CSS -->
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
		.login{
		width: 100%;height: 50px;margin: 0;padding: 0 20px;
			                        vertical-align: middle;background: #DE6164;border: 0;
			                        font-family: 'Roboto', sans-serif;font-size: 16px;font-weight: 300;line-height: 50px;color: #fff;
			                        transition-property: all;transition-duration: 0.3s;transition-timing-function: initial;transition-delay: initial;
		}
		.login:hover{
		opacity: 0.6;
    color: #fff;
    background-color: #449d44;
    border-color: #398439;
		}
    </style>
</head>
<body style="background:#F5F5F5">
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
				if(role.equals("admin")){ %>
				<li><a class="navbar-brand" href="<%=path %>/allUser"><span class="glyphicon glyphicon-wrench">系统信息管理</span></a></li>
				<%} }%>
				<li class="dropdown">
                <a href="#" class="dropdown-toggle navbar-brand" data-toggle="dropdown" role="button" aria-expanded="false">
                    <span>帮助页面目录</span><b class="caret"></b>
                </a>
                <ul class="dropdown-menu" style="background:#333!important" role="menu" >
                	<li><a href="#top">置顶</a></li>
                	<li role="presentation" class="divider"></li>
                	<li><a href="#H1">注册</a></li>
                	<li><a href="#H2">登录</a></li>
                	<li><a href="#H3">发布问卷</a></li>
                	<li><a href="#H4">填写问卷</a></li>
                	<li><a href="#H5">问卷的管理和结果的查看</a></li>
                	<li><a href="#H6">我的消息</a></li>
                	<li><a href="#H7">个人消息</a></li>
                	<% if(session.getAttribute("user")!=null){ %>				
					<% String role = user.getRole();if(role.equals("admin")){ %>
					<li><a href="#H8">管理员操作</a></li>
        			<%} }%>
					<li role="presentation" class="divider"></li>
					<li><a href="#bottom">置底</a></li>
                </ul>
            	</li>   
                </ul>                             
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
       	<div class="row"><font size=5 id="top"><strong>帮助</strong></font><br>
        <font size=3><a href="#H1">1.	注册</a></font><br>
		<font size=3><a href="#H2">2.	登录</a></font><br>
		<font size=3><a href="#H3">3.	发布问卷</a></font><br>
		<font size=3><a href="#H4">4.	填写问卷</a></font><br>
		<font size=3><a href="#H5">5.	问卷的管理和结果的查看</a></font><br>
		<font size=3><a href="#H6">6.	我的消息</a></font><br>
		<font size=3><a href="#H7">7.	个人信息</a></font><br>
        <% if(session.getAttribute("user")!=null){ %>				
		<% String role = user.getRole();if(role.equals("admin")){ %>
		<font size=3><a href="#H8">8.	管理员操作</a></font><br>
        <%} }%>
        <h4 id="H1">1.	注册</h4><a class="btn btn-default" id="a1" data-toggle="collapse"  
				   href="#p1" onclick="changea(1)">收起本节</a><br>
        <div id="p1" class="in">
        <p>在进入首页之后，在网页上端有登录和注册的按钮。</p>
        <nav class="navbar my-navbar top-nav" role="navigation" style="border-width:0 0 1px">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand"><font size="5">LZTR 问卷网</font></a>
            </div>
            <div class="navbar-collapse active" id="example-navbar-collapse">
                <ul class="nav navbar-nav">
                <% response.setCharacterEncoding("UTF-8"); 
					if(session.getAttribute("user")!=null){ %>				
				<% String role = user.getRole();
				if(role.equals("admin")){ %>
				<li><a class="navbar-brand"><span class="glyphicon glyphicon-wrench">系统信息管理</span></a></li>
				<%} }%></ul>                             
              <ul class="nav navbar-nav navbar-right in">
              	<li><a class="navbar-brand"><span class="glyphicon glyphicon-list">我的问卷</span></a></li>            
            	<li class="dropdown active">
                <a href="#" class="dropdown-toggle navbar-brand active" data-toggle="dropdown" role="button" aria-expanded="false">
                    <span class="glyphicon glyphicon-user">a</span>
                    <b class="caret"></b>
                </a>
                <ul class="dropdown-menu in" style="background:#333!important" role="menu">
                	<li><a >个人信息</a></li>
					<li><a >我的消息</a></li>
					<li role="presentation" class="divider"></li>
					<li><a  class="active">帮助</a></li>
                </ul>
            	</li>            	
               <li data-toggle="modal" data-target="#signin-signup-tab" id="signin-button"><a class="navbar-brand">登出</a></li>
              </ul>
            </div>            
        </div>
    </nav>
    <p>点击注册之后，可跳转到注册界面。</p>
    <div class="container" style="background-color:white">
    <h2  align="center">欢迎注册LZTR问卷网！</h2>
     <p align="right">已有账号？<a ><strong>登录</strong></a></p>
     <hr style="color:black;border-top:1px solid #C0C0C0">
                        <div class="col-sm-6 col-sm-offset-3 form-box" style="float:none">
                            <div class="form-bottom" >
			                    	<div class="form-group">
			                    		<label  for="form-username">用户名<font color="red">*</font></label>
			                        	<input type="text" class="form-username form-control" >	                         </div>
			                        <div class="form-group">
			                        	<label for="form-password">密码<font color="red">*</font></label>
			                        	<input type="password" class="form-password form-control" >
			                        </div>
			                        <div class="form-group">
			                        	<label  >请再次输入密码<font color="red">*</font></label>
			                        	<input type="password" class="form-password form-control">
			                        </div>
			                        <div class="form-group">
			                        	<label for="form-email">邮箱<font color="red">*</font></label>
			                        	<input type="email"  class="form-email form-control">
			                        </div>
			                        	<hr style="color:black;border-top:1px solid #C0C0C0">
			                    	</div></div>   </div>
    <p>注册步骤如下：<br>
		1、	输入必填信息并选择输入个性化信息（邮箱地址必须要正确）<br>
		2、	单击注册按钮<br>
		1)	若出现如下提示信息：<br>
    </p>
    <div class="modal-content"><div class="modal-body"><button type="button" class="bootbox-close-button close"  style="margin-top: -10px;">×</button><div class="bootbox-body">我们发了一封激活用的邮件到你的邮箱，请接收</div></div><div class="modal-footer"><button type="button" class="btn btn-primary">OK</button></div></div>
	<p></p>
	<p>单击OK或关闭，并等待页面进入邮箱登录页面（若已登录邮箱，会直接进入邮箱）。<br>
	2)	若未出现以上提示信息：<br>
		请查看信息输入栏中的提示信息，检查是否存在不合法输入，是否已存在用户名，是否邮箱已被注册<br>
	3、	单击激活链接<br>
	打开邮件并单击激活链接，页面会进入登录页面并提示激活成功，此时完成注册激活，注册的账号才可以正常使用。
	</p>
	</div>
		<h4 id="H2">2.	登录</h4><a class="btn btn-default" id="a2" data-toggle="collapse"  
				   href="#p2" onclick="changea(2)">收起本节</a><br>
        <div id="p2" class="in">
		<p>1、	进入如下登录界面：</p>
		<div class="top-content" style="background-image:url('questionnaire/img/homepage.jpg');background-size:100% 100%">
            <div style="padding:100px 0 170px 0">
                <div class="container">
                    <div class="row">   
                          <div class="col-sm-8">
                          <br><br>
                                    <h1 style="text-align: center;margin-top: 10px;font-size: 38px;font-weight: 100;line-height: 50px;"><font color="white">现在登录</font></h1>
                                    <h1 style="text-align: center;margin-top: 10px;font-size: 38px;font-weight: 100;line-height: 50px;"><font color="white">LZTR在线问卷网站！</font></h1>
                            		<p style="text-align: center;"><font color="white">输入您的账户名与密码</font></p>
                            		<p style="text-align: center;"><font color="white">没有账号？</font><a style="color: #de615e"><strong>注册</strong></a></p>
                          </div>
                        <div class="col-sm-4 form-box">
                            <div class="form-bottom" style="padding: 25px 25px 30px 25px;background: #fff;-moz-border-radius: 0 0 4px 4px;-webkit-border-radius: 0 0 4px 4px;border-radius: 0 0 4px 4px;text-align: left;color: #505050;">
			                     	
			                     	<div class="form-group">
			                    		<label for="form-username">账户名</label>
			                        	<input type="text" name="username" class="form-username form-control">
			                        </div>
			                        <div class="form-group">
			                        	<label for="form-password">密码</label>
			                        	<input type="password" name="password" class="form-password form-control">
			                        </div>
			                        <button type="button" class="btn login">登录！</button>
		                    </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
		<p>2、	输入用户名和密码，并单击登录按钮，在验证成功后就能够登录网站。<br>若出现用户名不存在或密码错误的提示信息或其他非法输入提示，请检查密码和用户名输入是否正确。
		</p></div>
		<h4 id="H3">3.	发布问卷</h4><a class="btn btn-default" id="a3" data-toggle="collapse"  
				   href="#p3" onclick="changea(3)">收起本节</a><br>
        <div id="p3" class="in">
		<p><font size="3">1、进入发布问卷的页面主要有两种途径</font><br><br>一是首页的中间部分的链接，在点击后，就可以进入问卷的设计界面。<br>二是“我的问卷”页面里的链接，点击之后也可以跳转到设计界面。<br></p>
		<p><font size="3">2、问卷发布页面</font></p>
		<div class="container" style="background-color:white">
		<nav class="navbar my-navbar top-nav" role="navigation" style="border-width:0 0 1px">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="example-navbar-collapse">
                <form class="navbar-form navbar-left" >
			      		<button class="btn btn-default" type="button" style="float:right">
				<i class="fa fa-save">保存</i>
		</button>
		<button class="btn btn-default" type="button" style="float:right">
				<i class="fa fa-mail-reply">取消</i>
		</button>
		<button class="btn btn-default" type="button" style="float:right">
				<i class="fa fa-eye">预览</i>
		</button>
		<button class="btn btn-default" type="button" style="float:right">
				<i class="fa fa-paper-plane">
				
				发布</i>
		</button>
                </form>
                     <form class="navbar-form navbar-right">
		<button class="btn btn-default" type="button" style="float:right;">
				<i class="fa fa-plus  ">填空题</i>
		</button>
		<button class="btn btn-default" type="button" style="float:right;">
				<i class="fa fa-plus  ">单选题</i>
		</button>
		<button class="btn btn-default" type="button" style="float:right;">
				<i class="fa fa-plus  ">多选题</i>
		</button>
		<button class="btn btn-default" type="button" style="float:right;">
				<i class="fa fa-plus ">滑块题</i>
		</button>
              		</form> 
            </div>
        </div>
    </nav>
    <div class="bg jumbotron">
        <p><font size="10">编辑问卷</font></p>
      </div>
      <div class="container"><br>
		<div class="row ">
			 <label><font size="5">标题</font></label>
			 <input type="text" name="title" class="form-control" >
		</div>
		<div class="row">
			 <label><font size="5">简介</font></label>
			 <input type="text" name="introduction" class="form-control">
		</div><br>
		<div class="row">
			 <input type="checkbox"checked="">
			 <label><font size="5">是否允许同一IP重复作答?</font></label>
		</div>
		<hr style="color:black;border-top:1px solid #C0C0C0">
		 	<div class="row" style="float:left"><font size="5"><strong>添加题目</strong></font></div>
		<br><hr>
    </div></div>
    <p>“标题”：用于填写问卷标题，在此后可随意修改。<br>“简介”：用于填写问卷简介<br>“是否允许同一IP重复作答”：主要用于调查的查重，如果不允许同一IP重复作答，那么每一个IP就只允许提交一次。<br>
    <strong>“简介”与“是否允许同一IP重复作答”在首次保存后的修改会删除已有的答卷，请谨慎填写。</strong>
    <br>
    </p>
    <p><font size="3">3、问卷的题型</font><br>我们的问卷网提供4种题型：滑块题、单选题、多选题和填空题。
	<br>可以通过页面的按钮进行添加和删除；可以直接拖拉模块来改变试题的顺序。
	<br>可以设计必答和非必答（必答的问题后面会有一个红色的*号，在提交的时候会检查是否已经填写）。
	<br>每题必须填写题干，选择题类型必须填写选项内容。
	<br><font size="3">1)滑块题</font>
	<br>示例
	<br>设计格式：</p>
	<div ><div class="form-group container" style="background:#fff;border:1px solid #c0c0c0;border-radius:5px"><br><div class="row"><div class="col-lg-8"><label><font size="5">1</font><font size="3">  滑块题  点击输入框编辑题目</font></label></div><div class="col-lg-1"><font size="3"><label>必答</label><input type="checkbox" checked></font></div>
	<div class="col-lg-2"><div><button class="btn btn-default" type="button" style=""><i class="fa fa-times">删除本题</i></button></div></div></div><div class="row container"><div class="col-lg-10"><font size="3"><input class="form-control" value="流畅度几分？"></font></div><div class="col-lg-2"><font size="3"><input type="checkbox" ><label><font size="3">添加关联</font></label></font></div></div>
    <div class="container"><div class="row"><div class="col-lg-1"><font size="3"><label><font size="3">最大值</font></label></font></div><div class="col-lg-3"><font size="3"><input class="form-control" type="number" step="1" value="100"></font></div>
    <div class="col-lg-2"><font size="3"><label><font size="3">最大值标签</font></label></font></div><div class="col-lg-5"><font size="3"><input class="form-control" type="text" value="MAX"></font></div></div>
    <div class="row"><div class="col-lg-1"><font size="3"><label><font size="3">最小值</font></label></font></div><div class="col-lg-3"><font size="3"><input class="form-control" type="number" step="1" value="0"></font></div>
    <div class="col-lg-2"><font size="3"><label><font size="3">最小值标签</font></label></font></div><div class="col-lg-5"><font size="3"><input class="form-control" type="text" value="MIN"></font></div></div>
    </div><font size="3"><br></font></div></div>
	<p>填写样式：</p>
	<div class="container" style="background-color:white"><p2><font size="4">1 流畅度几分？</font></p2><font color="red" size="4">&nbsp;*</font><div class="container"><p></p><div class="row"><div class="col-lg-6" style="padding-top:10px"><div style="padding-up:100px" class="ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"><div class="ui-slider-range ui-corner-all ui-widget-header ui-slider-range-min" style="width: 0%;"></div><span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default" style="left: 0%;"></span></div><div class="col-lg-6">0  MIN</div><div class="col-lg-6" align="right">MAX  5</div></div><div class="col-lg-1"><input class="form-control" value="0" type="number" step="1" ></div></div><p></p></div></div>
	<p>滑块题一般用来调查满意度等数据，统计数据主要为平均数值和总回答数。<br>滑块题需设置的额外内容：<br>最大值、最小值：可填写的数值范围<br>最大值标签、最小值标签：最大值与最小值所代表的内容。</p>
	<p><br><font size="3">2)单选题</font>
	<br>示例
	<br>设计格式：</p>
	<div><div class="form-group container" style="background:#fff;border:1px solid #c0c0c0;border-radius:5px"><br><div class="row"><div class="col-lg-8"><label><font size="5">2</font><font size="3">  单选题  点击输入框编辑题目</font></label></div><div class="col-lg-1"><font size="3"><label><font size="3">必答</font></label><input type="checkbox" checkd></font></div>
	<div class="col-lg-3"><button class="btn btn-default" type="button" style=""><i class="fa fa-plus">添加选项</i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-times">删除本题</i></button></div></div>
	<div class="row container"><div class="col-lg-10"><font size="3"><input class="form-control" value="满意度"></font></div><div class="col-lg-2"><font size="3"><input type="checkbox" checked>
	<label><font size="3">添加关联</font></label></font></div></div><div class="container" ><font size="3"><label><font size="3">添加并填写选项</font></label></font><div>
	<div class="container"><div class="row container col-lg-8"><input class="form-control" value="满意"></div><div class="col-lg-2"><div ><button class="btn btn-default" type="button" style=""><i class="fa fa-times"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-up"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-down"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-plus"></i></button></div></div><div class="col-lg-2"><label>是否需要填写文本</label><input type="checkbox" ></div></div></div>
	<div ><div class="container"><div class="row container col-lg-8"><input class="form-control" value="一般"></div><div class="col-lg-2"><div ><button class="btn btn-default" type="button" style=""><i class="fa fa-times"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-up"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-down"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-plus"></i></button></div></div><div class="col-lg-2"><label>是否需要填写文本</label><input type="checkbox"></div></div></div>
	<div ><div class="container"><div class="row container col-lg-8"><input class="form-control" value="不满"></div><div class="col-lg-2"><div ><button class="btn btn-default" type="button" style=""><i class="fa fa-times"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-up"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-down"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-plus"></i></button></div></div><div class="col-lg-2"><label>是否需要填写文本</label><input type="checkbox"></div></div></div></div><font size="3"><br></font></div></div>
	<p>填写样式：</p>
	<div class="container" style="background-color:white"><p2><font size="4">2 满意度</font></p2><font color="red" size="4">&nbsp;*</font><div class="container"><p></p><div class="radio"><label><input required="" type="radio" value="0" name="1" rele="4" ><font size="4"><strong>满意</strong></font></label></div><p></p><p></p><div class="radio"><label><input required="" type="radio" value="1" name="1" rele="" ><font size="4"><strong>一般</strong></font></label></div><p></p><p></p><div class="radio"><label><input required="" type="radio" value="2" name="1" rele="" ><font size="4"><strong>不满</strong></font></label></div><p></p></div></div>
	<p>单选题可以添加含输入框的选项，以便答题的用户自己去填写内容，效果同多选题中的演示。<br>选项可以通过右侧的按钮进行删除、上移、下移、在下方添加新选项等操作。</p>
	<p><br><font size="3">3)多选题</font>
	<br>示例
	<br>设计格式：</p>
	<div><div class="form-group container" style="background:#fff;border:1px solid #c0c0c0;border-radius:5px"><br><div class="row"><div class="col-lg-3"><label><font size="5">3</font><font size="3">  多选题  点击输入框编辑题目</font></label></div><div class="col-lg-1"><label><font size="3">最大可选</font></label></div><div class="col-lg-1"><input class="form-control" type="number" step="1" value="3"></div><div class="col-lg-1"><label><font size="3">最小可选</font></label></div><div class="col-lg-1"><input class="form-control" type="number" step="1" value="1"></div><div class="col-lg-1"></div><div class="col-lg-1"><label><font size="3">必答</font></label><input type="checkbox" checked></div>
	<div class="col-lg-3"><div ><button class="btn btn-default" type="button" style=""><i class="fa fa-plus">添加选项</i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-times">删除本题</i></button></div></div></div>
	<div class="row container"><div class="col-lg-10"><input class="form-control" value="你喜欢的运动项目"></div><div class="col-lg-2"><input type="checkbox"><label><font size="3">添加关联</font></label></div></div><div class="col-lg-12" ></div><div class="container"><font size="3"><label><font size="3">添加并填写选项</font></label></font>
	<div ><div class="container"><div class="row container col-lg-8"><input class="form-control" value="足球"></div><div class="col-lg-2"><div><button class="btn btn-default" type="button" style=""><i class="fa fa-times"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-up"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-down"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-plus"></i></button></div></div><div class="col-lg-2"><label>是否需要填写文本</label><input type="checkbox" ></div></div></div>
	<div ><div class="container"><div class="row container col-lg-8"><input class="form-control" value="篮球"></div><div class="col-lg-2"><div><button class="btn btn-default" type="button" style=""><i class="fa fa-times"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-up"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-down"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-plus"></i></button></div></div><div class="col-lg-2"><label>是否需要填写文本</label><input type="checkbox"></div></div></div>
	<div ><div class="container"><div class="row container col-lg-8"><input class="form-control" value="其他"></div><div class="col-lg-2"><div><button class="btn btn-default" type="button" style=""><i class="fa fa-times"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-up"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-chevron-down"></i></button><button class="btn btn-default" type="button" style=""><i class="fa fa-plus"></i></button></div></div><div class="col-lg-2"><label>是否需要填写文本</label><input type="checkbox" checked></div></div></div></div><font size="3"><br></font></div></div>
	<p>填写样式：</p>
	<div  class="container" style="background-color:white"><p2><font size="4">3 你喜欢的运动项目(1~3项)</font></p2><font color="red" size="4">&nbsp;*</font><div id="2div" class="container"><strong><div id="2message" class="error"></div></strong><p><label><input required="" type="checkbox" value="0" name="2" rele="" ><font size="4"><strong>足球</strong></font></label></p><p></p><p><label><input required="" type="checkbox" value="1" name="2" rele="" onclick="releEffect(2)"><font size="4"><strong>篮球</strong></font></label></p><p></p><p><label style="float:left"><input required="" type="checkbox" value="2" name="2" rele="" onclick="releEffect(2)"><font size="4"><strong>其他</strong></font></label></p><div><input name="2_2words"></div><p></p></div></div>
	<p>多选题可以添加含输入框的选项，以便答题的用户自己去填写内容。<br>选项可以通过右侧的按钮进行删除、上移、下移、在下方添加新选项等操作。<br>多选题需设置的额外内容：<br>最大可选选项数：设置可选选项的上限，不设置时默认为选项总数<br>最小可选选项数：设置可选选项的下限，不设置时非必答题默认为0，必答题默认为1</p>
	<p><br><font size="3">4)填空题</font>
	<br>示例
	<br>设计格式：</p>
	<div><div class="form-group container" style="background:#fff;border:1px solid #c0c0c0;border-radius:5px"><br><div class="row"><div class="col-lg-8"><label><font size="5">4</font><font size="3">  填空题  点击输入框编辑题目</font></label></div><div class="col-lg-1"><font size="3"><label><font size="3">必答</font></label><input type="checkbox" checked></font></div><div class="col-lg-3"><button class="btn btn-default" type="button" style=""><i class="fa fa-times">删除本题</i></button></div></div><div class="row container"><div class="col-lg-10"><font size="3"><input class="form-control" value="君の名は？"></font></div><div class="col-lg-2"><font size="3"><input type="checkbox"><label><font size="3">添加关联</font></label></font></div></div><font size="3"><br></font></div></div>
	<p>填写样式：</p>
	<div class="container" style="background-color:white"><p2><font size="4">4 君の名は？</font></p2><div id="4div" class="container"><div class="col-lg-10"><input class="form-control" name="4"></div></div></div>
	<p><font size='3'>4、问卷的逻辑</font><br>我们提供“问题关联”的方式来解决逻辑问题。一个题目可与同一题中多个选项关联，当且仅当关联的选项被选中时，关联的题目才会显示并可被作答。
	<br>如在上面的示例中，选择4号问题关联到2号问题的选项“满意” 在点击4号问题的边上的<input type="checkbox"><label><font size="3">添加关联</font></label>之后就会跳转出这个窗口，
	</p>
	<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-id="3">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
							<div class="form-group">
								<label>选择想要关联的问题</label>
								<select class="form-control" id="formerques" onchange="releopts()"><option>2.满意度</option><option>3.你喜欢的运动项目</option></select>
							</div>
							<label>当以下选项被选中时</label>
							<div class="form-group" id="specoptiondiv"><input type="checkbox"><label>满意</label><br><input type="checkbox"><label>一般</label><br><input type="checkbox"><label>不满</label><br></div>
							<label>本问题会出现。</label><br>
							<label>将本关联复制到后续问题: </label>
							<div class="form-group" id="laterques"><input type="checkbox"><label>5.你的名字？</label><br></div>
						</div></div></div>
						<div class="modal-footer">
					<button type="button" class="btn btn-primary">确认</button>
				</div>
			</div><br>
			<p>选择关联情况之后就会显示在问题的下面。</p>
			<div><div class="form-group container" style="background:#fff;border:1px solid #c0c0c0;border-radius:5px"><br><div class="row"><div class="col-lg-8"><label><font size="5">4</font><font size="3">  填空题  点击输入框编辑题目</font></label></div><div class="col-lg-1"><font size="3"><label><font size="3">必答</font></label><input type="checkbox" checked></font></div><div class="col-lg-3"><button class="btn btn-default" type="button" style=""><i class="fa fa-times">删除本题</i></button></div></div><div class="row container"><div class="col-lg-10"><font size="3"><input class="form-control" value="君の名は？"></font></div><div class="col-lg-2"><font size="3"><input type="checkbox" checked><label><font size="3">添加关联</font></label></font></div></div><div class="col-lg-12">关联：本题在 <span>2.满意度</span> 中的以下选项中某一项被选中时出现: <span>满意 </span></div><font size="3"><br></font></div></div>
	<p>若选择将本关联复制到后续问题中的选项，该关联就会被复制到所选的问题上。<br>若想要取消关联，再次点击已被选中的<input type="checkbox" checked><label><font size="3">添加关联</font></label>即可。<br>删除题目或选项时对应的关联信息会自动删除。<br>拖动题目时，关联的题目无法被移动到含该题所关联选项得题目前，含关联选项的题目不得移动到改选项所关联的题目后。
	</p>
	<p><font size="3">5、发布编辑好的问卷</font><br>
	<button class="btn btn-default" type="button" >
				<i class="fa fa-save">保存</i>
		</button>
		<button class="btn btn-default " type="button" >
				<i class="fa fa-mail-reply">取消</i>
		</button>
		<button class="btn btn-default " type="button" >
				<i class="fa fa-eye">预览</i>
		</button>
		<button class="btn btn-default" type="button" >
				<i class="fa fa-paper-plane">
				发布</i>
		</button>
	在问卷设计IP是否查重的后面有这些按钮。
	<br><font size="3">发布：</font>发布问卷。在设计好问卷之后，点击发布问卷，会弹出如下窗口：</p>
		<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" >
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
						<form id="form2">
							<div class="form-group">
								<label>是否公开</label>
								<select class="form-control" >
										<option selected="">是</option>
										<option>否</option>
								</select>
								</div>
								<div class="form-group">
									<label>发布时间</label>
									<input class="form-control" type="date" >
								</div>
								<div class="form-group">
									<label>结束时间（若不设定可不填写）</label>
									<input class="form-control" type="date" >
								</div>
								<div class="form-group">
									<label>当前状态:</label>
									<p>已发布</p>
								</div>
						</form>
						</div></div></div>
						<div class="modal-footer">
					<button type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary">确认</button>
				</div>
			</div>
	<p><br>在设置好发布时间和结束时间之后点击确认，会提供给用户该问卷的填写网址，</p>
	<div class="modal-content"><div class="modal-body"><button type="button" class="bootbox-close-button close" aria-hidden="true" style="margin-top: -10px;">×</button><div class="bootbox-body">更新成功并已发布<br><input class="form-control" value="localhost:8080/questionnaire/FillQuestionnaire?quesid=76" type="text"><input class="btn btn-default" type="button" value="点击复制问卷链接"></div></div><div class="modal-footer"><button type="button" class="btn btn-primary">OK</button></div></div>
	<p><br>用户可以给他人该地址来让别人填写你的问卷。<br> “是否公开”的选择主要涉及私密，“公开”的问卷会在发布的时候就出现在页面首页的“最新发布栏目”，而“不公开”的问卷则不会。
	<br>首页显示的公开发布问卷如下：</p>
	<div class="container"style="background-color:white">
	<div class="row" ><font size="5"><strong>最新发布</strong></font></div>
	<hr>
	<hr style="color:black;border-top:1px solid #C0C0C0">
	<div class="row">
      <div class="row col-lg-9">
      <div class="row">
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a >
       <h3><span class="badge" align="left" style="float:left;align:left">1</span>问卷示例模型</h3>
       </a>
          <p><font color="#cccccc">这是问卷示例！！</font></p>
	</div></div>   
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a >
       <h3><span class="badge" align="left" style="float:left;align:left">4</span>专业方向选择现状问卷调查</h3>
       </a>
          <p><font color="#cccccc">为了解我国专业方向选择现状，特进行此项调查，望大家积极配合。谢谢！</font></p>
	</div></div>
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a >
       <h3><span class="badge" align="left" style="float:left;align:left">5</span>测试用</h3>
       </a>
          <p><font color="#cccccc"></font></p>
	</div></div></div>
        </div></div></div>
     <p>其中，第一个“问卷示例模型”问卷就是上面的示例问卷，在首页点击之后就能够进行填写。</p>
	<p><font size="3">预览：</font>可以在发布之前查看问卷的填写的形式。<br>之前的示例在预览界面效果如下：</p>
	<div style="background-color:white">
	<div class="container" ><p2><font size="4">1 流畅度几分？</font></p2><font color="red" size="4">&nbsp;*</font><div class="container"><p></p><div class="row"><div class="col-lg-6" style="padding-top:10px"><div style="padding-up:100px" class="ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"><div class="ui-slider-range ui-corner-all ui-widget-header ui-slider-range-min" style="width: 0%;"></div><span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default" style="left: 0%;"></span></div><div class="col-lg-6">0  MIN</div><div class="col-lg-6" align="right">MAX  5</div></div><div class="col-lg-1"><input class="form-control" value="0" type="number" step="1" ></div></div><p></p></div></div>
	<div class="container" ><p2><font size="4">2 满意度</font></p2><font color="red" size="4">&nbsp;*</font><div class="container"><p></p><div class="radio"><label><input type="radio" id="preradio" name="1" onchange="showrele()"><font size="4"><strong>满意</strong></font></label></div><p></p><p></p><div class="radio"><label><input required="" type="radio" value="1" name="1" rele="" onchange="showrele()"><font size="4"><strong>一般</strong></font></label></div><p></p><p></p><div class="radio"><label><input required="" type="radio" value="2" name="1" rele="" onchange="showrele()"><font size="4"><strong>不满</strong></font></label></div><p></p></div></div>
	<div  class="container" ><p2><font size="4">3 你喜欢的运动项目(1~3项)</font></p2><font color="red" size="4">&nbsp;*</font><div id="2div" class="container"><strong></strong><p><label><input required="" type="checkbox" value="0" name="2" rele="" onclick="releEffect(2)"><font size="4"><strong>足球</strong></font></label></p><p></p><p><label><input required="" type="checkbox" value="1" name="2" rele="" onclick="releEffect(2)"><font size="4"><strong>篮球</strong></font></label></p><p></p><p><label style="float:left"><input required="" type="checkbox" value="2" name="2" rele="" onclick="releEffect(2)"><font size="4"><strong>其他</strong></font></label></p><div><input name="2_2words"></div><p></p></div></div>
	<div class="container" id="preblank" hidden><p2><font size="4">4 君の名は？</font></p2><div id="4div" class="container"><div class="col-lg-10"><input class="form-control" name="4"></div></div></div>
	</div>
	<p>第4题当且仅当在2中选择“满意”选项时出现。（可尝试在上方选择该选项并显示题目）
	<br><font size="3">保存：</font>暂存编写的问卷，可以之后在“我的问卷”处进行进一步编辑或者发布。
	<br><font size="3">取消：</font>取消编辑，也就是放弃现在编写的未发布的问卷。
	</p></div>
		<h4 id="H4">4.	填写问卷</h4><a class="btn btn-default" id="a4" data-toggle="collapse"  
				   href="#p4" onclick="changea(4)">收起本节</a><br>
        <div id="p4" class="in">
		<p>用户填写问卷主要有两种方式，<br>第一：点击首页的“最新发布”栏目上面的链接；<br>第二：使用问卷发布者给出的链接。<br>填写问卷的页面如下：
		</p>
		<div style="background-color:white">
		<div class="container" ><p2><font size="4">1 流畅度几分？</font></p2><font color="red" size="4">&nbsp;*</font><div class="container"><p></p><div class="row"><div class="col-lg-6" style="padding-top:10px"><div style="padding-up:100px" class="ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"><div class="ui-slider-range ui-corner-all ui-widget-header ui-slider-range-min" style="width: 60%;"></div><span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default" style="left: 60%;"></span></div><div class="col-lg-6">0  MIN</div><div class="col-lg-6" align="right">MAX  5</div></div><div class="col-lg-1"><input class="form-control" value="3" type="number" step="1" ></div></div><p></p></div></div>
		<div class="container" ><p2><font size="4">2 满意度</font></p2><font color="red" size="4">&nbsp;*</font><div class="container"><p></p><div class="radio"><label><input type="radio" name="1" ><font size="4"><strong>满意</strong></font></label></div><p></p><p></p><div class="radio"><label><input required="" type="radio" value="1" name="1" rele="" ><font size="4"><strong>一般</strong></font></label></div><p></p><p></p><div class="radio"><label><input required="" type="radio" value="2" name="1" rele=""><font size="4"><strong>不满</strong></font></label></div><p></p></div></div>
		<div  class="container" ><p2><font size="4">3 你喜欢的运动项目(1~3项)</font></p2><font color="red" size="4">&nbsp;*</font><div id="2div" class="container"><strong></strong><p><label><input required="" type="checkbox" value="0" name="2" rele="" checked><font size="4"><strong>足球</strong></font></label></p><p></p><p><label><input required="" type="checkbox" value="1" name="2" rele="" onclick="releEffect(2)"><font size="4"><strong>篮球</strong></font></label></p><p></p><p><label style="float:left"><input required="" type="checkbox" value="2" name="2" rele="" checked><font size="4"><strong>其他</strong></font></label></p><div><input value="乒乓球"></div><p></p></div></div>
		<div class="container" ><p2><font size="4">4 君の名は？</font></p2><div id="4div" class="container"><div class="col-lg-10"><input class="form-control" name="4"></div></div></div>
		<div align="center">
      	<button style="floating:right" class="btn btn-primary" type="button">
			<i class="fa fa-check fa-2x">提交</i>
		</button>
		</div>
		</div>
		<p><strong>滑块题的回答方式：</strong>
		<br>直接拖动滑块或者在旁边的输入框里面填写数字就可以完成；
		<br><strong>单选题和多选题的回答方式：</strong>
		<br>直接勾选，如果出现“其他”等需要填写的选项的时候，必须在选项旁的输入框中填写内容后才可提交。
		<br><strong>填空题：</strong>
		<br>直接填写。
		<br>填写完成之后，点击页底的“提交”按钮，就能够提交本次填写。
		<br>若无法正常提交，在问卷底部会集中显示错误的题号或其他错误原因。
		</p></div>
		<h4 id="H5">5.	问卷的管理和结果的查看</h4><a class="btn btn-default" id="a5" data-toggle="collapse"  
				   href="#p5" onclick="changea(5)">收起本节</a><br>
        <div id="p5" class="in">
		<p>在登录之后，网站的首页上方会有‘我的问卷’的链接，点击之后就可以进入“我的问卷”页面。
		<br>对每一个问卷有6种操作：
		<br>“删除”按钮可以删除选中的问卷；
		<br>“发布状态”按钮可以修改问卷信息，点击后会出现下方的窗口，可以对相关信息进行修改；</p>
		<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" >
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" >修改问卷信息</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
								<div class="form-group">
									<label>标题</label>
									<input class="form-control" name="title">
								</div>
								<p id="titlea"></p>
								<div class="form-group">
									<label>是否公开</label>
									<select class="form-control" id="selectf1" name="ispublic">
										<option selected="">是</option>
										<option>否</option>
									</select>
								</div>
								<div class="form-group">
									<label>发布时间</label>
									<input class="form-control" name="releasetime" type="date" >
								</div>
								<div class="form-group">
									<label>结束时间（若不设定可不填写）</label>
									<input class="form-control" name="endtime" type="date" >
								</div>
								<div class="form-group">
									<label>状态 说明：</label>
								</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" >关闭</button>
					<button type="button" class="btn btn-primary" >保存</button>
				</div>
			</div>
		<p><br>“修改内容”按钮可以进行问卷的再编辑，从而进行问卷的新发布（再编辑操作会删除此前收集的所有答卷）；
		<br>“预览”按钮可以查看该问卷在问卷填写人填写时的页面格式，与编写问卷时的预览一样；
		<br>“复制链接”按钮可以将问卷的填写地址复制到粘贴板；
		<br>“查看数据”按钮可以查看并统计调查结果，并跳转到答卷详细信息界面。</p>
		<p><strong>答卷详细信息：</strong>
		<br>该页面可以查看用户填写本问卷的时间和IP地址。
		<br>点击<a class="btn btn-default"><i class="fa fa-search"></i></a>按钮，则能够删除这个回答。
		<br>点击<a class="btn btn-default"><i class="fa fa-trash"></i></a>按钮，会有该用户这次填写的详细答案，如下图所示。</p>
		<div class="container" style="background-color:white">
		<div class="container">
      	<div class="masthead">
      	<p><strong >问卷id：26</strong></p>
      	<p><strong >问卷名：未起名</strong></p>
      	<p><strong >用户id：3</strong></p> 
      	<button type="button" class="btn btn-default" ">导出为Word</button>
      	</div>
    	</div>
    	<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="dataTable_wrapper">
								<table class="table table-striped table-bordered table-hover" id="dataTables">
									<thead>
										<tr>
											<th>题号</th>
										    <th>题目</th>
										    <th>题型</th>
										    <th>是否必答</th>
											<th>回答</th>
										</tr>
									</thead>
									<tbody id="ASheet"><tr><td>1</td><td>第一题的题干</td><td>滑动条</td><td>非必答</td><td>84</td></tr><tr><td>2</td><td>第二题的题干</td><td>单选题</td><td>必答</td><td>选项  </td></tr><tr><td>3</td><td>第三题的题干</td><td>填空题</td><td>非必答</td><td>abc</td></tr><tr><td>4</td><td>第四题的题干</td><td>多选题</td><td>非必答</td><td>1项 ;2项 ;3项 ;</td></tr></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
	<div >
    <div class="input-group">
      <input type="text" class="form-control" placeholder="留言反馈..." name="msg">
      <span class="input-group-btn">
      	<button class="btn btn-default" type="button" id="reply" data-rid="3"><i class="fa fa-reply"></i></button>
      </span>
    </div>
    </div>
    </div>
		</div>
		<p>上方是某次回答的详细信息的界面，可通过导出为word按钮导出含有回答信息的word文档。
		<br>若填写人在登录状态下填写问卷，问卷发起人可以通过下面的留言框来进行进一步的调查，发起人发送的留言会发送到填写人的消息页面中。
		<strong>统计数据页面：</strong>
		<br>在答卷详细信息界面，点击右上方的“查看统计数据”链接之后，可以进入统计数据页面，查看问卷结果的统计数据和图形分析。统计信息可通过最上方的导出按钮，选择导出当前页面为jpeg格式文件，或导出统计数据为xml格式文件。</p>
 		<div>
 		<div class="container" style="background-color:white">
      <div class="container">
       	<div class="row" style="float:left"><font size=5><strong>答卷统计数据</strong></font>
       	 <button type='button' class='btn btn-default'>导出页面为jpeg文件</button>
       	  <button type='button' class='btn btn-default'>导出数据为xml文件</button>
       	</div>
       	       	  <a class="btn btn-default"  href="getAnswerByQuesid?quesid=26" type="button" align="right" style="float:right;">
				<i class="fa fa-bar-chart">查看答卷信息</i> 
		</a>
 	<hr>
		<hr style="color:black;border-top:1px solid #C0C0C0" >  
    <p><strong>问卷序号：26</strong></p>
      <p><strong>问卷名字：未命名</strong></p>
    <p><font size="4">1 : 滑块</font></p><div class="container" id="0"><div class="container"> <!-- /.row --><div class="row">	<div class="col-lg-12">	<div class="panel panel-default">		<!-- /.panel-heading -->		<div class="panel-body">			<div class="dataTable_wrapper">				<table class="table table-striped table-bordered table-hover" id="dataTables">					<thead id="0head">						<tr><th width="40%">填写数量</th>							<th width="60%">平均值</th>						</tr></thead><tbody id="0body"><tr id="0_0tr"><td>8</td><td>70.75</td></tr></tbody></table></div></div></div></div></div></div>									 <!-- /.panel-body --><!-- /.panel --><!-- /.col-lg-12 --><!-- /.row --></div><p><font size="4">2 : 单选择</font></p><div class="container" id="1"><div class="container"> <!-- /.row --><div class="row">	<div class="col-lg-12">	<div class="panel panel-default">		<!-- /.panel-heading -->		<div class="panel-body">			<div class="dataTable_wrapper">				<table class="table table-striped table-bordered table-hover" id="dataTables">					<thead id="1head">						<tr><th width="40%">选项号</th>							<th width="60%">选择数</th>						</tr></thead><tbody id="1body"><tr id="1_0tr"><td id="1_0td">选项<a >详情</a></td><td>19</td></tr><tr id="1_1tr"><td id="1_1td">2项</td><td>8</td></tr></tbody></table></div></div></div></div></div></div><div class="container row" align="right"><button class="btn btn-default" type="button"><i class="fa fa-bar-chart-o" >柱状图</i></button><button class="btn btn-default" type="button"><i class="fa fa-pie-chart" >饼状图</i></button><button class="btn btn-default" type="button"><i class="fa fa-circle-o-notch" >圆环图</i></button><button class="btn btn-default" type="button"><i class="fa fa-line-chart" >折线图</i></button></div>									 <!-- /.panel-body --><!-- /.panel --><!-- /.col-lg-12 --><!-- /.row --></div><p><font size="4">3 : 填空</font></p><div class="container" id="2"><div class="container"> <!-- /.row --><div class="row">	<div class="col-lg-12">	<div class="panel panel-default">		<!-- /.panel-heading -->		<div class="panel-body">			<div class="dataTable_wrapper">				<table class="table table-striped table-bordered table-hover" id="dataTables">					<thead id="2head">						<tr><th width="40%">答卷序号</th>							<th width="60%">答案</th>						</tr></thead><tbody id="2body"><tr id="2_0tr"><td>1</td><td>abc</td></tr><tr id="2_1tr"><td>2</td><td>abc</td></tr><tr id="2_2tr"><td>3</td><td>abc</td></tr><tr id="2_3tr"><td>4</td><td>abc</td></tr><tr id="2_4tr"><td>5</td><td>abc</td></tr><tr id="2_5tr"><td>6</td><td>abc</td></tr><tr id="2_6tr"><td>7</td><td>fgh</td></tr><tr id="2_7tr"><td>8</td><td>fgh</td></tr><tr id="2_22tr"><td>23</td><td>asdasd</td></tr><tr id="2_23tr"><td>24</td><td>aa</td></tr></tbody></table></div></div></div></div></div></div>									 <!-- /.panel-body --><!-- /.panel --><!-- /.col-lg-12 --><!-- /.row --></div><p><font size="4">4 : 多选</font></p><div class="container" id="3"><div class="container"> <!-- /.row --><div class="row">	<div class="col-lg-12">	<div class="panel panel-default">		<!-- /.panel-heading -->		<div class="panel-body">			<div class="dataTable_wrapper">				<table class="table table-striped table-bordered table-hover" id="dataTables">					<thead id="3head">						<tr><th width="40%">选项号</th>							<th width="60%">选择数</th>						</tr></thead><tbody id="3body"><tr id="3_0tr"><td id="3_0td">1项</td><td>12</td></tr><tr id="3_1tr"><td id="3_1td">2项</td><td>10</td></tr><tr id="3_2tr"><td id="3_2td">3项</td><td>5</td></tr><tr id="3_3tr"><td id="3_3td">4项<a >详情</a></td><td>0</td></tr></tbody></table></div></div></div></div></div></div><div class="container row" align="right"><button class="btn btn-default" type="button"><i class="fa fa-bar-chart-o" >柱状图</i></button><button class="btn btn-default" type="button"><i class="fa fa-pie-chart" >饼状图</i></button><button class="btn btn-default" type="button"><i class="fa fa-circle-o-notch" >圆环图</i></button><button class="btn btn-default" type="button"><i class="fa fa-line-chart" >折线图</i></button></div>									 <!-- /.panel-body --><!-- /.panel --><!-- /.col-lg-12 --><!-- /.row --></div></div>
 		</div>
		<p>滑块题：统计数据为填写数量和平均值
		<br>单选题、多选题：统计数据为每个选项的选择数。对含有填写框的选项，可点击选项旁的详情按钮，查看填写情况。
		<br>填空题：统计数据为填写了该题的答案列表。
		<br>图像：单选题与多选题可根据统计数据制作图像，有柱状图、饼状图、环形图、折线图四种可选择。可通过图像上方的下载此图按钮下载对应的图像。
		<br>详情界面如下所示：
		</p>
		<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" >
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h3 class="modal-title" >题目“必答单选”的详情统计</h3>
					<h4 class="modal-title">选项“要填写文本的”</h4>
					<button type="button" class="btn btn-default" >数据导出为xml文件</button>
				</div>
				<div class="modal-body">
							<div class="dataTable_wrapper">
								<table class="table table-striped table-bordered table-hover" id="dataTable">
									<thead>
										<tr>
										    <th>答卷序号</th>
											<th>详情</th>
										</tr>
									</thead>
									<tbody ><tr><td>2</td><td>第一个回答</td></tr><tr><td>4</td><td>又一个回答</td></tr></tbody>
								</table>
							</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" >关闭</button>
				</div>
			</div>
		<p><br>可通过数据导出为xml文件，将本选项回答详情导出为xml格式文件</p></div></div>
		<h4 id="H6">6.	我的消息</h4><a class="btn btn-default" id="a6" data-toggle="collapse"  
				   href="#p6" onclick="changea(6)">收起本节</a><br>
        <div id="p6" class="in">
		<p>用户登录之后，在首页点击上方导航栏中用户名所在下拉框，会出现“我的消息”的链接。
		<br>在我的消息的页面。用户可以查看自己收到的所以消息和发送的所有消息。</p>
		<div class="container" style="background-color:white">
		<div style="position: absolute;">
				<ul class="nav in" id="side-menu">
					<li><a class="active"><i class="fa fa-send fa-fw"></i> 已发送</a></li>
					<li><a><i class="fa fa-comment fa-fw"></i> 收到</a></li>
				</ul>
			</div>
		<div style="margin:0 0 0 250px">
		<div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapse0">
                	发送至&nbsp;&nbsp;:&nbsp;&nbsp;  一个用户; &nbsp;&nbsp;&nbsp;    发送时间：Wed Sep 06 18:56:07 CST 2017
                </a>
            </h4>
        </div>
        <div class="panel-collapse collapse in">
            <div class="panel-body">
                消息内容：<br>
         			一些文本
            </div>
        </div>
    	<div class="input-group">
      <input type="text" class="form-control" placeholder="继续留言..." name="msg">
      <span class="input-group-btn">
      	<button class="btn btn-default" type="button"><i class="fa fa-reply"></i></button>
      </span>
    	</div>
    	</div>
    	</div>
    	</div>
		<p>1)在“已发送”页面，网页会列出所有已发送的消息，最近发送的一条消息会展开，其余消息则会折叠起来，点击之后可以展开。在每一条消息的下方都附加了一行输入行，在输入信息后，点击<button class="btn btn-default" type="button"><i class="fa fa-reply"></i></button>按钮就能够继续留言。
		</p>
		<p>2)在“收到”页面，网页同样会列出所有收到的信息，之前未读的消息会全部展开并在后台修改成已读，已读的会保持折叠。折叠和展开是可以任意变换的。在每一条消息后面也都有一个输入行，供用户回复消息。
		</p></div>
		<h4 id="H7">7.	个人信息</h4><a class="btn btn-default" id="a7" data-toggle="collapse"  
				   href="#p7" onclick="changea(7)">收起本节</a><br>
        <div id="p7" class="in">
		<p>用户登录之后，在首页点击自己的名字的地方，会出现“个人信息”的链接。
		<br>在个人信息的页面。用户可以查看和修改自己的个人信息。</p>
		<div class="container" style="background-color:white">
 	<div class="row" style="float:left"><font size="5"><strong>安全信息</strong></font></div>
 												<button class="btn btn-default" type="button" style="float:right;" data-id="3">
											<i class="fa fa-edit">&nbsp;修改密码</i>
											</button>	
    <hr> <hr style="color:black;border-top:1px solid #C0C0C0">
    <div class="container">
     <label>用户名 : </label><p></p>
	 <label>邮箱 : </label><br><br><br></div>
	 <div class="row"><font size="5"><strong>个性信息</strong></font></div>
     <hr style="color:black;border-top:1px solid #C0C0C0">
                        <div class="col-sm-6  form-box" style="float:none">
                            <div class="form-bottom">
			                        			                        <div class="form-group">
			                        	<label for="form-sex">性别</label>
			                        	<select id="form-sex" name="sex" class="form-sex" value="male">
											<option value="male" selected="selected">男</option>
											<option value="female">女</option>
										</select>
			                        </div>
			                        <div class="form-group">
			                        	<label for="form-age">年龄</label>
			                        	<input type="number" name="age" step="1">
			                        </div>
			                        			                        <div class="form-group">
			                        	<label for="form-country">国家</label>
			                        	<input type="text" name="country" class="form-country " >
			                        </div>
			                        			                        <div class="form-group">
			                        	<label for="form-city">城市</label>
			                        	<input type="text" name="city" class="form-city " >
			                        </div>
			                        			                        <div class="form-group">
			                        	<label for="form-mobile">电话</label>
			                        	<input type="text" name="mobile" class="form-mobile" >
			                        </div>
			                        			                        <div class="form-group">
			                        	<label for="form-qq">QQ&nbsp;</label>
			                        	<input type="text" name="qq" class="form-qq">
			                        </div>
			                        			                        <div class="form-group">
			                        	<label for="form-wechat">微信</label>
			                        	<input type="text" name="wechat" class="form-wechat " >
			                        </div>              			                        			                        <div class="form-group">
			                        	<label for="form-job">职业</label>
			                        	<input type="text" name="job" class="form-job ">
			                        </div>
									<button type="button" class="btn btn-primary" >保存修改</button>
		                    </div>
                        </div>
    	</div>
		<p>安全信息不能够修改，个性信息中各项信息都可以修改。修改完成后，点击保存修改即可。
		<br>点击“修改密码”按钮，会弹出下图的窗口：
		</p>
		<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">修改密码</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
						 <div class="form-group">
			                        	<label>旧密码</label>
			                        	<input type="password" name="oldpassword" placeholder="" class="form-control" >
			                        </div>
			                        <div class="form-group">
			                        	<label>新密码</label>
			                        	<input type="password" name="newpassword" placeholder="" class="form-control" >
			                        </div>
			                        <div class="form-group">
			                        	<label>确认新密码</label>
			                        	<input type="password" name="confirmpassword" placeholder="" class="form-control">
			                        </div>
						</div></div></div>
						<div class="modal-footer">
					<button type="button" class="btn btn-default">关闭</button>
					<button type="button" class="btn btn-primary" >确认</button>
				</div>
			</div>
		<p><br>必须正确输入旧密码，才能修改密码。
		<br>密码修改之后，登录状态会被刷新，之前的账号会被登出，需要用户使用新密码再次登录。
		</p></div>
        <% if(session.getAttribute("user")!=null){ %>				
		<% String role = user.getRole();if(role.equals("admin")){ %>
		<h4 id="H8">8.	管理员操作</h4><a class="btn btn-default" id="a8" data-toggle="collapse"  
				   href="#p8" onclick="changea(8)">收起本节</a><br>
        <div id="p8" class="in">
		<p>管理员在登录之后，首页上面会出现“系统信息管理”的链接。点击链接后能够进入后台管理的网页。
		<br>该页面能够进行用户和问卷的管理（包括用户的增删改查、问卷状态的修改、删除问卷、备份问卷）
		<br>用户管理有两个操作，第一个是删除，第二个是修改，修改的界面为：</p>
		<div class="modal-content" style="width:60%">
				<div class="modal-header">
					<button type="button" class="close">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" >修改用户信息</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
								<div class="form-group">
	  <div class="form-group">
        <label >ID</label><br>
        <p ></p>
      </div>
      <div class="form-group">
        <label>用户名</label>
        <input type="text" class="form-control">
      </div>
      <div class="form-group">
        <label>年龄</label>
        <input type="number" class="form-control">
      </div>
      <div class="form-group">
			                        	<label for="form-sex">性别</label>
			                        	<select id="form-sex" name="sex" class="form-sex form-control">
											<option value="male">男</option>
											<option value="female">女</option>
										</select>
			                        </div>
      <div class="form-group">
        <label>城市</label>
        <input type="text" class="form-control" >
      </div>
      <div class="form-group">
        <label>国家</label>
        <input type="text" class="form-control" >
      </div>
      <div class="form-group">
        <label>Email</label>
        <input type="email" class="form-control" >
      </div>
      <div class="form-group">
        <label>手机号</label>
        <input type="text" class="form-control" >
        <div id="phonechecker">					
		</div>
      </div>
      <div class="form-group">
        <label>QQ号</label>
        <input type="text" class="form-control" >
      </div>
      <div class="form-group">
        <label>微信</label>
        <input type="text" class="form-control" >
      </div>
      <div class="form-group">
			                        	<label for="form-job">职业</label>
			                        	<input type="text" name="job" class="form-job form-control">
			                        </div>
      <div class="form-group">
        <label>用户身份</label>
			<select class="form-control" >
				<option>管理员</option>
				<option>用户</option>
			</select>
      </div>
								</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" >关闭</button>
					<button type="button" class="btn btn-primary" >保存</button>
				</div>
			</div>
		<p><br>支持修改全部的信息，但是在实际使用中，修改用户身份最为常见。
		</p>
		<p>问卷的部分有三个操作：删除、编辑和备份。<br>
		编辑界面：只支持问卷状态的修改。</p>
		<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" >
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" >修改问卷状态</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
							<form role="form">
								<div class="form-group">
									<label>Status</label>
									<select class="form-control" >
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
					<button type="button" class="btn btn-default" >关闭</button>
					<button type="button" class="btn btn-primary" >保存</button>
				</div>
			</div>
		<p><br>备份：
		<br>在点击备份之后，可以将该问卷的信息导出为txt格式文件。
		<br>问卷列表左下角有导入按钮，可导入此前导出的备份文件，用于恢复数据。
		<br>删除：删除指定问卷及其收集的答卷。</p>
		</div>
        <%} }%>
	</div>
	<hr style="color:black;border-top:1px solid #C0C0C0" >    
    <!-- Site footer -->
      <footer id="bottom" class="footer">
        <p>&copy; 2017 LZTR Group.</p>
      </footer>     
      	<script src="<%=path%>/questionnaire/js/jquery.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="<%=path%>/questionnaire/js/dataTables.bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootbox.min.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaire.js"></script>
	<script src="<%=path %>/questionnaire/js/jquery-ui.min.js"></script>
    </div> <!-- /container -->
    		            <script>
        $(window).scroll(function () {
            if ($(".navbar").offset().top > 50) {$(".navbar-fixed-top").addClass("top-nav");
            }else {$(".navbar-fixed-top").removeClass("top-nav");}
        })
        </script>
        <script>
        function showrele(){
        	var preblank = document.getElementById("preblank");
        	var preradio = document.getElementById("preradio");
        	if(!preradio.checked){
        		preblank.setAttribute("hidden",true);
        	}
        	else{
        		preblank.removeAttribute("hidden");
        	}
        }
        function changea(i){
        	var a = $("#a"+i);
        	if(a.html()=="收起本节"){
        		a.html("展开本节");
        	}
        	else{
        		a.html("收起本节");
        	}
        }
        </script>
  </body>
</html>
