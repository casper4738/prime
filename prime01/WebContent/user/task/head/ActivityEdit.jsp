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
		<h1>Manage Tasks</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>Task & Activities</li>
			<li>As Head</li>
		  	<li>Task Detail</li>
		  	<li class="active">Edit Activity</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Edit Activity</h3></div>
			<div class="box-body">
                	<html:form action="/TaskHeadUser">
                		<html:hidden name="TaskHeadUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOEDIT%>"/>
                		<html:hidden name="TaskHeadUserForm" property="activityBean.activityId" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.taskId" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.activityStatus" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.activityChangeNote" />
                		<table class="form-input" align="center" style="width:60%">
                			<tr>
                				<td width="150px">Activity Name</td>
                				<td>: </td>
                				<td>
                				<td><html:text name="TaskHeadUserForm" property="activityBean.activityName" styleClass="form-control" disabled="true"/></td>
                			</tr>
                			
                			<tr>
                				<td>Description</td>
                				<td>:</td>
                				<td>
                				<td><html:textarea name="TaskHeadUserForm" property="activityBean.activityDescription" styleClass="form-control" rows="5"/></td>
                			</tr>
                			<tr>
                				<td colspan="6" align="center">
                					<html:submit value="Save" styleClass="btn btn-primary"/>
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