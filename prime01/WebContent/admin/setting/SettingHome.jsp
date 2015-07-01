<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage General Setting<small>management system</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage General Setting</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Data General Setting</h3></div>
			<p><span class="message"><bean:write name="SettingAdminForm" property="message" /></span></p>
			<br/>
			<br/>
			
			<div class="box-body">
                	<html:form action="/SettingAdmin">
                		<html:hidden name="SettingAdminForm" property="task" value="<%=Constants.Task.GOTOEDIT%>"/>
                		<table  class="form-input" align="center" border="2px" cellspacing="5px" style="width: 500px;">
                			<tr>
                				<td colspan="3">
							<html:button property="" value="Edit" styleClass="btn btn-primary" onclick="dosubmit()" />
						</td>
                			</tr>
                			<tr>
                				<td width="150px">Level</td>
                				<td align="center">:</td>
                				<td><html:text name="SettingAdminForm" property="settingBean.generalSettingLevel" styleClass="form-control" style="text-align:center" disabled="true"/></td>
                			</tr>
                			<tr>
                				<td>Time Out (minutes)</td>
                				<td align="center">:</td>
                				<td><html:text  name="SettingAdminForm" property="settingBean.generalSettingTimeOut" styleClass="form-control" style="text-align:center" disabled="true"/></td>
                			</tr>
                			<tr>
                				<td>Minimum Level Approval</td>
                				<td align="center">:</td>
                				<td><html:text  name="SettingAdminForm" property="settingBean.minLevelApproval" styleClass="form-control" style="text-align:center" disabled="true"/></td>
                			</tr>
                			<tr>
              				<td>SMTP Username</td>
              				<td align="center">:</td>
              				<td><html:text  name="SettingAdminForm" property="settingBean.smtpUsername" styleClass="form-control" style="text-align:center" disabled="true"/></td>
              			</tr>
                 		<tr>
              				<td>SMTP Password</td>
              				<td align="center">:</td>
              				<td><html:text  name="SettingAdminForm" property="smtpPassword" styleClass="form-control" style="text-align:center" disabled="true"/></td>
              			</tr>
                		</table>
                	</html:form>
                  </div>
        	</div></div>
        </div>
	</section>
	<!-- /.content-wrapper -->
</body>
</html>