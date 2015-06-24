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
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
			<section class="content-header">
				<h1>Manage User<small>management system</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
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
                  				<td><html:text readonly="true" name="UserAdminForm" property="userBean.employeeName" styleClass="form-control"/></td>
                  			</tr>
                  			<tr>
                  				<td>Username</td>
                  				<td>:</td>
                  				<td><html:text readonly="true" name="UserAdminForm" property="userBean.userName" styleClass="form-control"/></td>
                  			</tr>
                  			<tr>
                  				<td>Password</td>
                  				<td>:</td>
                  				<td><html:text name="UserAdminForm" property="userBean.password" styleClass="form-control"/></td>
                  			</tr>
                  			<tr>
                  				<td>Confirm Password</td>
                  				<td>:</td>
                  				<td><html:text name="UserAdminForm" property="userBean.password" styleClass="form-control"/></td>
                  			</tr>
                  			<tr>
                  				<td>Sys Level</td>
                  				<td>:</td>
                  				<td>
                  					<html:select name="UserAdminForm" property="userBean.sysLevel" styleClass="form-control" styleId="sysLevel">
				               			<html:option value="">Admin</html:option>
				               			<html:option value="">Operator</html:option>
				               			<html:option value="">Operator + Monitor</html:option>
				               		</html:select>
				               	</td>
                  			</tr> 
                  			<tr>
                  				<td colspan="3" align="center">
                  					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="dosubmit()" />
                  					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
                  				</td>
                  			</tr>
                  		</table>
                  	</html:form>
                    </div>
		        	</div></div>
		        </div>
			</section>

	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
 	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
</body>
</html>