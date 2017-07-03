<!DOCTYPE html>
<html lang="en">

    <head>
		<%
	String path=request.getContextPath();
	%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login Questionnaire Website!</title>

        <!-- CSS -->
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/css.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=path %>/questionnaire/css/form-elements.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/style.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="<%=path %>/questionnaire/img/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=path %>/questionnaire/img/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=path %>/questionnaire/img/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=path %>/questionnaire/img/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="<%=path %>/questionnaire/img/apple-touch-icon-57-precomposed.png">

    </head>

    <body>

        <!-- Top content -->
        <div class="top-content">
        	
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>Login to Questionnaire Website</h3>
                            		<p>Enter your username and password to log in</p>
                            		<p>Click here to  <a href="signupPage"><strong>Sign Up</strong></a></p>
                            		<%
                            			if(request.getAttribute("flag") == "0"){
                            		%>
                            		<p><font color="red">wrong username or password, please try again</font>
                            		<%
                            			} 
                            		%>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-lock"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="<%=path %>/loginPro" method="post" class="login-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">Username</label>
			                        	<input type="text" name="username" placeholder="Username..." class="form-username form-control" id="form-username">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">Password</label>
			                        	<input type="password" name="password" placeholder="Password..." class="form-password form-control" id="form-password">
			                        </div>
			                        <button type="submit" class="btn btn-success">Sign in!</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>


        <!-- Javascript -->
        <script src="<%=path %>/questionnaire/js/jquery-1.11.1.min.js"></script>
        <script src="<%=path %>/questionnaire/js/bootstrap.min.js"></script>
        <script src="<%=path %>/questionnaire/js/jquery.backstretch.min.js"></script>
        <script src="<%=path %>/questionnaire/js/scripts.js"></script>
    </body>

</html>