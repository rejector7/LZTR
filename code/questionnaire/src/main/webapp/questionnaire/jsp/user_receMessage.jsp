<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Message"%>
<!DOCTYPE html>

<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>LZTR 问卷网</title>
	<%
	String path=request.getContextPath();
	%>
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

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
	<%
		ArrayList<Message> messages = new ArrayList<Message>();
		if (request.getAttribute("ReceMessages") != null) {
			messages = (ArrayList<Message>) request.getAttribute("ReceMessages");
		}
	%>
    <div class="container">

      <!-- The justified navigation menu is meant for single line per list item.
           Multiple lines will require custom code not provided by Bootstrap. -->
      <div class="masthead">
        <h1 class="text-muted">LZTR 问卷网 </h1>
        <nav>
          <ul class="nav nav-justified">
            <li><a href="<%=path %>/FrontPage">首页</a></li>
            <li><a href="<%=path %>/SelfInfo">个人信息</a></li>
            <li><a href="<%=path %>/MyQuestionnaire">我的问卷</a></li>
            <li><a href="<%=path %>/ReleaseQuestionnaire">问卷发布</a></li>
            <li><a href="<%=path %>/FillQuestionnaire">填写问卷</a></li>
            <li class="active"><a href="<%=path %>/allSendMessage">消息</a></li>
            <li><a href="<%=path %>/HelpContact">帮助</a></li>
            
            <li><a href="<%=path %>/logoutPro">登出</a></li>
            <%if(((String)session.getAttribute("role")).equals("admin")){%>
				<li><a href="<%=path %>/allUser" ></i>系统信息管理</a></li>
			<%}%>
          </ul>
        </nav>
      </div>


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
		<!-- 使用列表的形式将所有收到的消息都显示出来 -->
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
		
<%
for(int i = 0; i < messages.size(); ++i){
	Message msg = messages.get(messages.size()-1-i);
%> 				
	<div class="panel panel-default">
        <div class="panel-heading">
        	<h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=i%>">
                	From&nbsp;&nbsp;:&nbsp;&nbsp;  <%=msg.getSid() %>; &nbsp;&nbsp;&nbsp;    发送时间：<%=msg.getSenddate() %>
                </a>
            </h4>
            
            <%if(msg.getIsread() == 0) {%>
            <div>
      			<i class="fa fa-yelp"></i>
     		</div>
     		<%} %>
        </div>
        <div id="collapse<%=i%>" class="panel-collapse collapse <%=(msg.getIsread()==0?"in":"")%>">
            <div class="panel-body">
                消息内容：<br/>
         <%=msg.getMsg()%>
            </div>
        </div>
    
    <form id="replyform" role="form" action="send1Message" method="POST" onsubmit="return saveReport();">
    <div class="input-group">
      <input type="text" class="form-control" placeholder="回复消息..." name="msg">
      <input type="hidden" name="sid" value=<%=msg.getSid() %>>
      <span class="input-group-btn">
      	<button class="btn btn-default reply" type="submit"><i class="fa fa-reply"></i></button>
      </span>
    </div>
    </form>
    </div>
    <br/>
<%} %>

<script>
function saveReport() {  
    $("#replyform").ajaxSubmit(function(message) {  
       });  
    location.reload();
    return false;
}  
</script>
					
				</div>
			</div>
		</div>
	
	<script src="<%=path%>/questionnaire/js/jquery.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="<%=path%>/questionnaire/js/dataTables.bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootbox.min.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaire.js"></script>


	  
	  
	  

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="<%=path %>/questionnaire/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>