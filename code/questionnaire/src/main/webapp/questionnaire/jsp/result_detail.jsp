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
<link href="<%=path%>/questionnaire/css/justified-nav.css" 		rel="stylesheet">
<link href="<%=path%>/questionnaire/css/font-awesome.min.css" 		rel="stylesheet" type="text/css">

<title>问卷统计结果</title>
</head>
<body>
	<div class="container">
      <div class="masthead">
      <h1>此处填写该问卷部分信息（问卷名字，序号，描述等）</h1>
      <p>问卷序号： </p>
      <p>问卷名字：</p>
      <p>问卷描述：</p>
        <nav>
          <ul class="nav nav-justified">
            <li><a href="<%=path%>/questionnaire/jsp/result.jsp">统计数据</a></li>
            <li class="active"><a href="#">详细信息</a></li>
          </ul>
        </nav>
      </div>
    </div>

</body>
</html>