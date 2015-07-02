<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html> 
<head> 
	
	<!-- JS -->
	<script type="text/javascript">
		$(document).ready(function(){
			lockPasswordColumn();
			$('#username-validating').hide();
		});
		
		function validateForm(){
			var specialChars 	= "/*!@#$%^&*()\"{}[]|\\?/<>,";
			var userName 		= $('#username').val();
			var password 		= $('#password').val();
			var employeeName 	= $('#employeeName').val();
			var confirmPassword = $('#confirmPassword').val();
			var tmpValidated 	= true;
			
			$('#validatorEmployee').html("");
			$('#validatorUsername').html("");
			$('#validatorPassword').html("");
			$('#validatorConfirmPassword').html("");
			
			if(employeeName == null || employeeName == "") {
				$('#validatorEmployee').html("Employee must be selected");
				tmpValidated = false;
			}
			
			if(userName == null || userName == "") {
				 $('#validatorUsername').html("Name must be filled out");
				 tmpValidated = false;
			 }
			
			 if(userName != null || userName != ""){
			 	 for (var i = 0; i < userName.length; i++) {
		       	 	if (specialChars.indexOf(userName.charAt(i)) != -1) { 
			        	$("#validatorUsername").html("Characters are not allowed"); 
			        	tmpValidated = false;
			       	} 
			     }
			 }

			 if(!$('#password').attr("disabled")){
				 if(password == null || password == "") {
					 $('#validatorPassword').html("Password must be filled out");
					 tmpValidated = false;
				 } else {
					 if(password.length < 8){
						 $('#validatorPassword').html("Password minimum 8 character");
						 tmpValidated = false;
					 } else {
						 for (var i = 0; i < password.length; i++) {
				          	if (specialChars.indexOf(password.charAt(i)) != -1) { 
					        	$("#validatorPassword").html("Characters are not allowed"); 
					        	tmpValidated = false;
					       	} 
					     }
					 }
				 }
				 
				 if(confirmPassword == null || confirmPassword == ""){
					 $('#validatorConfirmPassword').html("Confirm Password must be filled out");
					 tmpValidated = false;
				 } else {
					 if(confirmPassword != password){
						 $('#validatorConfirmPassword').html("Password and Confirm Password must same");
						 tmpValidated = false;
					 }
				 }
			 }
			 
			 
			 if(tmpValidated){
				 //Do Database Checking, if Success Fly To
				  $('#employee-validating').html("<i class=\"fa fa-refresh fa-spin\"></i> Validating employee data");
				  $('#btn-save').hide();
				  $('#btn-cancel').hide();
				  $.ajax({ 
			          type	  : "POST",
			          url	  : '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_USER]%>',  
			          data	  : 'task=<%=Constants.Task.DOVALIDATE2%>&employeeId=' + $('#employeeId').val(),
			          success : function(msg){
							 param = msg.split('#');
							 
							 if(param[0] == "0"){ //Success
				        	  	 flyTo(); 
							 } else {			   //Failed
								 $('#employee-validating').html(param[1]);
							 	 $('#btn-save').show();
								 $('#btn-cancel').show();
							 }
			          },
			          
			          error: function(){
							alert("ERROR");
			        	  	//TO DO :: Add Error Handling
			          }
			     });
			 }
		}		
	
		function flyTo(){
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = "<%=Constants.Task.DOADD%>";
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function checkActiveDirectory(){
			  if($('#username').val().length <= 0){
				  return;
			  }
			
			  //##1.Set Loading and Disable Button
			  $('#username-validating').html("<i class=\"fa fa-refresh fa-spin\"></i> Checking username");
			  $('#username-validating').show();
			  $('#btn-save').attr("disabled", true);
			  $('#validatorEmployee').html("");
			  $('#validatorUsername').html("");
			  $('#validatorPassword').html("");
			  $('#validatorConfirmPassword').html("");
			  $.ajax({ 
		          type	  : "POST",
		          url	  : '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_USER]%>',  
		          data	  : 'task=<%=Constants.Task.DOVALIDATE1%>&userBean.userName=' + $('#username').val(),
		          success : function(msg){
		        	  var param = msg.split('#');
	        		  $('#username-validating').html(param[1]);
		        	  if(param[0] == "1"){ 		  //Success [Normal]
		        		  unlockPasswordColumn();
		        	  } else if(param[0] == "2"){ //Success [Active Directory]
		        		  lockPasswordColumn(); 
		        	  	  resetPasswordColumn();
		        	  } else {
		        		  lockPasswordColumn(); 
		        	  }
					  $('#btn-save').attr("disabled", false);
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
		function resetPasswordColumn(){
			$('#password').val("");
			$('#confirmPassword').val("");
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
			<li><html:link href="#" onclick="flyToBack('home')" >Manage User</html:link></li>
			<li class="active">Add User</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box" align="center">
					<div class="box-header"><h1 class="box-title"><br/><br/><b>Add New User</b><br/><br/></h1></div>
					<div class="box-body">
	                	<html:form action="/UserAdmin" styleId= "userForm">
	                		<html:hidden name="UserAdminForm" property="task"/>
	                		<html:hidden name="UserAdminForm" property="employeeId" styleId="employeeId"/>
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
	                				<td></td>
	                				<td></td>
	                				<td>	    
	                					<i><span id="validatorEmployee" style="color: red;font-size: 8"></span></i>
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
							            <div id="username-validating"></div>           
	                					<i><span id="validatorUsername" style="color: red;font-size: 8"></span></i>
	                				</td>
	                			</tr>
	                			<tr>
	                				<td>Password</td>
	                				<td>:</td>
	                				<td><html:password name="UserAdminForm"  property="userBean.password" styleClass="form-control" styleId="password" maxlength="32"/></td>
	                			</tr>
	                  			<tr>
	                  				<td></td>
									<td></td>
	                  				<td><i><span id="validatorPassword" style="color: red;font-size: 8"></span></i></td>
	                  			</tr>
	                			<tr>
	                				<td>Confirm Password</td>
	                				<td>:</td>
	                				<td><input type="password" class="form-control" maxlength="32" id="confirmPassword"/></td>
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
	                					<%-- <html:select name="UserAdminForm" property="userBean.sysLevel" styleClass="form-control" styleId="sysLevel">
			               					<html:option value='<%=Constants.SystemLevel.ADMIN+""%>'>0 - Admin</html:option>
			               					<html:option value='<%=Constants.SystemLevel.OPERATOR+""%>'>1 - Operator</html:option>
			               					<html:option value='<%=Constants.SystemLevel.OPERATOR_MONITOR+""%>'>2 - Operator + Monitor</html:option>
			               				</html:select> --%>		               		
				               					 <html:select name="UserAdminForm" property="userRoleId" styleClass="form-control" styleId="userRoleId">
					               					<html:options collection="listUserRole" property="userRoleId" labelProperty="userRoleName" />
					               				</html:select>  			
			               			</td>
	                			</tr> 
	                  			<tr>
	                  				<td></td>
									<td></td>
	                  				<td><div id="employee-validating"></div></td>
	                  			</tr>
	                			<tr>
	                  				<td colspan="3" align="center">
	                  					<html:button property="" value="Save" styleClass="btn btn-primary" styleId="btn-save" onclick="validateForm()" />
	                  					<html:button property="" value="Cancel" styleClass="btn btn-default" styleId="btn-cancel" onclick="flyToPage('success')"/>
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
