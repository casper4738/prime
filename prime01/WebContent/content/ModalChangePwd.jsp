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
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false,
	    } );
		
		<!-- Method Specified For Body Onload-->
		
		$(document).ready(function(){
			var tmpStr = <%= request.getAttribute("flag")%>;
			$('#message').html("");
			if(tmpStr == false){
				$('#message').html("<center>Password not match</center>");
			} else if(tmpStr == true){
				$('#message').html("<center>Password has been changed</center>");
				document.getElementById("password").disabled =  true;
				document.getElementById("newPwd").disabled =  true;
				document.getElementById("confirmPwd").disabled =  true;
				document.getElementById("submit").style.visibility = "hidden";
			} 
			
		});
		
		<!-- Method Specified For Modal Handling-->
		
		function submitHandler(){
			
			var tmpPwd = document.getElementById('password');
			var tmpNewPwd = document.getElementById('newPwd');
			var tmpConfirmPwd = document.getElementById('confirmPwd');
			
			if(tmpPwd.value == tmpNewPwd.value){
				$('#message').html("<center>Password and New Password must be different!</center>");
			} 
			else if(tmpNewPwd.value == tmpConfirmPwd.value){
				var tmpForm = document.getElementById("userChangePwd");
				tmpForm.param1.value = "changePassword";
				modalLoadHandler(serialize(tmpForm));
			}
			else{
				$('#message').html("<center>New Password and Confirm Password must be same!</center>");
			} 	
		}
		
		function validateForm(){
			document.getElementById('validatorPassword').innerHTML="";
			document.getElementById('validatorNewPwd').innerHTML="";
			document.getElementById('validatorConfirmPwd').innerHTML="";
			var specialChars = "/*!@#$%^&*()\"{}_[]|\\?/<>,.";
			var password =  document.getElementById('password').value;
			var newPassword =  document.getElementById('newPwd').value;
			var confirmPassword = document.getElementById('confirmPwd').value;
			var tmpValidated = true;


			 if(password == null || password == ""){
				 document.getElementById('validatorPassword').innerHTML="Old Password must be filled out";
				 tmpValidated = false;
			 }
			 
			 if(newPassword == null || newPassword == ""){
				 document.getElementById('validatorNewPwd').innerHTML="New Password must be filled out";
				 tmpValidated = false;
			 }
			else if(newPassword.length < 8){
				document.getElementById('validatorNewPwd').innerHTML="New Password minimum 8 character";
				tmpValidated = false;
			}
			 
			 if(newPassword != null || newPassword != ""){
			 	 for (var i = 0; i < newPassword.length; i++) {
			          if (specialChars.indexOf(newPassword.charAt(i)) != -1) { 
			        document.getElementById("validatorNewPwd").innerHTML = "Characters are not allowed"; 
			        tmpValidated = false;
			       } 
			     }
			 }
			 
			 if(confirmPassword == null || confirmPassword == ""){
				 document.getElementById('validatorConfirmPwd').innerHTML="Confirm Password must be filled out";
				 tmpValidated = false;
			 }
			 
			 if(tmpValidated){
				 submitHandler(); 
			 }
			 
		}
		
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content">
		<div class="row">
		    <!-- Temporary Form -->
		    <html:form action="/Modal" styleId="userChangePwd">
		      <html:hidden name="ModalForm" property="task"/>
		      <html:hidden name="ModalForm" property="param1"/>
		    <!-- End Of Temporary Form -->
		    
			<div class="col-xs-12"><div class="box" align="center">
				<div class="box-header"><h1 class="box-title"><b>Change Password</b></h1><br/><br/></div>
				<table class="form-input" style="width: 500px;">
					<tr>
						<td>Old Password</td>
						<td> : </td>
						<td><html:text name="ModalForm" property="userBean.password" styleClass="form-control"  styleId="password"/></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td><i><span id="validatorPassword" style="color: red;font-size: 8"></span></i></td>
					</tr>
					<tr>
						<td>New Password</td>
						<td> : </td>
						<td><html:text name="ModalForm" property="userBean.newPassword" styleClass="form-control" styleId="newPwd"/></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td><i><span id="validatorNewPwd" style="color: red;font-size: 8"></span></i></td>
					</tr>
					<tr>
						<td>Confirm New Password</td>
						<td> : </td>
						<td><html:text name="ModalForm" property="userBean.confirmPassword" styleClass="form-control" styleId="confirmPwd"/></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td><i><span id="validatorConfirmPwd" style="color: red;font-size: 8"></span></i></td>
					</tr>
					<tr>
						<td colspan=3>
							<div id="message" style="color:red;font-style:italic;font-size:8"></div>
						</td>
					</tr>
				</table>
        	</div>
        	<center>
	           <input id="submit" type="button" value="Submit" class="btn btn-sm  btn-danger" onclick="validateForm()"/>
       		</center>
       	</div>
       	</html:form>
	      </div>
	</section>
</body>
</html>