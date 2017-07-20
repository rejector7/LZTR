<!DOCTYPE html>
<html lang="en">

    <head>
	<%
	String path=request.getContextPath();
	%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Signup Questionnaire</title>

        <!-- CSS -->
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/css.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/font-awesome.min.css">
		<link rel="stylesheet" href="<%=path %>/questionnaire/css/form-elements.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/style.css">
        <link rel="stylesheet" href="<%=path %>/questionnaire/css/validation.css">
        
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
                        			<h3>Signup to Questionnaire Website</h3>
                            		<p>Enter your username and password to sign up</p>
                            		<p>Click here to  <a href="<%=path %>/loginPage"><strong>Log in</strong></a></p>
                   
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-lock"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" method="post"  action="signupPro" class="login-form" id="registerform">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">Username</label>
			                        	<input type="text" name="username" placeholder="Username..." class="form-username form-control" id="form-username" required>
			                        	<div><span id="dupname"></span></div>
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">Password</label>
			                        	<input type="password" name="password" placeholder="Password..." class="form-password form-control" id="form-password" required>
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" >Confirm the Password</label>
			                        	<input type="password" name="confirmpassword" placeholder="Confirm the Password..." class="form-password form-control" required equalTo="#form-password">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-age">Age</label>
			                        	<input type="number" name="age" step="1" placeholder="Age..." class="form-age form-control" id="form-age" min="0">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-sex">Sex</label>
			                        	<select  id="form-sex" name="sex" class="form-sex form-control">
											<option value="male">Male</option>
											<option value="female">Female</option>
										</select>
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-email">Email</label>
			                        	<input type="email" name="email" placeholder="Email..." class="form-email form-control" id="form-email" required>
			                        </div>
			                        			                        <div class="form-group">
			                        	<label class="sr-only" for="form-country">Country</label>
			                        	<input type="text" name="country" placeholder="Country..." class="form-country form-control" id="form-country">
			                        </div>
			                        			                        <div class="form-group">
			                        	<label class="sr-only" for="form-city">City</label>
			                        	<input type="text" name="city" placeholder="City..." class="form-city form-control" id="form-city">
			                        </div>
			                        			                        <div class="form-group">
			                        	<label class="sr-only" for="form-mobile">Mobile</label>
			                        	<input type="text" name="mobile" placeholder="Mobile..." class="form-mobile form-control" id="form-mobile" digits rangelength="[11,11]" >
			                        </div>
			                        			                        <div class="form-group">
			                        	<label class="sr-only" for="form-qq">QQ</label>
			                        	<input type="text" name="qq" placeholder="QQ..." class="form-qq form-control" id="form-qq" digits>
			                        </div>
			                        			                        <div class="form-group">
			                        	<label class="sr-only" for="form-wechat">WeChat</label>
			                        	<input type="text" name="wechat" placeholder="WeChat..." class="form-wechat form-control" id="form-wechat">
			                        </div>
			                        			                        			                        <div class="form-group">
			                        	<label class="sr-only" for="form-job">Job</label>
			                        	<input type="text" name="job" placeholder="Job..." class="form-job form-control" id="form-job">
			                        </div>
			                        
			                        <button type="button" id="register" class="btn btn-success">Sign up!</button>
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
        <script src="<%=path %>/questionnaire/js/jquery.validate.min.js"></script>
        <script src="<%=path %>/questionnaire/js/user.js"></script>
        <script>
                $(function () {
            $.backstretch([
                  "<%=path %>/questionnaire/img/backgrounds/1.jpg",
            ], { duration: 3000, fade: 750 });
        });
        </script>
    </body>

</html>