<%@page import="prime.constants.Constants"%>
<%@page import="prime.utility.MailUtil"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Prime | Log in</title>
    <link rel="icon" href="resources/favicon.ico" type="image/x-icon" />
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
  </head>
  <body class="login-page" style="background-color:#008080">
    <div class="login-box">
      <div class="login-box-body">
	    <div class="login-logo">
	       <b>Prime</b> v.1.1
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
          	<font color=RED face="Calibri" size="2" id="login-fail"/><i></i></font>
          </div>    
          <div class="row">
            <div class="col-xs-5">
              <input type="submit" class="btn btn-primary btn-block btn-flat" id="btn-submit" value="Sign In"/>
              <div class="overlay" id="ajax-validating">
               		<i class="fa fa-circle-o-notch fa-spin"></i> Processing...
              </div>
            </div><!-- /.col -->
            <input type="image" src="resources/image/logo.png" align="right" width="20%" height="20%" id="btn-credits"/>
          </div>
          <div class="row">
            <div class="col-xs-5">
            </div><!-- /.col -->
          </div>
        </html:form>
      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->
    
	<!-- Modal -->
	<div id="credits-modal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-body" id="content-modal-body">
					<center>
						<b><h2>ACE 21 - 8 July 2015</h2></b>
						<br>
						<b>PRIME</b><br>
						<b>Project Information Management System</b><br><br>
						Adrian Darma Patria	<br>
						Dedy Suwandi			<br>
						Fandy Adam			<br>
						Felix Fremont			<br>
						Frans Darmawan		<br>
						Helmy Almabruri		<br>
						Melisa Astriyanti		<br>
					</center>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	  
	<script src="resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/prime.js"></script>
    <script>
      $(document).ready(function(){
    	 	 $.ajaxSetup({ cache: false });
    	  	  var tmpIsLoginFail = <%=request.getAttribute(Constants.Request.LOGIN_STATUS)%>;
    	  	  if(tmpIsLoginFail == null){
    	  		  if(<%=request.getSession().getAttribute(Constants.Session.isSessionExpired)%>){
        	  		  $('#login-fail').show();
        	  		  $('#login-fail').html('<%=Constants.Response.FAILLOGIN_SESSIONEXPIRED%>');
  		    		  <%request.getSession().setAttribute(Constants.Session.isSessionExpired, false);%>
    	  		  } else {
      	  		  	  $('#login-fail').hide();  
    	  		  }
    	  	  } else {
    	  		  $('#login-fail').show();
    	  		  $('#login-fail').html('<%=request.getAttribute(Constants.Request.LOGIN_STATUS)%>');
    	  	  }
    	  	  
 		      $('#ajax-validating').hide();
		  	  $('#textbox-username').attr("placeholder","Username");
		  	  $('#textbox-password').attr("placeholder","Password");
		  	  $('#textbox-username').val('');
		  	  $('#textbox-password').val('');
			  $('#btn-submit').click(function(event){ 
				  if($('#textbox-username').val().length <= 0 || $('#textbox-password').val().length <= 0){
	    	  		 $('#login-fail').show();
					 $('#login-fail').html('<%=Constants.Response.FAILLOGIN_EMPTYDATA%>');
				  } else {
					  $('#textbox-username').attr("readonly", true);
					  $('#textbox-password').attr("readonly", true);
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
					 			  $('#textbox-username').attr("readonly", false);
					  			  $('#textbox-password').attr("readonly", false);
		    	        		  $('#login-fail').html(param[1]);
		    	        		  $('#login-fail').show();
		    	        		  $('#btn-submit').show();
		    		    		  $('#ajax-validating').hide(); 
		    	        	  } else {
		    	        		  window.location.href = "<%=Constants.PAGES_LIST[Constants.Page.MENU]%>";
		    	        	  }
		    	          },
		    	          
		    	          error: function(){
	    	        		  //Set Fail Login Warning
	    	        		  $('#login-fail').html("<%=Constants.Response.FAILLOGIN_ERROR%>");
				 			  $('#textbox-username').attr("readonly", false);
				  			  $('#textbox-password').attr("readonly", false);
	    	        		  $('#login-fail').show();
	    	        		  $('#btn-submit').show();
	    		    		  $('#ajax-validating').hide(); 
								//TO DO :: Do Some Error Handling at Here
		    	          }
		    	       });
				  }
				  
    	          event.preventDefault();
		      }); 
			  
			  $('#btn-credits').click(function(event){ 
				    $('#content-modal-body').removeData('bs.modal');
		    		$('#credits-modal').modal({ show:true, backdrop: false });
	    	        event.preventDefault();
			  });
      });
    </script>
  </body>
</html>