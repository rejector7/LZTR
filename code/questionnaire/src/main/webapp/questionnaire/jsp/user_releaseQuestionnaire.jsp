<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="model.Questionnaire"%>
<%@ page import="model.User"%>
<%
	String path=request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<meta charset="utf-8" />
        <title>LZTR 问卷网</title>
    <!-- Bootstrap core CSS -->
	<link href="<%=path%>/questionnaire/css/bootstrap.min.css" 			rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/dataTables.bootstrap.css" 	rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/dataTables.responsive.css" 	rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/questionnaire.css" 			rel="stylesheet">
	<link href="<%=path%>/questionnaire/css/font-awesome.min.css" 		rel="stylesheet" type="text/css">
    <!-- Bootstrap core CSS -->
    <link href="<%=path %>/questionnaire/css/bootstrap3.3.7.min.css" rel="stylesheet">
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    	<script src="questionnaire/js/jquery.min.js"></script>
    	<script src="questionnaire/js/jquery.validate.min.js"></script>
    	<script src="<%=path %>/questionnaire/js/messages_zh.js"></script>
    	     <link rel="stylesheet" href="questionnaire/css/validation.css">
	<script src="questionnaire/js/jquery.dataTables.min.js"></script>
	<script src="questionnaire/js/dataTables.bootstrap.min.js"></script>
		<script src="questionnaire/js/bootstrap.min.js"></script>
		<script src="questionnaire/js/bootbox.min.js"></script>
	    <link href="questionnaire/css/font-awesome.min.css" rel="stylesheet">
	         <link rel="stylesheet" href="questionnaire/css/validation.css">
    <style type="text/css">
        html, body {width:100%;height:100%;}
        .bg {display: table;width: 100%;height: 10%;padding: 40px 0;text-align: center;color: #fff;background: url(questionnaire/img/homepage.jpg) no-repeat bottom center;background-color: #000;background-size: cover;}
        .my-navbar {padding:20px 0;transition: background 0.5s ease-in-out, padding 0.5s ease-in-out;}
        .my-navbar a{background:transparent !important;color:#fff !important}
        .my-navbar a:hover {color:#45bcf9 !important;background:transparent;outline:0}
        .my-navbar a {transition: color 0.5s ease-in-out;}
        .top-nav {padding:0;background:#000;}
        button.navbar-toggle {background-color:#fbfbfb;}
        button.navbar-toggle > span.icon-bar {background-color:#dedede}
        .dropdown-nemu>li>a{color:#333!important;display:block!important;}
		.mydiv{
		width:250px;height:auto;border:#909090 1px solid;background:#fff;color:#333;
		filter:progid:DXImageTransform.Microsoft.Shadow(color=#909090,direction=120,strength=3);
		-moz-box-shadow: 2px 2px 10px #909090;
		-webkit-box-shadow: 2px 2px 10px #909090;
		box-shadow:2px 2px 10px #909090;
		}
		input{
			border:100px solid #000!important;
		}
    </style>
</head>
<body style="background:#F5F5F5" value="0">
<% 
User user = (User) session.getAttribute("user");
%>
    <nav class="navbar navbar-fixed-top my-navbar" role="navigation">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="example-navbar-collapse">
                <form class="navbar-form navbar-left" role="search" action="searchPro" accept-charset="UTF-8">
			      		<button class="btn btn-default submit" type="button" style="float:right">
				<i class="fa fa-save" >保存</i>
		</button>
		<button class="btn btn-default cancel" type="button" style="float:right">
				<i class="fa fa-mail-reply">退出</i>
		</button>
		<button class="btn btn-default preview" type="button" style="float:right">
				<i class="fa fa-eye">预览</i>
		</button>
		<button class="btn btn-default publish" type="button" style="float:right">
				<i class="fa fa-paper-plane">
				<%if(request.getAttribute("quesinfo")!=null){%>
				重发布
				<%} else{%>
				发布<%} %></i>
		</button>
                </form>
                     <form class="navbar-form navbar-right" role="search" action="searchPro" accept-charset="UTF-8">
		<button class="btn btn-default addBlank" type="button" style="float:right;">
				<i class="fa fa-plus  ">填空题</i>
		</button>
		<button class="btn btn-default addSingle"  type="button" style="float:right;">
				<i class="fa fa-plus  ">单选题</i>
		</button>
		<button class="btn btn-default addMultiple"  type="button" style="float:right;">
				<i class="fa fa-plus  ">多选题</i>
		</button>
		<button class="btn btn-default addSlider"  type="button" style="float:right;">
				<i class="fa fa-plus ">滑块题</i>
		</button>
              		</form> 
            </div>
        </div>
    </nav>
  <div class="bg jumbotron">
        <p><font size='10'>编辑问卷</font></p>
      </div>
    <div class="container" ><br>
		<div class="row ">
			 <label ><font size="5">标题</font></label>
			 <input type="text" name="title"  class="form-control" maxlength="255">
		</div>
		<div class="row">
			 <label  ><font size="5">简介</font></label>
			 <input type="text" name="introduction"  class="form-control">
		</div><br>
		<div class="row">
			 <input type="checkbox" id="allowDup" checked>
			 <label ><font size="5">允许同一IP重复作答</font></label>
		</div>
		<div class="row">
			 <input type="checkbox" id="resultPublished" checked>
			 <label ><font size="5">允许统计结果公开在首页</font></label>
		</div>
		<hr style="color:black;border-top:1px solid #C0C0C0">
		 	<div class="row"  style="float:left"><font size=5><strong>添加题目</strong></font></div>
		<br><hr>
    </div > <!-- /container -->
    <div class="modal fade" id="modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="modalTitle"></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
						<form id="form2">
							<div class="form-group">
								<label>是否公开</label>
								<select class="form-control" id="selectf1" name ="ispublic">
										<option selected>是</option>
										<option>否</option>
								</select>
								</div>
								<div class="form-group">
									<label>发布时间</label>
									<input class="form-control" name="releasetime" type="date" oninput="statechanger()" required>
									<p id="starta"></p>
								</div>
								<div class="form-group">
									<label>结束时间（若不设定可不填写）</label>
									<input class="form-control" name="endtime" type="date" oninput="statechanger()">
									<p id="enda"></p>
								</div>
								<div class="form-group">
									<label>当前状态:</label>
									<p id="state">已发布</p>
								</div>
						</form>
						</div></div></div>
						<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="publishconfirm">确认</button>
				</div>
			</div>
		</div>
	</div>
	 <div class="modal fade" id="modal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" id="relacloser">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="modalTitle"></h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
						<form id="form3">
							<div class="form-group">
								<label>选择想要关联的问题</label>
								<select class="form-control" id="formerques" onchange="releopts()">
								</select>
							</div>
							<label>当以下选项被选中时</label>
							<div class="form-group" id="specoptiondiv">
							</div>
							<label>本问题会出现。</label><br>
							<label>将本关联复制到后续问题: </label>
							<div class="form-group" id="laterques">
							</div>
						</form>
						</div></div></div>
						<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="relatconfirm">确认</button>
				</div>
			</div>
		</div>
	</div>
    <script src="questionnaire/js/jquery-ui.min.js"></script>
	<script src="questionnaire/js/releaseQ.js"></script>
	<script>
	<%if(request.getAttribute("quesinfo")!=null){%>
	update(<%=((Questionnaire)request.getAttribute("quesinfo")).getId() %>);
	<%}%>
	</script>
        <script>
        $(window).scroll(function () {
            if ($(".navbar").offset().top > 50) {$(".navbar-fixed-top").addClass("top-nav");
            }else {$(".navbar-fixed-top").removeClass("top-nav");}
        })
        </script>
  </body>
</html>
