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
	
	<!-- JS -->
	<script type="text/javascript">
		function validateForm() {
			document.getElementById('validator').innerHTML="";
			var specialChars = "/*!@#$%^&*()\"{}_[]|\\?/<>,."; // specify special characters 
		    var roleName =  document.getElementById('nameValidator').value;
		    if (roleName == null || roleName == "") {
		        document.getElementById('validator').innerHTML="Name must be filled out";
		        return false;
		    }
		    else {
		    	for (var i = 0; i < roleName.length; i++) {
		    	    if (specialChars.indexOf(roleName.charAt(i)) != -1) { 
		    			document.getElementById("validator").innerHTML = "Characters are not allowed"; 
		    			return false; 
		    		}
		    	}
		    	   dosubmit();
		    }
		    
		}
	</script>
	<!-- End of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Role</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>Manage Role</li>
			<li class="active">Add Role</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Data Role</h3></div>
			<div class="box-body">
            	<html:form action="/RoleAdmin">
                	<html:hidden name="RoleAdminForm" property="task" value="<%=Constants.Task.DOADD%>"/>
                  	<html:hidden name="RoleAdminForm" property="roleBean.roleId" />
                  	<table class="form-input" align="center">
                  		<tr><td>Role Name</td>
                  			<td>:</td>
                  			<td><html:text name="RoleAdminForm" property="roleBean.roleName" styleClass="form-control" styleId="nameValidator" maxlength="50"/></td>
                  		</tr>
						<tr><td></td>
                  			<td></td>
                  			<td> <span  id="validator" style="color: red"> </span> </td>
                  		</tr>
                  		<tr><td colspan="3" align="center">
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