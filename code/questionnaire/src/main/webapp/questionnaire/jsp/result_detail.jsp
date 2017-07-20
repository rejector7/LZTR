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
      <p><strong>问卷序号：<%=ques.getId() %></strong></p>
      <p><strong>问卷名字：<%=ques.getTitle() %></strong></p><!-- request().getRemoteAddr()可以拿到ip地址  -->
        <nav>
          <ul class="nav nav-justified">
            <li><a href="#">统计数据</a></li>
            <li class="active"><a href="#">详细信息</a></li> 
          </ul>
        </nav>
      </div>
    </div>
	
	<!-- 从request获取answer数据 -->
	<%
		ArrayList<Answer> answers = new ArrayList<Answer>();
			if (request.getAttribute("answers") != null) {
		answers = (ArrayList<Answer>) request.getAttribute("answers");
			}
	%>
	<!-- 网页主体内容 -->
	<!-- 回答数据的列表 -->
	<!-- 使用后台json，js生成 -->
		<div class="container">
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<!-- /.panel-heading -->
						<div class="panel-body">
							<div class="dataTable_wrapper">
								<table class="table table-striped table-bordered table-hover"
									id="dataTables">
									<thead>
										<tr>
										    <th>ID</th>
											<th>回答时间</th>
											<th>IP 地址</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<%
											for (int i = 0; i < answers.size(); i++) {
																				Answer answer = answers.get(i);
										%>
										<tr>
										    <td><%=answer.getId()%></td>
											<td><%=answer.getTime()%></td>
											<td>hhh</td> <!-- need to be changed later -->
											<td>
												<a class="btn btn-default" href="getQuesAndAnsStatistic?id=<%=answer.getId()%> & quesid=<%=ques.getId() %>" role="button" target="_blank"><i class="fa fa-search"></i>回答详细情况</a>
												<button class="btn btn-default delete" type="button"
													data-id="<%=answer.getId()%>">
													<i class="fa fa-trash"></i>
												</button>
											</td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
		</div>
		
	<!-- js file -->
	<script src="<%=path%>/questionnaire/js/jquery.min.js"></script>
	<script src="<%=path%>/questionnaire/js/bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="<%=path%>/questionnaire/js/dataTables.bootstrap.min.js"></script>
	<script src="<%=path%>/questionnaire/js/questionnaire.js"></script>
	<script src="<%=path%>/questionnaire/js/bootbox.min.js"></script>
	
	
	<script src="<%=path%>/questionnaire/js/result_detail.js"></script>	
	
	<script>
		$(document).ready(function() {
			$('#dataTables').DataTable({
				responsive : true
			});
		});
	</script>
	
</body>
</html>