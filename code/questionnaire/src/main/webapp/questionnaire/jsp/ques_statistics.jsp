<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Answer" %>
<%@ page import="model.AnswerSheet" %>
<%@ page import="model.QuestionnaireQuestions" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="net.sf.json.*"%>
<%@ page import="java.awt.Font" %>
<%@ page import="javax.swing.JFrame" %>
  
<%@ page import="org.jfree.chart.*" %>
<%@ page import="org.jfree.data.*" %> 

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
      <p><strong>问卷序号：</strong></p> 	<!-- 注：需要一个变量来保存quesid，在统计数据和详细信息两个页面中都需要，而最开始这个数据应该在我的问卷之类的 -->
      <p><strong>问卷名字：</strong></p>		<!-- 可以查看问卷结果的地方拿到，故感觉可以在查看问卷结果的action里面，存一手session之类的值 -->
      <p><strong>问卷描述：</strong></p>
        <nav>
          <ul class="nav nav-justified">
            <li class="active"><a href="#">统计数据</a></li>
            <li><a href="<%=path%>/questionnaire/jsp/result_detail.jsp">详细信息</a></li>  <!-- quesid 需要后期修改，这里只是测试 -->
          </ul>
        </nav>
      </div>
    </div>
	
	<!-- 从request获取answer数据 -->
	<%
		QuestionnaireQuestions questionnaireQuestions;
			if (request.getAttribute("questionnaireQuestions") != null) {
		questionnaireQuestions = (QuestionnaireQuestions) request.getAttribute("questionnaireQuestions");
		String questionsContent=questionnaireQuestions.getContent();
		JSONObject jsonQuestionsContent= JSONObject.fromObject(questionsContent);
		JSONArray jsonQuestions = jsonQuestionsContent.getJSONArray("questions");
			}
	
		ArrayList<Answer> answers = new ArrayList<Answer>();
			if (request.getAttribute("answers") != null) {
		answers = (ArrayList<Answer>) request.getAttribute("answers");
			}
			ArrayList<AnswerSheet> answerSheets = new ArrayList<AnswerSheet>();
			if (request.getAttribute("answersheets") != null) {
		answerSheets = (ArrayList<AnswerSheet>) request.getAttribute("answersheets");
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
								<%
										int questionNumber=0;
										for (Iterator<Object> iterator= jsonQuestions.iterator();iterator.hasNext();){
											questionNumber+=1;
											JSONObject eachQuestion = JSONObject(iterator.next());
											String stem=eachQuestion.getString("stem");
											String required=eachQuestion.getString("required");
											String type=eachQuestion.getString("type");
											%>
											<p>第<%= questionNumber %>题:
											<% System.out.print(stem);
												System.out.print(type);%>
											</p>
											<%
											if(type="Single"){
												int optionNum=options.length();
												JSONArray options=eachQuestion.getJSONArray("options");
												ArrayList<String> optionContent=new ArrayList<String>();
												ArrayList<Integer> optionEachNumber = new ArrayList<Integer>();
												ArrayList<Double> optionRatio= new ArrayList<Double>();
												int optionIndex=0;
												for(Iteratr<Object> iterator= options.iterator();iterator.hasNext();){
													optionContent.add(iterator.getString("option"));
													
												}
												
												for (int i = 0; i < answerSheets.size(); i++) {
													AnswerSheet answerSheet = answerSheets.get(i);
													String sheetContent=answerSheet.getContent();
													JSONObject jsonSheetContent = JSONObject.fromObject(sheetContent);
													JSONArray jsonAnswers=jsonSheetContent.getJSONArray("answers");
													JSONObject kAnswer=jsonAnswers.getJSONObject(k);//it is ok?
													String option= kAnswer.getString("option");
													int numberIndex=0;
													for(int index=0;index<optionNum;index++){
														if(optionContent.get(index)==option){
															numberIndex=index;
															break;
														}
														else continue;
													}
													optionEachNumber.set(numberIndex,optionEachNumber.get(numberIndex)+1);
												}
												int numSum=0;
												for(int index=0;index<optionNum;index++){
													numSum+=optionEachNumber.get(index);
												}
												for(int ratioIndex=0;ratioIndex<optionNum;ratioIndex++){
													optionRatio.set(ratioIndex,(optionEachNumber.get(ratioIndex))/numSum);
												}
											}
											%>
											<table>
												<tr>
													<th>选项</th><th>小计</th><th>比例</th>
												</tr>
												<%
													for(int option=0;option<optionNum;option++){
														%>
														<tr>
														<td><%= optionContent.get(option) %></td>
														<td><%= optionEachNumber.get(option) %></td>
														<td><%= optionRatio.get(option) %></td>
														</tr>
														<%
													}
												%>
											</table>
											<%
											DefaultCategoryDataset catagoryDataset=new DefaultCategoryDataset();
											 DefaultPieDataset pieDataset = new DefaultPieDataset();  
											for(int barNum=0;barNum<optionNum;barNum++){
												catagoryDataset.addValue(optionEachNumber[barNum],null,optionContent[option]);
												pieDataset.addValue(optionEachNumber[barNum],optionContent[option]);
												
											}
												JFreeChart barChart=ChartFactory.createBarChart("柱状图", "选项", "数量", catagoryDataset);
												JFreeChart pieChart=ChartFactory.createPieChart("饼状图",pieDataset,true,false,false);
												
												if(type="Multiple"){
													int optionNum=options.length();
													JSONArray options=eachQuestion.getJSONArray("options");
													ArrayList<String> optionContent=new ArrayList<String>();
													ArrayList<Integer> optionEachNumber = new ArrayList<Integer>();
													ArrayList<Double> optionRatio= new ArrayList<Double>();
													int optionIndex=0;
													for(Iteratr<Object> iterator= options.iterator();iterator.hasNext();){
														optionContent.add(iterator.getString("option"));
														
													}
													
													for (int i = 0; i < answerSheets.size(); i++) {
														AnswerSheet answerSheet = answerSheets.get(i);
														String sheetContent=answerSheet.getContent();
														JSONObject jsonSheetContent = JSONObject.fromObject(sheetContent);
														JSONArray jsonAnswers=jsonSheetContent.getJSONArray("answers");
														JSONObject kAnswer=jsonAnswers.getJSONObject(k);//it is ok?
														JSONArray options= kAnswer.getJSONArray("options");
														ArrayList<Integer> optionIndexArray=new ArrayList<Integer>();
														for(int j=0;j<options.length();j++){
															String option= options.getJSONObject(j).getString("option");
															
														for(int index=0;index<optionNum;index++){
															if(optionContent.get(index)==option){
																optionIndexArray.set(j,index);//获取一个多选题答案选项的数组
																break;
															}
															else continue;
														}
														}
														for(int index = 0; index<options.length();index++){
															optionEachNumber.set(optionIndexArray.get(index),optionEachNumber.get(optionIndexArray.get(index))+1);
														}
														
													}
													int numSum=0;
													for(int index=0;index<optionNum;index++){
														numSum+=optionEachNumber.get(index);
													}
													for(int ratioIndex=0;ratioIndex<optionNum;ratioIndex++){
														optionRatio.set(ratioIndex,(optionEachNumber.get(ratioIndex))/numSum);
													}
												}
												%>
												<table>
													<tr>
														<th>选项</th><th>小计</th><th>比例</th>
													</tr>
													<%
														for(int option=0;option<optionNum;option++){
															%>
															<tr>
															<td><%= optionContent.get(option) %></td>
															<td><%= optionEachNumber.get(option) %></td>
															<td><%= optionRatio.get(option) %></td>
															</tr>
															<%
														}
													%>
												</table>
												<%
												DefaultCategoryDataset catagoryDataset=new DefaultCategoryDataset();
												 DefaultPieDataset pieDataset = new DefaultPieDataset();  
												for(int barNum=0;barNum<optionNum;barNum++){
													catagoryDataset.addValue(optionEachNumber[barNum],null,optionContent[option]);
													pieDataset.addValue(optionEachNumber[barNum],optionContent[option]);
													
												}
													JFreeChart barChart=ChartFactory.createBarChart("柱状图", "选项", "数量", catagoryDataset);
													JFreeChart pieChart=ChartFactory.createPieChart("饼状图",pieDataset,true,false,false);
											%>
											
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