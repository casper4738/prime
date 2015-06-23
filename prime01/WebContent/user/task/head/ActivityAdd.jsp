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
		<h1>Manage Tasks</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>Task & Activities</li>
			<li>As Head</li>
		  	<li>Task Detail</li>
		  	<li class="active">Add Activity</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Add New Activity</h3></div>
			<div class="box-body">
                	<html:form action="/TaskHeadUser">
                		<html:hidden name="TaskHeadUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOADD%>"/>
                		<html:hidden name="TaskHeadUserForm" property="activityBean.activityId" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.taskId" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.activityStatus" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.activityChangeNote" />
                		<table class="form-input" align="center" style="width:60%">
                			<tr>
                				<td width="150px">Activity Name</td>
                				<td>: </td>
                				<td>
                				<td><html:text name="TaskHeadUserForm" property="activityBean.activityName" styleClass="form-control"/></td>
                			</tr>
                			
                			<tr>
                				<td>Description</td>
                				<td>:</td>
                				<td>
                				<td><html:textarea name="TaskHeadUserForm" property="activityBean.activityDescription" styleClass="form-control" rows="5"/></td>
                			</tr>
                			<tr>
                				<td colspan="6" align="center">
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
	
</body>
</html>