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
      <p><strong>问卷序号： </strong></p>
      <p><strong>问卷名字：</strong></p>
      <p><strong>问卷描述：</strong></p>
        <nav>
          <ul class="nav nav-justified">
            <li class="active"><a href="#">统计数据</a></li>
            <li><a href="<%=path%>/questionnaire/jsp/result_detail.jsp">详细信息</a></li>
          </ul>
        </nav>
      </div>
    </div>

</body>
</html>