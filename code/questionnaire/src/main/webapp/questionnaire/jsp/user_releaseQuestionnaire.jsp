<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="model.Questionnaire"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create your new Questionnaire!</title>

    <!-- Bootstrap core CSS -->
    <link href="questionnaire/css/bootstrap3.3.7.min.css" rel="stylesheet">
    <link href="questionnaire/css/font-awesome.min.css" rel="stylesheet">
  </head>

  <body value="0">

    <div class="container">
		<button class="btn btn-default addBlank" type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">Blank-filling Question</i>
		</button>
		<button class="btn btn-default addSingle"  type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">Single Option Question</i>
		</button>
		<button class="btn btn-default addMultiple"  type="button" style="floating:right">
				<i class="fa fa-plus  fa-2x">Multiple Option Question</i>
		</button>
		
		<div class="row">
			 <label ><font size="5">Title</font></label>
			 <input type="text" name="title"  class="form-control">
		</div>
		<div class="row">
			 <label  ><font size="5">Introduction</font></label>
			 <input type="text" name="introduction"  class="form-control">
		</div>
		
		<button class="btn btn-default submit" type="button" style="floating:right">
				<i class="fa fa-check fa-2x">confirm</i>
		</button>
		<button class="btn btn-default modify" type="button" style="floating:right">
				<i class="fa fa-check fa-2x">modify</i>
		</button>
    </div> <!-- /container -->
    
    	<script src="questionnaire/js/jquery-1.11.1.min.js"></script>
    <script src="questionnaire/js/bootstrap.min.js"></script>
	<script src="questionnaire/js/releaseQ.js"></script>
	<script>
	<%if(request.getAttribute("quescontent")!=null){%>
	modify(<%=request.getAttribute("quescontent") %>,<%=((Questionnaire)request.getAttribute("quesinfo")).getId() %>);
	<%}%>
	</script>

  </body>
</html>
