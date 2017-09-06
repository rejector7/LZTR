
jQuery(document).ready(function() {
	
    /*
        Fullscreen background
    */

    $.backstretch("questionnaire/img/homepage.jpg");

    /*
        Form validation
    */
    $('.login-form input[type="text"], .login-form input[type="password"], .login-form textarea').on('focus', function() {
    	$(this).removeClass('input-error');
    });

    
    
});
