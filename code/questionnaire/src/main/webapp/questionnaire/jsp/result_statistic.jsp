<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Answer" %>
<%@ page import="model.Questionnaire" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<%
	String path=request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=path%>/questionnaire/css/bootstrap.min.css" 			rel="stylesheet">
<link href="<%=path%>/questionnaire/css/dataTables.bootstrap.css" 	rel="stylesheet">
<link href="<%=path%>/questionnaire/css/dataTables.responsive.css" 	rel="stylesheet">
<link href="<%=path%>/questionnaire/css/questionnaire.css" 			rel="stylesheet">
<link href="<%=path%>/questionnaire/css/justified-nav.css" 			rel="stylesheet">

<link href="<%=path%>/questionnaire/css/font-awesome.min.css" 		rel="stylesheet" type="text/css">

<title>问卷统计结果</title>
</head>
<body>
	<div class="container">
		<a href="MyQuestionnaire">
			<button class="btn btn-default" type="button">
				<strong>返回“我的问卷”</strong>
			</button>
		</a>
	</div>
	</br>
	
	<!-- 获取问卷信息 -->
	<%
		Questionnaire ques = new Questionnaire();
		ques = (Questionnaire)request.getAttribute("quesinfo");
	%>

	
	<!-- 跳转标签 -->
	<div class="container">
      <div class="masthead">
      <p id="jpegtip"></p>
      <button type='button' class='btn btn-default' onclick='downloadjpeg("<%=ques.getId() %>","<%=ques.getTitle()%>")'>下载jpeg文件</button>
      <button type='button' class='btn btn-default' onclick='downloadxml("<%=ques.getId() %>","<%=ques.getTitle()%>")'>下载xml文件</button>
      
      
        <nav>
          <ul class="nav nav-justified">
            <li class="active"><a href="#">统计数据</a></li>
            <li><a href="getAnswerByQuesid?quesid=<%=ques.getId() %>">详细信息</a></li> 
          </ul>
        </nav>
      </div>
    </div>
    
    <div id="container" class="container" style="background-color:#f8f8f8">
    <p><strong>问卷序号：<%=ques.getId() %></strong></p>
      <p><strong>问卷名字：<%=ques.getTitle() %></strong></p>
    </div>
	

		
	<!-- js file -->
	<script src="<%=path%>/questionnaire/js/jquery.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="<%=path%>/questionnaire/js/dataTables.bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaire.js"></script>
	<script src="<%=path%>/questionnaire/js/bootbox.min.js"></script>
		<script src="<%=path%>/questionnaire/js/Chart.js"></script>
	<script src="<%=path%>/questionnaire/js/download.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaireExport.js"></script>
	 
	<script src="<%=path%>/questionnaire/js/html2canvas.js"></script>
	<script src="<%=path%>/questionnaire/js/result_statistic.js"></script>	
	
	<script>
		$(document).ready(function() {
			$('#dataTables').DataTable({
				responsive : true
			});
		});
		getStatistic(<%=ques.getId() %>);
	</script>
	
</body>
</html>