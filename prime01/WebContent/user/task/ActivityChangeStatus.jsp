<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<script>
	function dosubmit(value) {
		document.forms[0].activityStatus.value = value;
		menuLoadHandler(document.forms[0].action, serialize(document.forms[0]));
	}
	</script>
</head> 
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Tasks<small>Task Management</small></h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>Task & Activities</li>
		  	<li>Task Detail</li>
		  	<li>Activity Status</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Activity Status</h3></div>
				<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
				<tr><td>Task Name : <bean:write name="TaskUserForm" property="activityBean.taskName"/> </td>
					<td>Activity Name : <bean:write name="TaskUserForm" property="activityBean.activityName" /> </td>
				</tr>
				<tr><td>Last Status : 
					<logic:equal name="TaskUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.RECEIVE+""%>'>
	            		<span class="label label-warning">Receive</span>
	          		</logic:equal>
	          		<logic:equal name="TaskUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.SUBMIT+""%>'>
	          			<span class="label label-primary">Submit</span>
	          		</logic:equal>
	          		<logic:equal name="TaskUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.PAUSE+""%>'>
	          			<span class="label label-warning">Pause</span>
	          		</logic:equal>
	          		<logic:equal name="TaskUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.FINISH+""%>'>
	          			<span class="label label-primary">Finish</span>
	          		</logic:equal>
	          		<logic:equal name="TaskUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.ABORT+""%>'>
	          			<span class="label label-danger">Abort</span>
	          		</logic:equal>
	          		<logic:equal name="TaskUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.PROGRESS+""%>'>
	          			<span class="label label-success">Progress</span>
	          		</logic:equal>
				</td>
					<td>Last Change Date : <bean:write name="TaskUserForm" property="activityBean.activityChangeDate"  format="dd MMMM yyyy hh:mm:ss"/> </td>
				</tr>
				<tr><td colspan="2">Description : <bean:write name="TaskUserForm" property="activityBean.activityDescription" /> </td></tr>
				</table>
				
				<p><span class="message"><bean:write name="TaskUserForm" property="message" /></span></p>
				<div class="form-action"><table align="center" class="btn-status-activity">
	               <tr>	<td><input type="button" value="Start" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')"/></td>
	               		<td><input type="button" value="Pause" class="btn btn-sm  btn-warning" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/></td>
	               		<td><input type="button" value="Finish" class="btn btn-sm  btn-success" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/></td>
	               		<td><input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/></td>
	               </tr>
	            </table></div>
		
				<br/>
			
				<div class="box-body">
                	<html:form action="/TaskUser">
                		<html:hidden name="TaskUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOCHANGESTATUS%>"/>
                		<html:hidden name="TaskUserForm" property="activityBean.activityId" />
                		<html:hidden name="TaskUserForm" property="activityStatus" />
                		<html:hidden name="TaskUserForm" property="taskId" />
                		<table class="form-input" align="center" style="width:60%">
                			<tr><td>Note</td></tr>
                			<tr><td><html:textarea name="TaskUserForm" property="activityBean.activityChangeNote" styleClass="form-control" rows="5"/></td></tr>
                		</table>
                	</html:form>
                  </div>
        	</div></div>
        </div>
	</section>
	
</body>
</html>