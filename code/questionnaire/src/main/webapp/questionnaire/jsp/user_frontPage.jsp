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
    <script src="<%=path %>/questionnaire/js/jquery.min.js"></script>
    <script src="<%=path %>/questionnaire/js/bootstrap.min.js"></script>
    <style type="text/css">
        html, body {width:100%;height:100%;}
        .bg {display: table;width: 100%;height: 30%;padding: 100px 0;text-align: center;color: #fff;background: url(questionnaire/img/homepage.jpg) no-repeat bottom center;background-color: #000;background-size: cover;}
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
<body style="background:#F5F5F5">
    <nav class="navbar navbar-fixed-top my-navbar" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="FrontPage"><font size=5>LZTR 问卷网</font></a>
            </div>
            <div class="collapse navbar-collapse" id="example-navbar-collapse">
                <ul class="nav navbar-nav">
				<% response.setCharacterEncoding("UTF-8"); 
					if(session.getAttribute("user")!=null){ %>				
				<% User user = (User)session.getAttribute("user"); String role = user.getRole();
				if(role.equals("admin")){ %>
				<li><a class="navbar-brand" href="<%=path %>/allUser"><span class="glyphicon glyphicon-wrench">系统信息管理</span></a></li>
				<%} }%>
                </ul>              
              <ul class="nav navbar-nav navbar-right">
              <% User user = (User)session.getAttribute("user");
              if(user==null){ %>
              <li data-toggle="modal" data-target="#signin-signup-tab" id="signin-button"><a href="loginPage" class="navbar-brand" >登录</a></li>
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
        <h1>免费在线问卷调查</h1>
        <p class="lead">免费，轻松的在线问卷网，欢迎您使用我们的系统来进行问卷调查，希望您能得到对于您工作或者学习有用的信息。</p>
        <p><a class="btn btn-lg btn-success" href="<%=path %>/ReleaseQuestionnaire" role="button">马上发布你的问卷！</a></p>
      </div>
    <div class="container">
    <%
		ArrayList<Questionnaire> quesListByTime = new ArrayList<Questionnaire>();
    quesListByTime = (ArrayList<Questionnaire>) request.getAttribute("quesByTime");
    int length = quesListByTime.size();
	%>  
	<div class="container">
	<div class="row">&nbsp</div>
 	<div class="row" style="float:left"><font size=5><strong>最新发布</strong></font></div> 	
 	<!--             <button class="btn btn-default addMultiple"  type="button" align="right" style="float:right;">
				<i class="fa fa-plus">查看更多</i> 
		</button>-->    
 	<hr>
<hr style="color:black;border-top:1px solid #C0C0C0" >
	  <!-- 此处代码需要修改，到时候项目基本完成后，需要修改为动态变化的（显示数据库中填写次数最多的前三个仍然开放的问卷） -->
      <!-- Example row of columns -->
      <div class="row">
      <div class="row col-lg-9">
      <div class="row">
      <%if(length>=3){ %>
      <%for(int i=0;i<3;i++){ %>    
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="FillQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro")%></font></p>
	</div></div>
        <%} %>
        <%}
      else{ 
      for(int i=0;i<length;i++){ %>     
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="FillQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro")%></font></p>
	</div></div>
        <%}%>
        <%}%>     
        </div>
        <%if(length>=6) {%>
              <div class="row">       
      <%for(int i=3;i<6;i++){ %>
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="FillQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro")%></font></p>
	</div></div>
        <%} %>
        </div></div>
        <%}
        else if(length>3){ %>
        <div class="row">
        <%for(int i=3;i<length;i++){ %>
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="FillQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro")%></font></p>
	</div></div>
        <%}%> 
        </div></div>
        <%}%>        
        <%if(length>6){%>
      <div class="col-lg-3">
      <ul class="list-group">
      <%if(length>12)length=12;
      for (int i = 6 ; i < length; i++){ %>     
      <li class="list-group-item" >
      <span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span>
      <a href="FillQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>"><%=quesListByTime.get(i).getTitle() %>
      </a></li>
      <%}%>
	<%} %>
      </ul>
      </div>
       </div></div>

	<div class="container">
	<div class="row">&nbsp</div>
 	<div class="row" style="float:left"><font size=5><strong>数据统计</strong></font></div> 	
 	<!--             <button class="btn btn-default addMultiple"  type="button" align="right" style="float:right;">
				<i class="fa fa-plus">查看更多</i> 
		</button>-->    
 	<hr>
 	<%
 	quesListByTime = (ArrayList<Questionnaire>) request.getAttribute("resultByTime");
    length = quesListByTime.size();
 	%>
<hr style="color:black;border-top:1px solid #C0C0C0" >
	  <!-- 此处代码需要修改，到时候项目基本完成后，需要修改为动态变化的（显示数据库中填写次数最多的前三个仍然开放的问卷） -->
      <!-- Example row of columns -->
      <div class="row">
      <div class="row col-lg-9">
      <div class="row">
      <%if(length>=3){ %>
      <%for(int i=0;i<3;i++){ %>    
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="getAnserByQuesidToStatistic?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro1")%></font></p>
	</div></div>
        <%} %>
        <%}
      else{ 
      for(int i=0;i<length;i++){ %>     
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="getAnserByQuesidToStatistic?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro1")%></font></p>
	</div></div>
        <%}%>
        <%}%>     
        </div>
        <%if(length>=6) {%>
              <div class="row">       
      <%for(int i=3;i<6;i++){ %>
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="getAnserByQuesidToStatistic?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro1")%></font></p>
	</div></div>
        <%} %>
        </div></div>
        <%}
        else if(length>3){ %>
        <div class="row">
        <%for(int i=3;i<length;i++){ %>
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="getAnserByQuesidToStatistic?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro1")%></font></p>
	</div></div>
        <%}%> 
        </div></div>
        <%}%>        
        <%if(length>6){%>
      <div class="col-lg-3">
      <ul class="list-group">
      <%if(length>12)length=12;
      for (int i = 6 ; i < length; i++){ %>     
      <li class="list-group-item" >
      <span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span>
      <a href="getAnserByQuesidToStatistic?quesid=<%=quesListByTime.get(i).getId()%>"><%=quesListByTime.get(i).getTitle() %>
      </a></li>
      <%}%>
	<%} %>
      </ul>
      </div>
       </div>
       </div>
<div class="container">
	<div class="row">&nbsp</div>
 	<div class="row" style="float:left"><font size=5><strong>问卷模板</strong></font></div> 	
 	<!--             <button class="btn btn-default addMultiple"  type="button" align="right" style="float:right;">
				<i class="fa fa-plus">查看更多</i> 
		</button>-->    
 	<hr>
 	<%
 	quesListByTime = (ArrayList<Questionnaire>) request.getAttribute("templateByTime");
    length = quesListByTime.size();
 	%>
 	<hr style="color:black;border-top:1px solid #C0C0C0" >
 	<div class="row">
      <div class="row col-lg-9">
      <div class="row">
      <%if(length>=3){ %>
      <%for(int i=0;i<3;i++){ %>    
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="TemplateQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro2")%></font></p>
	</div></div>
        <%} %>
        <%}
      else{ 
      for(int i=0;i<length;i++){ %>     
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="TemplateQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro2")%></font></p>
	</div></div>
        <%}%>
        <%}%>     
        </div>
        <%if(length>=6) {%>
              <div class="row">       
      <%for(int i=3;i<6;i++){ %>
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="TemplateQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro2")%></font></p>
	</div></div>
        <%} %>
        </div></div>
        <%}
        else if(length>3){ %>
        <div class="row">
        <%for(int i=3;i<length;i++){ %>
        <div class="col-lg-4">
        <div class="thumbnail" style="word-wrap:break-word;height:115px;overflow:hidden">
       <a href="TemplateQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>">
       <h3><span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span><%=quesListByTime.get(i).getTitle() %></h3>
       </a>
          <p><font color="#cccccc"><%=request.getAttribute(i+ "intro2")%></font></p>
	</div></div>
        <%}%> 
        </div></div>
        <%}%>        
        <%if(length>6){%>
      <div class="col-lg-3">
      <ul class="list-group">
      <%if(length>12)length=12;
      for (int i = 6 ; i < length; i++){ %>     
      <li class="list-group-item" >
      <span class="badge" align="left" style="float:left;align:left"><%=i+1 %></span>
      <a href="TemplateQuestionnaire?quesid=<%=quesListByTime.get(i).getId()%>"><%=quesListByTime.get(i).getTitle() %>
      </a></li>
      <%}%>
	<%} %>
      </ul>
      </div>
       </div>
 	</div>


<hr style="color:black;border-top:1px solid #C0C0C0">
      <!-- Site footer -->
      <footer class="footer">
        <p>&copy; 2017 LZTR Group.</p>
      </footer>
    <!-- /container -->
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