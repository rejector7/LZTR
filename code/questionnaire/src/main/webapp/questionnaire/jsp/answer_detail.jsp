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
	<!-- 跳转标签 -->
	<div class="container">
      <div class="masthead">
      <p><strong id="quesid">问卷id：</strong></p>
      <p><strong id="quesname">问卷名：</strong></p>
      <p><strong id="userid">用户id：</strong></p> <!-- 判断是否是未登录用户填写的问卷 -->
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
		
	
	<!-- 问卷发起者添加留言反馈 -->
	<form role="form">
    <div class="input-group">
      <input type="text" class="form-control" placeholder="留言反馈..." name="msg">
      <span class="input-group-btn">
      	<button class="btn btn-default" type='button' id="reply"><i class="fa fa-reply"></i></button>
      </span>
    </div>
    </form>
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
	<%if(request.getParameter("ansid")!=null){%>
	getcontent(<%=request.getParameter("ansid")%>,<%=request.getParameter("quesid")%>);
	
	<%}%>
</script>
 <script>	
 $(function() { 
    	$("#reply").click(function(e){
    		var dataset = e.currentTarget.dataset;
    		var rid = dataset.rid;
    		var msg = $("input[name='msg']").val();
			console.log(msg);
			jQuery.ajax({
				url : 'send2Message',
				processData : true,
				dataType : "text",
				data : {
					rid : rid,
					msg : msg
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