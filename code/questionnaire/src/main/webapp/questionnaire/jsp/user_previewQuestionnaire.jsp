<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<%
	String path=request.getContextPath();
%>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>LZTR 问卷网</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=path %>/questionnaire/css/bootstrap3.3.7.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="<%=path %>/questionnaire/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<%=path %>/questionnaire/css/justified-nav.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="<%=path %>/questionnaire/js/ie-emulation-modes-warning.js"></script>
    <link href="<%=path %>/questionnaire/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%=path %>/questionnaire/css/jquery-ui.min.css" rel="stylesheet">
            <link rel="stylesheet" href="<%=path %>/questionnaire/css/validation.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="container">

		      <a style='floating:right' class="btn btn-default" href="MyQuestionnaire" type="button" style="floating:right">
			<i class="fa fa-mail-reply fa-2x">返回我的问卷</i>
		</a>
      
      <div id = "questionnaire"></div>
      <form id = "form"></form>
      <div id = "bin" hidden></div>
      <div class="row">&nbsp</div>
      <div align='center'>
      <button style='floating:right' class="btn btn-primary" onclick="wordexport()" type="button" style="floating:right">
			<i class="fa fa-download fa-2x">导出为.doc文件</i>
		</button>

		</div>

      <!-- Site footer -->
      <footer class="footer">
        <p>&copy; 2017 LZTR Group.</p>
      </footer>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="<%=path %>/questionnaire/js/ie10-viewport-bug-workaround.js"></script>
    <script src="<%=path %>/questionnaire/js/jquery-1.11.1.min.js"></script>
    <script src="<%=path %>/questionnaire/js/bootstrap.min.js"></script>
    <script src="<%=path %>/questionnaire/js/bootbox.min.js"></script>
    <script src="<%=path %>/questionnaire/js/jquery-ui.min.js"></script>
    <script src="<%=path %>/questionnaire/js/jquery.validate.min.js"></script>
    <script src="<%=path %>/questionnaire/js/messages_zh.js"></script>
    <script src="<%=path %>/questionnaire/js/previewQ.js"></script>
    <script src="<%=path %>/questionnaire/js/questionnaireExport.js"></script>
    <script src="<%=path %>/questionnaire/js/download.js"></script>
    <script>
	<%if(request.getParameter("quesid")==null){%>donothing();
	<%}else{%>getQ(<%=request.getParameter("quesid")%>);
	<%}%>
	</script>
  </body>
</html>