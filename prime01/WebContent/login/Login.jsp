<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<%
	//Invalidate Session When We Come Back to this Screen
	request.getSession().invalidate();
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Prime | Log in</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />
  </head>
  <body class="login-page" style="background-color:teal;">
    <div class="login-box">
      <div class="login-box-body">
	    <div class="login-logo">
	       <b>Prime</b> v.0.1
	    </div><!-- /.login-logo -->
        <p class="login-box-msg">Sign in to start your session</p>
        <html:form action="/Login" method="post" styleId="form-login">
          <html:hidden name="LoginForm" property="task" />
          
          <div class="form-group has-feedback">
            <html:text name="LoginForm" property="username" styleClass="form-control" styleId="textbox-username"/>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <html:password name="LoginForm" property="password" styleClass="form-control" styleId="textbox-password"/>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
          	<font color=RED face="Calibri" size="2" id="login-fail"/><i>Fail to do Login...</i></font>
          </div>    
          <div class="row">
            <div class="col-xs-5">
              <input type="button" class="btn btn-primary btn-block btn-flat" id="btn-submit" value="Sign In"/>
              <div class="overlay" id="ajax-validating">
               		<i class="fa fa-refresh fa-spin"></i> Processing...
              </div>
            </div><!-- /.col -->
          </div>
        </html:form>
      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->
	  
    <script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
    <script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="resources/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <script src="resources/prime.js"></script>
    <script>
      $(document).ready(function(){
	      	  $('input').iCheck({
		         checkboxClass: 'icheckbox_square-blue',
		         radioClass: 'iradio_square-blue',
		         increaseArea: '20%' // optional
		      });

	      	  $('#login-fail').hide();
		      $('#ajax-validating').hide();
		  	  $('#textbox-username').attr("placeholder","Username");
		  	  $('#textbox-password').attr("placeholder","Password");
			  $('#btn-submit').click(function(){ 
	    		  $('#btn-submit').hide();
	    		  $('#ajax-validating').show();  
	    		  
	    		  //Do Login Data checking
				  document.forms[0].task.value = "<%=Constants.Task.DOLOGIN%>";
	    		  var str = $('#form-login').serialize();
	    		  $.ajax({ 
	    	          type	  : "POST",
	    	          url	  : "<%=Constants.PAGES_LIST[Constants.Page.LOGIN]%>",  // Send the login info to this page
	    	          data	  : str,
	    	          success : function(msg){
	    	        	  var param = msg.split('#');
	    	        	  if(param[0] == "0"){ //0 == False
	    	        		  //Set Fail Login Warning
	    	        		  $('#login-fail').html(param[1]);
	    	        		  $('#login-fail').show();
	    	        		  $('#btn-submit').show();
	    		    		  $('#ajax-validating').hide(); 
	    	        	  } else {
	    	        		  window.location = "<%=Constants.PAGES_LIST[Constants.Page.MENU]%>";
	    	        	  }
	    	          },
	    	          
	    	          error: function(){
    	        		  //Set Fail Login Warning
    	        		  $('#login-fail').html("<%=Constants.Response.FAILLOGIN_ERROR%>");
    	        		  $('#login-fail').show();
    	        		  $('#btn-submit').show();
    		    		  $('#ajax-validating').hide(); 
							//TO DO :: Do Some Error Handling at Here
	    	          }
	    	       });
		      }); 
      });
    </script>
  </body>
</html>