<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Message"%>
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
       	<div class="row" style="float:left"><font size=5><strong>我的消息</strong></font></div>

 	<hr>
<hr style="color:black;border-top:1px solid #C0C0C0" >
  	<%
		ArrayList<Message> messages = new ArrayList<Message>();
		if (request.getAttribute("SendMessages") != null) {
			messages = (ArrayList<Message>) request.getAttribute("SendMessages");
		}
		
		ArrayList<String> names = new ArrayList<String>();
		if (request.getAttribute("Names") != null) {
			names = (ArrayList<String>) request.getAttribute("Names");
		}
	%>

      <!-- The justified navigation menu is meant for single line per list item.
           Multiple lines will require custom code not provided by Bootstrap. -->
 

	  
	 <div class="navbar-default sidebar" role="navigation">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">
					<li><a href="allSendMessage"><i 
							class="fa fa-send fa-fw"></i> 已发送</a></li>
					<li><a href="allReceMessage"><i 
							class="fa fa-comment fa-fw"></i> 收到</a></li>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>	
		<br/>
		
		<!-- 使用列表的形式将所有发送的消息都显示出来 -->
		<div id="page-wrapper" style="background:#F5F5F5">
			<div class="row" >
				<div class="col-lg-12" ></br>
			
<%
for(int i = 0; i < messages.size(); ++i){
	Message msg = messages.get(messages.size()-1-i);
	String name = names.get(messages.size()-1-i);
%> 				
	<div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=i%>">
                	发送至&nbsp;&nbsp;:&nbsp;&nbsp;  <%=name %>; &nbsp;&nbsp;&nbsp;    发送时间：<%=msg.getSenddate() %>
                </a>
            </h4>
        </div>
        <div id="collapse<%=i%>" class="panel-collapse collapse <%=(i==0?"in":"")%>">
            <div class="panel-body">
                消息内容：<br/>
         <%=msg.getMsg()%>
            </div>
        </div>
    
    <form class="replyform" role="form" >
    <div class="input-group">
      <input type="text" class="form-control" placeholder="继续留言..." name="msg">
      <input type="hidden" name="rid" value=<%=msg.getRid() %>>
      <span class="input-group-btn">
      	<button class="btn btn-default reply" type="submit"><i class="fa fa-reply"></i></button>
      </span>
    </div>
    </form>
    </div>
    <br/>
<%} %>


					
				</div>
			</div>
		</div>
	
	<script src="<%=path%>/questionnaire/js/jquery.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="<%=path%>/questionnaire/js/dataTables.bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootbox.min.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaire.js"></script>
<script src="<%=path%>/questionnaire/js/jquery.min.js"></script>
	
<script>
$(function() { 
	 $(".replyform").submit(function(event){
		 event.preventDefault();
		 var form = event.currentTarget;
		 var rid = form.getElementsByTagName("INPUT")[1].getAttribute("value");
	 	 var msg = form.getElementsByTagName("INPUT")[0].value;
		 if(msg==""){
			 bootbox.alert("请输入有效内容");
			 return false;
		 }
			jQuery.ajax({
				type: "post",
				url : 'send1Message',
				processData : true,
				dataType : "text",
				data : {
					rid : rid,
					msg : encodeURI(msg)
				},
				success : function(data) {
					bootbox.alert({
						message : '发送成功! ',
						callback : function() {
							location.reload();
						}
					});
				}
			});
			
	 });
});
</script>
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