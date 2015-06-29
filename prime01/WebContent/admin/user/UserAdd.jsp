<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
	<!-- End of CSS -->
	  
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<!-- End of JS -->
	
	<script type="text/javascript">
		$(document).ready(function(){
			lockPasswordColumn();
			$('#ajax-validating').hide();
		});
		
		function validateForm(){
			var specialChars 	= "/*!@#$%^&*()\"{}_[]|\\?/<>,.";
			var userName 		= document.getElementById('userName').value;
		var password 			= document.getElementById('password').value;
			var employeeName 	= document.getElementById('employeeName').value;
			var confirmPassword = document.getElementById('confirmPassword').value;
			var tmpValidated 	= true;
			
			document.getElementById('validator').innerHTML="";
			document.getElementById('validatorEmployee').innerHTML="";
			document.getElementById('validatorPassword').innerHTML="";
			document.getElementById('validatorConfirmPassword').innerHTML="";
			
			if(employeeName == null || employeeName == "") {
				document.getElementById('validatorEmployee').innerHTML="Employee must be filled out";
				tmpValidated = false;
			}
			
			if(userName == null || userName == "") {
				 document.getElementById('validator').innerHTML="Name must be filled out";
				 tmpValidated = false;
			 }
			
			 if(userName != null || userName != ""){
			 	 for (var i = 0; i < userName.length; i++) {
		       	 	if (specialChars.indexOf(userName.charAt(i)) != -1) { 
			        	document.getElementById("validator").innerHTML = "Characters are not allowed"; 
			        	tmpValidated = false;
			       	} 
			     }
			 }

			 if(password == null || password == "") {
				 document.getElementById('validatorPassword').innerHTML="Password must be filled out";
				 tmpValidated = false;
			 }
			 
			 if(password != null || password != "") {
			 	 for (var i = 0; i < password.length; i++) {
		          	if (specialChars.indexOf(password.charAt(i)) != -1) { 
			        	document.getElementById("validatorPassword").innerHTML = "Characters are not allowed"; 
			        	tmpValidated = false;
			       	} 
			     }
			 }
			 
			 if(confirmPassword == null || confirmPassword == ""){
				 document.getElementById('validatorConfirmPassword').innerHTML="Confirm Password must be filled out";
				 tmpValidated = false;
			 }
			 
			 if(password.length < 8){
				 document.getElementById('validatorPassword').innerHTML="Password minimum 8 character";
				 tmpValidated = false;
			 }
			 
			 if(tmpValidated){
			     flyTo(); 
			 }
		}		
	
		function flyTo(){
			//Confirm Password
			var tmpPassword = document.getElementById('password');
			var tmpConfirmPassword = document.getElementById('confirmPassword');
			if (tmpPassword.value  == tmpConfirmPassword.value) {
				var tmpForm = document.forms[0]; 
				tmpForm.task.value = "<%=Constants.Task.DOADD%>";
				menuLoadHandler(tmpForm.action, serialize(tmpForm));
			}else{
				alert("Password does not match");
			}
		}
		
		function checkActiveDirectory(){
			  if($('#username').val().length <= 5){
				  return;
			  }
			
			  $('#ajax-validating').html("<i class=\"fa fa-refresh fa-spin\"></i> Checking username");
			  $('#ajax-validating').show();
			  $.ajax({ 
		          type	  : "POST",
		          url	  : '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_USER]%>',  
		          data	  : 'task=<%=Constants.Task.DOVALIDATE%>&userBean.userName=' + $('#username').val(),
		          success : function(msg){
		        	  var param = msg.split('#');
	        		  $('#ajax-validating').html(param[1]);
	        		  
		        	  if(param[0] == "1"){ //Success [Normal]
		        		  unlockPasswordColumn();
		        	  } else if(param[0] == "2"){ //Success [Active Directory]
		        		  lockPasswordColumn(); 
		        	  } else {
		        		  lockPasswordColumn(); 
		        	  }
		          },
		          
		          error: function(){
		        	  //TO DO :: Add Error Handling
		          }
		       });
		}
		
		function lockPasswordColumn(){
			$('#password').attr("disabled", true);
			$('#confirmPassword').attr("disabled", true);
		}
		function unlockPasswordColumn(){
			$('#password').attr("disabled", false);
			$('#confirmPassword').attr("disabled", false);
		}
		
		function openModalHandler(){
			//##0.Preparing Parameter For Modal Showing
			var tmpDataPosition=1;
			var tmpTask ="modalTable";
			var tmpTable ="employeeList";
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=employeeUser", $('#result'));
		}
	</script>
	
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage User</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage User</li>
			<li class="active">Add User</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box" align="center">
			<div class="box-header"><h1 class="box-title"><br/><br/><b>Add New User</b><br/><br/></h1></div>
			<div class="box-body">
                	<html:form action="/UserAdmin" styleId= "userForm">
                		<html:hidden name="UserAdminForm" property="task"/>
                		<html:hidden name="UserAdminForm" property="employeeId" />
                		<table class="form-input" style="width: 500px" id="table-input">
                			<tr>
                				<td width="150px">Employee Name</td>
                				<td>:</td>
                				<td class="input-group">
			               			<html:text name="UserAdminForm" property="userBean.employeeName" styleClass="form-control" styleId="employeeName" disabled="true"/>
			               			<span class="input-group-btn">
	                    					<input type="button" class="btn btn-info" type="button" onclick="openModalHandler()" style="background-image:url(resources/image/search.png); background-repeat: no-repeat; background-position:center"/>
								    </span>
								</td>
                			</tr>
                			<tr>
                				<td>Username</td>
                				<td>:</td>
                				<td><html:text name="UserAdminForm" property="userBean.userName" styleClass="form-control" styleId="username" onblur="checkActiveDirectory()"/> </td>
                			</tr>
                			<tr>
                				<td></td>
                				<td></td>
                				<td>	
						            <div id="ajax-validating"/>	              
                					<i><span id="validatorEmployee" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                			<tr>
                				<td>Password</td>
                				<td>:</td>
                				<td><html:password name="UserAdminForm"  property="userBean.password" styleClass="form-control" styleId="password" maxlength="32" styleId="password"/></td>
                			</tr>
                			<tr>
                				<td>Confirm Password</td>
                				<td>:</td>
                				<td><html:password name="UserAdminForm"  property="userBean.tmpConfirmPassword" styleClass="form-control" maxlength="32" styleId="confirmPassword"/></td>
                			</tr>
                  			<tr>
                  				<td></td>
								<td></td>
                  				<td><i><span id="validatorConfirmPassword" style="color: red;font-size: 8"></span></i></td>
                  			</tr>
                			<tr>
                				<td>Sys Level</td>
                				<td>:</td>
                				<td>
                					<html:select name="UserAdminForm" property="userBean.sysLevel" styleClass="form-control" styleId="sysLevel">
		               					<html:option value='<%=Constants.SystemLevel.ADMIN+""%>'>0 - Admin</html:option>
		               					<html:option value='<%=Constants.SystemLevel.OPERATOR+""%>'>1 - Operator</html:option>
		               					<html:option value='<%=Constants.SystemLevel.OPERATOR_MONITOR+""%>'>2 - Operator + Monitor</html:option>
		               				</html:select>
		               			</td>
                			</tr> 
                			<tr>
                  				<td colspan="3" align="center">
                  					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="validateForm()" />
                  					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
                  				</td>
                			</tr>
                		</table>
                	</html:form>
       			</div>
       			</div>
       		</div>
   		</div>
		</section>
</body>
</html>
