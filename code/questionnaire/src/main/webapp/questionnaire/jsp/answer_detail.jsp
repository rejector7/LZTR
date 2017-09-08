<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Answer" %>
<%@ page import="model.Questionnaire" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.AnswerSheet"%>
<%@ page import="model.QuestionnaireQuestions"%>
<%@ page import="model.User"%>
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
	    <link href="<%=path%>questionnaire/css/font-awesome.min.css" rel="stylesheet">
	         <link rel="<%=path%>stylesheet" href="questionnaire/css/validation.css">
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
		input{
			border:100px solid #000!important;
		}
    </style>
</head>
<body style="background:#F5F5F5" value="0">
<% 
User user = (User) session.getAttribute("user");
%>   
 <div class="bg jumbotron"><font size=5><strong>答卷详情</strong></font></div>
	<!-- 跳转标签 -->
	<div class="container">
      <div class="masthead">
      <p><strong id="quesid">问卷id：</strong></p>
      <p><strong id="quesname">问卷名：</strong></p>
      <p><strong id="userid">用户id：</strong></p> <!-- 判断是否是未登录用户填写的问卷 -->
      <button type='button' class='btn btn-default' onclick='downloadAnswerWord()'>导出为Word</button>
      </div>
    </div>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="dataTable_wrapper">
								<table class="table table-striped table-bordered table-hover"
									id="dataTables">
									<thead>
										<tr>
											<th>题号</th>
										    <th>题目</th>
										    <th>题型</th>
										    <th>是否必答</th>
											<th>回答</th>
										</tr>
									</thead>
									<tbody id="ASheet"></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
<!-- 问卷发起者添加留言反馈 -->
	<div id="replydiv">
	<form role="form" id="replyform">
    <div class="input-group">
      <input type="text" class="form-control" placeholder="留言反馈..." name="msg">
      <span class="input-group-btn">
      	<button class="btn btn-default" type='button' id="reply"><i class="fa fa-reply"></i></button>
      </span>
    </div>
    </form>
    </div>
    </div>
	<!-- js file -->
	<script src="<%=path%>/questionnaire/js/jquery.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="<%=path%>/questionnaire/js/dataTables.bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaire.js"></script>
	<script src="<%=path%>/questionnaire/js/bootbox.min.js"></script>
	<script src="<%=path%>/questionnaire/js/download.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaireExport.js"></script>
	<script src="<%=path%>/questionnaire/js/answer_detail.js"></script>
    	<script src="<%=path %>/questionnaire/js/jquery.validate.min.js"></script>
    	<script src="<%=path %>/questionnaire/js/messages_zh.js"></script>
    	     <link rel="stylesheet" href="<%=path %>/questionnaire/css/validation.css">
<!-- add date to table -->
<script>
	<%if(request.getParameter("ansid")!=null){%>
	getcontent(<%=request.getParameter("ansid")%>,<%=request.getParameter("quesid")%>);
	<%}%>
</script>
 <script>	
 $(function() { 
	 $("#replyform").submit(function(event){
		 event.preventDefault();
		 if($("input[name='msg']").val()==""){
			 bootbox.alert("请输入有效内容");
			 return false;
		 }
		var dataset = document.getElementById("reply").dataset;
 		var rid = dataset.rid;
 		var table = "<table class='table'>"+$("div.dataTable_wrapper").html()+"</table>";
 		var msg = "这是发送者针对您关于问卷"+$("#quesname").html().split("：")[1]+"的反馈"+"<br>";
 		msg += "您的回答情况："+table+"<br>";
 		msg += $("input[name='msg']").val();
			jQuery.ajax({
				type: "post",
				url : 'send2Message',
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
	 $("#reply").click(function(e){
		 if($("input[name='msg']").val()==""){
			 bootbox.alert("请输入有效内容");
			 return false;
		 }
		var dataset = e.currentTarget.dataset;
 		var rid = dataset.rid;
 		var table = "<table class='table'>"+$("div.dataTable_wrapper").html()+"</table>";
 		var msg = "这是发送者针对您关于问卷"+$("#quesname").html().split("：")[1]+"的反馈"+"<br>";
 		msg += "您的回答情况："+table+"<br>";
 		msg += $("input[name='msg']").val();
			jQuery.ajax({
				url : 'send2Message',
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
</body>
</html>