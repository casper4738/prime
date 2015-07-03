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
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage General Setting</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')" >Manage General Setting</html:link></li>
			<li class="active">Edit General Setting</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Data General Setting</h3></div>
			<p></p><br/><br/>
			<div class="box-body">
                	<html:form action="/SettingAdmin">
                		<html:hidden name="SettingAdminForm" property="task" value="<%=Constants.Task.DOEDIT%>"/>
                		<html:hidden name="SettingAdminForm" property="settingBean.smtpPassword"/>
                		<table  class="form-input" align="center" border="2px" cellspacing="5px" style="width: 500px;">
                			<tr><td colspan="3">
									<html:button property="" value="Save" styleClass="btn btn-primary" onclick="dosubmit()" />
								</td>
                			</tr>
                			<tr>
                				<td width="150px">Level</td>
                				<td align="center">:</td>
                				<td><html:text name="SettingAdminForm" property="settingBean.generalSettingLevel" styleClass="form-control" style="text-align:center"/></td>
                			</tr>
                			<tr>
                				<td>Minimum Level Approval</td>
                				<td align="center">:</td>
                				<td><html:text  name="SettingAdminForm" property="settingBean.minLevelApproval" styleClass="form-control" style="text-align:center"/></td>
                			</tr>
                			<tr>
	              				<td>SMTP Username</td>
	              				<td align="center">:</td>
	              				<td><html:text  name="SettingAdminForm" property="settingBean.smtpUsername" styleClass="form-control" style="text-align:center"/></td>
	              			</tr>
	                 		<tr>
	              				<td>SMTP Password</td>
	              				<td align="center">:</td>
	              				<td><html:text  name="SettingAdminForm" property="smtpPassword" styleClass="form-control" style="text-align:center"/></td>
	              			</tr>
                		</table>
                	</html:form>
                  </div>
        	</div></div>
        </div>
	</section>
</body>
</html>