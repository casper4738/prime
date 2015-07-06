<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
<script>
function dosubmitx() {
	var taskAssigner = $('#taskAssigner').val();
	var taskReceiver = $('#taskReceiver').val();
	
	if(taskReceiver == taskAssigner) {
		var employeeReceiver = taskAssigner;
		var taskId = $('#taskId').val();
		sendNotification(employeeReceiver, 
				 <%=Constants.NotificationType.TASK_SUBMITAPPROVALRETURN%>,
	 			"<%=Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]%>;<%=Constants.Task.GOTOVIEW%>;"+taskId+";"+employeeReceiver);	
	} else {
		var employeeReceiver = taskAssigner;
		var taskId = $('#taskId').val();
		sendNotification(employeeReceiver, 
				 <%=Constants.NotificationType.TASK_SUBMITAPPROVAL%>,
	 			"<%=Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]%>;<%=Constants.Task.GOTOVIEW%>;"+taskId+";"+employeeReceiver);	
	}
	dosubmit();
}
</script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Tasks<small> As Head</small></h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')">Tasks & Activities</html:link></li>
			<li class="active">Task Submission</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Task Submission Form</h3></div>
			<div class="box-body">
                	<html:form action="/TaskHeadUser">
                		<html:hidden name="TaskHeadUserForm" property="task" value="<%=Constants.Task.TASK.DOSUBMIT%>"/>
                		<html:hidden name="TaskHeadUserForm" property="taskBean.taskId"/>
                		<html:hidden name="TaskHeadUserForm" property="taskBean.taskAssigner" styleId="taskAssigner" />
                		<html:hidden name="TaskHeadUserForm" property="taskBean.taskReceiver" styleId="taskReceiver" />
                		<html:hidden name="TaskHeadUserForm" property="taskId"  styleId="taskId"/>
                		<html:hidden name="TaskHeadUserForm" property="taskBean.taskStatus" value='<%=Constants.Status.SUBMIT+""%>'/>
                		<table class="form-input" align="center">
                			<tr>
                				<td>Task Name</td>
                				<td>:</td>
                				<td><html:text style="width: 400px;" name="TaskHeadUserForm" readonly="true" property="taskBean.taskName" styleClass="form-control"/></td>
                			</tr>
                			<tr>
                				<td>Note</td>
                				<td>:</td>
                				<td><html:textarea style="width: 400px; height: 120px;" name="TaskHeadUserForm" property="taskBean.taskChangeNote" styleClass="form-control"/></td>
                			</tr>
                			<tr>
                				<td colspan="3" align="center">
                					<html:button property="" value="Submit" styleClass="btn btn-primary" onclick="dosubmitx()" />
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