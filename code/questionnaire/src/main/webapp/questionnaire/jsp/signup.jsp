<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


    <head>
	<%
	String path=request.getContextPath();
	%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Signup Questionnaire</title>

        <!-- CSS -->




    </head>

    <body>
			                    <form role="form" id="registerform">
			                    	<div class="form-group">
			                        	<input type="text" name="username" placeholder="Username..." class="form-username form-control" id="form-username" required>
			                        	<div><span id="dupname"></span></div>
			                        </div>
			                        <div class="form-group">
			                        	<input type="password" name="password" placeholder="Password..." class="form-password form-control" id="form-password" required>
			                        </div>
			                        <div class="form-group">
			                        	
			                        	<input type="password" name="confirmpassword" placeholder="Confirm the Password..." class="form-password form-control" required equalTo="#form-password">
			                        </div>
			                        <div class="form-group">
			                        	<input type="number" name="age" step="1" placeholder="Age..." class="form-age form-control" id="form-age" min="0">
			                        </div>
			                        <div class="form-group">
			                        	<input type="hidden" id="form-sex" name="sex" value="male">			
			                        	                        </div>
			                        <div class="form-group">
			                        	<input type="email" name="email" placeholder="Email..." class="form-email form-control" id="form-email" email>
			                        </div>
			                        			                        <div class="form-group">\
			                        	<input type="text" name="country" placeholder="Country..." class="form-country form-control" id="form-country">
			                        </div>
			                        			                        <div class="form-group">\
			                        	<input type="text" name="city" placeholder="City..." class="form-city form-control" id="form-city">
			                        </div>
			                        			                        <div class="form-group">\
			                        	<input type="text" name="mobile" placeholder="Mobile..." class="form-mobile form-control" id="form-mobile" digits rangelength="[11,11]">
			                        </div>
			                        			                        <div class="form-group">\
			                        	<input type="text" name="qq" placeholder="QQ..." class="form-qq form-control" id="form-qq" digits>
			                        </div>
			                        			                        <div class="form-group">\
			                        	<input type="text" name="wechat" placeholder="WeChat..." class="form-wechat form-control" id="form-wechat">
			                        </div>
			                        
			                        <button id="register" type="button" class="btn btn-success">Sign up!</button>
			                    </form>



        <!-- Javascript -->
        <script src="<%=path %>/questionnaire/js/jquery.min.js"></script>
        <script src="<%=path %>/questionnaire/js/bootstrap.min.js"></script>

        <script src="<%=path %>/questionnaire/js/jquery.validate.min.js"></script>
        <script src="<%=path %>/questionnaire/js/user.js"></script>

    </body>

</html>