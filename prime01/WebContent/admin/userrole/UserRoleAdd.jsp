<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>Prime</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<!-- CSS -->
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
 	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">

	 function validateForm() {
			$('#nameValidator').html('');
			$('#descValidator').html('');
			
		    var userRoleName =  $('#userRoleName').val();
			var userRoleDesc = $('#userRoleDescription').val();
		    var tmpValidated = true;
		    
		    if (userRoleName == null || userRoleName == "") {
		        $('#nameValidator').html('User role name must be filled out');
		        tmpValidated = false;
		    }
		    else {
		    	if (userRoleName.length > 50){
		    		 $('#nameValidator').html('Maximum character allowed is 50');
		    		 tmpValidated = false;
		    	}
		    }
		    
		    if (userRoleDesc == null || userRoleDesc == "") {
		        $('#descValidator').html('User role description must be filled out');
		        tmpValidated = false;
		    }
		    else {
		    	if (userRoleDesc.length > 200){
		    		 $('#descValidator').html('Maximum character allowed is 200!');
		    		 tmpValidated = false;
		    	}
		    }
		    
		    if (tmpValidated){
		    	dosubmit();
		    }
	}   
	
	/* function showNotifPreview() {
		$('#notif-preview').html($('#valueValidator'));
	} */
	</script>
	
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
			<section class="content-header">
				<h1>Manage User Role
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Manage User Role</li>
				</ol>
			</section>

			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title">Data User Role</h3></div>
					<div class="box-body">
                  	<html:form action="/UserRole"	>
                  		<html:hidden name="UserRoleForm" property="task" value="<%=Constants.Task.DOADD%>"/>
                  		<html:hidden name="UserRoleForm" property="userRoleBean.userRoleId" />
                  		<table class="form-input" align="center">
                  			<tr>
                  				<td width="200px">User Role Name</td>
                  				<td>:</td>
                  				<td><html:text name="UserRoleForm" property="userRoleBean.userRoleName" styleClass="form-control" styleId="userRoleName" maxlength="300"/></td>
                  			</tr>
                  			<tr>
                  				<td></td>
                  				<td></td>
                  				<td><i><span  id="nameValidator" style="color: red"></span></i></td>
                  			</tr>
                  			<tr>
	                  			<td width="200px">User Role Description</td>
	                  			<td>:</td>
                  			<td> <html:textarea name="UserRoleForm" property="userRoleBean.userRoleDescription" styleClass="form-control" styleId="userRoleDescription" rows="5"/> </td>
                  			</tr>
                  			<tr>
                  				<td></td>
                  				<td></td>
                  				<td><i><span  id="descValidator" style="color: red"></span></i></td>
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
		        	</div></div>
		        </div>
			</section>
</body>
</html>