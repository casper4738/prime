<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<script>
		
		$(document).ready(function () {
			var tmpForm = document.forms[0];
			var strweekend = tmpForm.weekends.value.split(",");
			for(var i=0; i < tmpForm.weekend.length; i++) {
				for(var j=0; j < strweekend.length; j++) {
					if(tmpForm.weekend[i].value == strweekend[j]) {
						tmpForm.weekend[i].checked = true;
					}
				}
			}
        });
		
	</script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage General Setting</h1>
		<ol class="breadcrumb">
			<li><a href="javascript:void(0)" onclick="menuLoadHandler('${homepage}')"> <i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage General Setting</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Data General Setting</h3></div>
			<p><span class="message"><bean:write name="SettingAdminForm" property="message" /></span></p>
			<div class="box-body">
                	<html:form action="/SettingAdmin">
                		<html:hidden name="SettingAdminForm" property="task" value="<%=Constants.Task.GOTOEDIT%>"/>
                		<html:hidden name="SettingAdminForm" property="settingBean.weekend" styleId="weekends"/>
                		<table  class="form-input" align="center" cellspacing="5px" style="width: 55%;">
                			<tr>
                				<td width="250px">Level</td>
                				<td align="center">:</td>
                				<td><html:text name="SettingAdminForm" property="settingBean.generalSettingLevel" styleId="generalSettingLevel" styleClass="form-control" style="text-align:center" disabled="true"/></td>
                			</tr>
                			<tr>
                				<td>Minimum Level Approval</td>
                				<td align="center">:</td>
                				<td><html:text  name="SettingAdminForm" property="settingBean.minLevelApproval" styleId="minLevelApproval" styleClass="form-control" style="text-align:center" disabled="true"/></td>
                			</tr>
                			<tr>
	              				<td>SMTP Username</td>
	              				<td align="center">:</td>
	              				<td><html:text  name="SettingAdminForm" property="settingBean.smtpUsername" styleId="smtpUsername" styleClass="form-control" style="text-align:center" disabled="true"/></td>
	              			</tr>
	                 		<tr>
	              				<td>SMTP Password</td>
	              				<td align="center">:</td>
	              				<td><html:text  name="SettingAdminForm" property="settingBean.smtpPassword" styleId="smtpPassword" styleClass="form-control" style="text-align:center" disabled="true"/></td>
	              			</tr>
	              			<tr>
	              				<td>Default Reset Password</td>
	              				<td align="center">:</td>
	              				<td><html:text  name="SettingAdminForm" property="settingBean.resetPassword" styleId="resetPassword" styleClass="form-control" style="text-align:center" disabled="true"/></td>
	              			</tr>
	              			<tr>
	              				<td>Default Username Active Directory</td>
	              				<td align="center">:</td>
	              				<td><html:text  name="SettingAdminForm" property="settingBean.usernameActiveDirectory" styleId="usernameActiveDirectory" styleClass="form-control" style="text-align:center" disabled="true"/></td>
	              			</tr>
                			<tr>
	              				<td>Default Password Active Directory</td>
	              				<td align="center">:</td>
	              				<td><html:text  name="SettingAdminForm" property="settingBean.passwordActiveDirectory" styleId="passwordActiveDirectory" styleClass="form-control" style="text-align:center" disabled="true"/></td>
	              			</tr>
	              			<tr>
	              				<td>Default Weekend</td>
	              				<td align="center">:</td>
	              				<td>
              						<input type="checkbox" id="weekend" value="Monday" disabled="true"> Monday <br>
									<input type="checkbox" id="weekend" value="Tuesday" disabled="true"> Tuesday <br> 
									<input type="checkbox" id="weekend" value="Wednesday" disabled="true"> Wednesday<br>
									<input type="checkbox" id="weekend"value="Thursday" disabled="true"> Thursday<br> 
									<input type="checkbox" id="weekend" value="Friday" disabled="true"> Friday<br>
									<input type="checkbox" id="weekend" value="Saturday" disabled="true"> Saturday<br>
									<input type="checkbox" id="weekend" value="Sunday" disabled="true"> Sunday				
	              				</td>
	              			</tr>
	              			<tr>
	              				<td></td>
	              				<td></td>
	                			<td align="center"> 
	                				<html:button property="" value="Edit" styleClass="btn btn-primary" style="width:30%"  onclick="dosubmit()" />
	                				<html:button property="" value="Default" styleClass="btn btn-primary" style="width:30%" disabled="true" />
								</td>
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