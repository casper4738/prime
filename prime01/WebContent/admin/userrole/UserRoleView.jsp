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
	
	<script type="text/javascript">

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
                  		<html:hidden name="UserRoleForm" property="task"/>
                  		<html:hidden name="UserRoleForm" property="userRoleBean.userRoleId" />
                  		<table class="form-input" align="center">
                  			 <thead>
								<tr>
									<th>User Menu Name</th>
		  							<th>Action</th>
				                </tr>
				           </thead>
			               <tbody>
			               <logic:notEmpty name="listUserMenu">
							<logic:iterate id="iter" name="listUserMenu">
			                	<tr>
			                        <td><bean:write name="iter" property="userMenuName"/></td>
			                        <td><html:checkbox name="iter" property="isCheck" value="1"></html:checkbox></td>
			                    </tr> 
			                   </logic:iterate>
						</logic:notEmpty>
						</tbody>
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