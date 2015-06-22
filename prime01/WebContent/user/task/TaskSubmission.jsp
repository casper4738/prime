<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Tasks<small>Task Management</small></h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>Task & Activities</li>
		  	<li>Task Detail</li>
		  	<li>Task Submission</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Task Submission Form</h3></div>
			<div class="box-body">
                	<html:form action="/TaskUser">
                		<html:hidden name="TaskUserForm" property="task" value='<%=Constants.Task.TASK.DOSUBMIT+""%>'/>
                		<html:hidden name="TaskUserForm" property="taskBean.taskId" />
                		<html:hidden name="TaskUserForm" property="taskBean.taskStatus" value='<%=Constants.Status.SUBMIT+""%>'/>
                		<table class="form-input" align="center">
                			<tr>
                				<td>Task Name</td>
                				<td>:</td>
                				<td><html:text style="width: 400px;" name="TaskUserForm" readonly="true" property="taskBean.taskName" styleClass="form-control"/></td>
                			</tr>
                			<tr>
                				<td>Note</td>
                				<td>:</td>
                				<td><html:textarea style="width: 400px; height: 120px;" name="TaskUserForm" property="taskBean.taskChangeNote" styleClass="form-control"/></td>
                			</tr>
                			<tr>
                				<td colspan="3" align="center">
                					<html:button property="" value="Submit" styleClass="btn btn-primary" onclick="dosubmit()" />
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