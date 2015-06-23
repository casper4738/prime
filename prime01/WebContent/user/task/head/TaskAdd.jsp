<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#start-date').datepicker({
                format: "yyyy-mm-dd"
            });  
            $('#estimate-date').datepicker({
                format: "yyyy-mm-dd"
            });
        });
    </script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Add Task<small>subordinate</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Tasks & Activities</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Add New Task</h3></div>
			<div class="box-body">
                	<html:form action="/TaskHeadUser">
                		<html:hidden name="TaskHeadUserForm" property="task" value="<%=Constants.Task.DOADD%>"/>
                		<html:hidden name="TaskHeadUserForm" property="taskBean.taskAssigner" />
                		<html:hidden name="TaskHeadUserForm" property="taskBean.taskReceiver" />
                		<table class="form-input" align="center" style="width:60%">
                			<tr>
                				<td width="150px">Task Name</td>
                				<td>:</td>
                				<td>
                				<td><html:text name="TaskHeadUserForm" property="taskBean.taskName" styleClass="form-control"/></td>
                			</tr>
                			<tr>
                				<td>Task Assigner</td>
                				<td>:</td>
                				<td>
                				<td><html:text name="TaskHeadUserForm"  property="taskBean.taskAssignerName" styleClass="form-control" disabled="true"/></td>
                			</tr>
                				<tr>
                				<td>Task Receiver</td>
                				<td>:</td>
                				<td>
                				<td><html:text name="TaskHeadUserForm" property="taskBean.taskReceiverName" styleClass="form-control" disabled="true" /></td>
                			</tr>
                				<tr>
                				<td>Start Date</td>
                				<td>:</td>
                				<td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                				  	<html:text name="TaskHeadUserForm" property="taskBean.taskStartDate" styleClass="form-control pull-right" styleId="start-date"/>
                				  	</div>
                				</td>
                			</tr>
                			<tr>
                				<td>Estimate Date</td>
                				<td>:</td>
                				<td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                				  	<html:text name="TaskHeadUserForm" property="taskBean.taskEstimateDate" styleClass="form-control pull-right" styleId="estimate-date"/>
                				  	</div>
                				</td>
					
						
                			</tr>
                			<tr>
                				<td>Description</td>
                				<td>:</td>
                				<td>
                				<td><html:textarea name="TaskHeadUserForm" property="taskBean.taskDescription" styleClass="form-control" rows="5"/></td>
                			</tr>
                			<tr>
                				<td colspan="6" align="center">
                					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="dosubmit()"/>
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