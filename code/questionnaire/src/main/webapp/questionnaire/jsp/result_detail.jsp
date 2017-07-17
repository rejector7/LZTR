<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<link href="<%=path%>/questionnaire/css/bootstrap-table.min.css" 	rel="stylesheet">
<link href="<%=path%>/questionnaire/css/font-awesome.min.css" 		rel="stylesheet" type="text/css">

<title>问卷统计结果</title>
</head>
<body>
	<!-- 跳转标签 -->
	<div class="container">
      <div class="masthead">
      <p><strong>问卷序号： </strong></p>
      <p><strong>问卷名字：</strong></p>
      <p><strong>问卷描述：</strong></p>
        <nav>
          <ul class="nav nav-justified">
            <li><a href="<%=path%>/questionnaire/jsp/result.jsp">统计数据</a></li>
            <li class="active"><a href="#">详细信息</a></li>
          </ul>
        </nav>
      </div>
    </div>
	
	<!-- 网页主体内容 -->
	<!-- 回答数据的列表 -->
	<!-- 使用后台json，js生成 -->
	<table id="answerList"><p>Answer List</p></table>
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- js file -->
	<script src="<%=path%>/questionnaire/js/jquery.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="<%=path%>/questionnaire/js/dataTables.bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootbox.min.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaire.js"></script>
	<script src="<%=path%>/questionnaire/js/bootstrap-table.min.js"></script>
	
	<script src="<%=path%>/questionnaire/js/result_detail.js"></script>	
	
</body>
</html>