<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<script src="resources/prime.js" type="text/javascript"></script>
	<script type="text/javascript">
		function doback() {
			var tmpForm = document.forms[0];
			tmpForm.task.value = "<%=Constants.Task.GOTOVIEW%>";
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function docancel() {
			var tmpForm = document.forms[0];
			tmpForm.task.value = "success";
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function validateForm() {
			var activityName = checkNull($('#activityName'), $('#err-activityName'), "Activity Name");
			if(activityName) {
				//alert("error lho");
			} else {
				dosubmit();
			}
			
		}
    </script>
</head>
<body class="skin-blue sidebar-mini">

	<section class="content-header">
		<h1>Manage Tasks<small> As Head</small></h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')">Tasks & Activities</html:link></li>
		  	<li><html:link href="#" onclick="flyToBack('<%=Constants.Task.GOTOVIEW%>')">Tasks Detail</html:link></li>
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
                		<html:hidden name="TaskHeadUserForm" property="taskId" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.activityId" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.taskId" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.activityStatus" />
                		<html:hidden name="TaskHeadUserForm" property="activityBean.activityChangeNote" />
                		<table class="form-input" align="center" style="width:60%">
                			<tr>
                				<td width="150px">Activity Name</td>
                				<td>: </td>
                				<td>
                				<td><html:text name="TaskHeadUserForm" property="activityBean.activityName" styleClass="form-control" styleId="activityName" disabled="true"/></td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-activityName" class="error-validator"></span></td>
                			</tr>
                			<tr>
                				<td>Description</td>
                				<td>:</td>
                				<td>
                				<td><html:textarea name="TaskHeadUserForm" property="activityBean.activityDescription" styleClass="form-control" rows="5"/></td>
                			</tr>
                			<tr>
                				<td colspan="6" align="center">
                					<input type="button" value="Save"  class="btn btn-primary" onclick="validateForm()" />
                					<input type="button" value="Cancel" class="btn btn-default"onclick="flyToBack('<%=Constants.Task.GOTOVIEW%>')"/>
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