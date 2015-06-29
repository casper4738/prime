<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<html>
<head> 
	<!-- CSS -->
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		function validateForm() {
			$('#validatorPassword').html('');
			$('#validatorNewPwd').html('');
			$('#validatorConfirmPwd').html('');
			$('#message').html('');
			
			var specialChars = "/*!@#$%^&*()\"{}_[]|\\?/<>,.";
			var password =  $('#password').val();
			var newPassword =  $('#newPwd').val();
			var confirmPassword = $('#confirmPwd').val();
			var tmpValidated = true;
			
			if(password == null || password == ""){
				 $('#validatorPassword').html('Old Password must be filled out');
				 tmpValidated = false;
			}
			 
			if(newPassword == null || newPassword == ""){
				 $('#validatorNewPwd').html('New Password must be filled out');
				 tmpValidated = false;
			} else {
			 	if (newPassword.length < 8){
					$('#validatorNewPwd').html('New Password minimum 8 character');
					tmpValidated = false;
			 	} else {
				 	 for (var i = 0; i < newPassword.length; i++) {
					       if (specialChars.indexOf(newPassword.charAt(i)) != -1) { 
					        	$('#validatorNewPwd').html("Characters are not allowed"); 
					        	tmpValidated = false;
					       } 
				     }
			 	}
			}
			 
			if(confirmPassword == null || confirmPassword == ""){
				 $('#validatorConfirmPwd').html("Confirm Password must be filled out");
				 tmpValidated = false;
			} else {
				if(confirmPassword != newPassword){
					 $('#validatorConfirmPwd').html("Confirm Password must same with new password");
					 tmpValidated = false;
				}
			}
			 
			if(tmpValidated){
				if(newPassword == password){
					$('#validatorNewPwd').html('New Password must not same as Old Password');
				} else {
					submitHandler(); 
				}
			}
		}
		
		function submitHandler(){
			var tmpPwd = $('#password');
			var tmpNewPwd = $('#newPwd');
			var tmpConfirmPwd = $('#confirmPwd');
			
			$('#password-validating').html("<i class=\"fa fa-refresh fa-spin\"></i> Validating Password");
			$('#password-validating').show();
    		$('#btn-submit').hide();
    		tmpPwd.attr("disabled", true);
    		tmpNewPwd.attr("disabled", true);
    		tmpConfirmPwd.attr("disabled", true);
			  
			$.ajax({
  	          type	  : 'POST',
  	          url	  : '<%=Constants.PAGES_LIST[Constants.Page.MODAL]%>',  // Send the login info to this page
  	          data	  : 'task=changePwd&param1=doChangePwd&param3=' + $('#password').val() + "&param6=" + $('#newPwd').val(),
  	          success : function(msg){
  	        	  var param = msg.split('#');
  	        	  if(param[0] == "0"){ //0 == False
  	        		  	$('#btn-submit').show();
  	        			tmpPwd.attr("disabled", false);
  	      				tmpNewPwd.attr("disabled", false);
  	      				tmpConfirmPwd.attr("disabled", false);
  	        	  }
				  $('#message').html(param[1]);
  				  $('#password-validating').hide();
  	          },
  	          
  	          error: function(){
					//TO DO :: Do Some Error Handling at Here
  	          }
			});
			
			/*
			if(tmpPwd.val() == tmpNewPwd.val()){
				$('#message').html("<center>Password and New Password must be different!</center>");
			} 
			else if(tmpNewPwd.val() == tmpConfirmPwd.val()){
				var tmpForm = $("#userChangePwd");
				tmpForm.attr("param1", "doChangePwd");
				modalLoadHandler(serialize(tmpForm));
			}
			else{
				$('#message').html("<center>New Password and Confirm Password must be same!</center>");
			} 
			*/
		}
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content" id="modal-wrapper">
		<div class="row">
			    <!-- Temporary Form -->
			    <html:form action="/Modal" styleId="userChangePwd">
			      <html:hidden name="ModalForm" property="task"/>
			      <html:hidden name="ModalForm" property="param1"/>
			    
					<div class="col-xs-12"><div class="box" align="center">
						<div class="box-header"><h1 class="box-title"><b>Change Password</b></h1><br/><br/></div>
						<table class="form-input" style="width: 500px;">
							<tr>
								<td>Old Password</td>
								<td> : </td>
								<td><html:password name="ModalForm" property="userBean.password" styleClass="form-control"  styleId="password"/></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td><i><span id="validatorPassword" style="color: red;font-size: 8"></span></i></td>
							</tr>
							<tr>
								<td>New Password</td>
								<td> : </td>
								<td><html:password name="ModalForm" property="userBean.newPassword" styleClass="form-control" styleId="newPwd"/></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td><i><span id="validatorNewPwd" style="color: red;font-size: 8"></span></i></td>
							</tr>
							<tr>
								<td>Confirm New Password</td>
								<td> : </td>
								<td><input type="password" class="form-control" id="confirmPwd"/></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td><i><span id="validatorConfirmPwd" style="color: red;font-size: 8"></span></i></td>
							</tr>
							<tr>
								<td colspan=3>
									<div id="message"></div>
								</td>
							</tr>
                  			<tr>
                  				<td></td>
								<td></td>
                  				<td><div id="password-validating"></div></td>
                  			</tr>
						</table>
		        	</div>
		        	
		        	<center>
			           <input type="button" id="btn-submit" value="Submit" class="btn btn-sm  btn-danger" onclick="validateForm()"/>
		       		</center>
		       	</div>
	       	</html:form>
	    </div>
	</section>
</body>
</html>