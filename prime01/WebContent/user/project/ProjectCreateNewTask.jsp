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
		<h1>Project<small>management project</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Project</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Data Project</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUser">
                		<html:hidden name="ProjectUserForm" property="task" value="<%=Constants.Task.Project.DOCREATETASK%>"/>
                		<html:hidden name="ProjectUserForm" property="projectBean.employeeId" />
                		<html:hidden name="ProjectUserForm" property="projectBean.projectMemberId" />
                		<table class="form-input" align="center">
                			<tr>
                				<td  width="100px">Task Name</td>
                				<td>:</td>
                				<td><html:text name="ProjectUserForm" property="projectBean.taskBean.taskName" styleClass="form-control"/></td>
                			</tr>
                			<tr>
                				<td>Member Name</td>
                				<td>:</td>
                				<td><html:text name="ProjectUserForm" property="projectBean.employeeName" styleClass="form-control" disabled="true" /></td>
                			</tr>
                			
                			<tr>
                				<td>Role</td>
                				<td>:</td>
                				<td><html:text name="ProjectUserForm" property="projectBean.roleName" styleClass="form-control" disabled="true" /></td>
                			</tr> 	
                			<tr>
                				<td>Start Date</td>
                				<td>:</td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                					<html:text name="ProjectUserForm" property="projectBean.taskBean.taskStartDate" styleClass="form-control" styleId="start-date"/></td>
                					</div>
                			</tr>
                			<tr>
                				<td>Estimate Date</td>
                				<td>:</td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                					<html:text name="ProjectUserForm" property="projectBean.taskBean.taskEstimateDate" styleClass="form-control" styleId="estimate-date"/>
							</div>
						</td>
                			</tr>
                			
                			
                			<tr>
                				<td>Project Description</td>
                				<td>:</td>
                				<td><html:textarea name="ProjectUserForm" property="projectBean.taskBean.taskDescription" styleClass="form-control"></html:textarea></td>
                			</tr>
                			
                			<tr>
                				<td colspan="3" align="center">
                					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="dosubmit()"/>
                					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
                				</td>
                			</tr>
                		</table>
                	</html:form>
                  </div>
        	</div>
        </div></div>
	</section>
	<!-- /.content-wrapper -->
</body>
</html>