<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<script type="text/javascript">
	function flyToEdit() {
		var tmpForm = document.forms[0]; 
		tmpForm.task.value = "<%=Constants.Task.DORESET%>";
		menuLoadHandler(tmpForm.action, serialize(tmpForm));
	}
	</script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage User</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')" >Manage User</html:link></li>
			<li class="active">Manage User</li>
		</ol>
	</section>
	
	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div align = "center"class="box-header"><h3 class="box-title">Edit User</h3></div>
			<div class="box-body">
	               	<html:form action="/UserAdmin">
	               		<html:hidden name="UserAdminForm" property="task" value="<%=Constants.Task.DOEDIT%>"/>
	               		<html:hidden name="UserAdminForm" property="userBean.employeeId" />
	               		<table class="form-input" align="center">
	               			<tr>
	               				<td>Employee Name</td>
	               				<td>:</td>
	               				<td><html:text disabled="true" name="UserAdminForm" property="userBean.employeeName" styleClass="form-control"/></td>
	               			</tr>
	               			<tr>
	               				<td>Username</td>
	               				<td>:</td>
	               				<td><html:text disabled="true" name="UserAdminForm" property="userBean.userName" styleClass="form-control"/></td>
	               			</tr>
	               			<tr>
	               				<td>Sys Level</td>
	               				<td>:</td>
	               				<td>
	               					<html:select name="UserAdminForm" property="userRoleId" styleClass="form-control" styleId="userRoleId">
		              					<html:options collection="listUserRole" property="userRoleId" labelProperty="userRoleName" />
		              				</html:select>  	
		               	</td>
	               			</tr> 
	               			<tr>
	               				<td colspan="3" align="center">
	               					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="dosubmit()" />
	               					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
	               					<html:button property="" value="Reset Password" styleClass="btn btn-default" onclick="flyToEdit()" />
	               				</td>
	               			</tr>
	               		</table>
	               	</html:form>
	       	</div></div>
	       </div>
	       </div>
	</section>
</body>
</html>