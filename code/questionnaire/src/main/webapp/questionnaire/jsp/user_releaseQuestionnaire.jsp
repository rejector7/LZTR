<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>LZTR 问卷网</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap3.3.7.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../css/justified-nav.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="container">

      <!-- The justified navigation menu is meant for single line per list item.
           Multiple lines will require custom code not provided by Bootstrap. -->
      <div class="masthead">
        <h1 class="text-muted">LZTR 问卷网 </h1>
        <nav>
          <ul class="nav nav-justified">
            <li><a href="user_frontPage.jsp">			首页</a></li>
            <li><a href="user_selfInfo.jsp">			个人信息	</a></li>
            <li><a href="user_myQuestionnaire.jsp">		我的问卷	</a></li>
            <li class="active"><a href="">问卷发布</a></li>
            <li><a href="user_fillQuestionnaire.jsp">	填写问卷	</a></li>
            <li><a href="user_helpContact.jsp">			帮助		</a></li>
          </ul>
        </nav>
      </div>

      <!-- Jumbotron -->
      <div class="jumbotron">
        <h1>免费在线问卷调查</h1>
        <p class="lead">免费，轻松的在线问卷网，欢迎您使用我们的系统来进行问卷调查，希望您能得到对于您工作或者学习有用的信息。</p>
        <p><a class="btn btn-lg btn-success" href="#" role="button">马上发布你的问卷！</a></p>
      </div>
	  
	  <div class="jumbotron">
          <h1>时下热门</h1>
	  </div>
	  <!-- 此处代码需要修改，到时候项目基本完成后，需要修改为动态变化的（显示数据库中填写次数最多的前三个仍然开放的问卷） -->
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-lg-4">
          <h2>大学生作息时间调查</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn btn-primary" href="#" role="button">填写问卷 &raquo;</a></p>
        </div>
        <div class="col-lg-4">
          <h2>编程语言使用调查</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn btn-primary" href="#" role="button">填写问卷 &raquo;</a></p>
       </div>
        <div class="col-lg-4">
          <h2>上海交大软件学院学生心理调查问卷</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa.</p>
          <p><a class="btn btn-primary" href="#" role="button">填写问卷 &raquo;</a></p>
        </div>
      </div>

      <!-- Site footer -->
      <footer class="footer">
        <p>&copy; 2017 LZTR Group.</p>
      </footer>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
