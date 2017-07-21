<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Answer" %>
<%@ page import="model.Questionnaire" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.AnswerSheet"%>
<%@ page import="model.QuestionnaireQuestions"%>
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
	<!-- 获取问卷问题信息 -->
	<%
	QuestionnaireQuestions Qques = new QuestionnaireQuestions();
		Qques = (QuestionnaireQuestions)request.getAttribute("Qques");
		String name = (String)request.getAttribute("name");
	%>
	<!-- 从request获取answer sheet数据 -->
	<%
		AnswerSheet anst = new AnswerSheet();
				anst = (AnswerSheet)request.getAttribute("anst");
	%>
	
	
	
	
	<!-- 跳转标签 -->
	<div class="container">
      <div class="masthead">
      <p><strong>问卷id：<%=Qques.getQuesid()%></strong></p>
      <p><strong>问卷名：<%=name%></strong></p>
      <p><strong>用户id：<%=anst.getUserid()==0 ? "NULL" : anst.getUserid()%></strong></p> <!-- 判断是否是未登录用户填写的问卷 -->
      <button type='button' class='btn btn-default' onclick='downloadthis()'>下载doc文件</button>
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


<!-- add date to table -->
<script>
	Execute(<%=Qques.getContent()%>, <%=anst.getContent()%>);
</script>
</body>
</html>