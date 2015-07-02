<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/prime.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#start-date').datepicker({
                format: "yyyy-mm-dd"
            });  
            $('#estimate-date').datepicker({
                format: "yyyy-mm-dd"
            });
        });
		
		function validateForm() {
			var taskName = checkNull($('#taskName'), $('#err-taskName'), "Task Name");
			
			var checkDate = checkForDate($('#start-date'), $('#estimate-date'), $('#err-startDate'), $('#err-estimateDate'), "Task Start Date", "Task Estimate Date");
			var startDate = checkNull($('#start-date'), $('#err-startDate'), "Task Start Date");
			var estimateDate = checkNull($('#estimate-date'), $('#err-estimateDate'), "Task Estimate Date");
			
			if(taskName || startDate || estimateDate) {
			//	alert("error lho");
			} else {
				//alert("masuk")
				dosubmit();
			}
			
		}
		
		function flyToTaskDetail(back, value) {
			alert(value)
			var tmpForm = document.forms[0];
			tmpForm.task.value = back;
			tmpForm.employeeId.value = value;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
	</script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Project User</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li><a href="javascript:flyToPage()" >Manage Project</a></li>
			<li><a href="javascript:flyToBack(
	                        		'<%=Constants.Task.PROJECT.GOTOPROJECTDETAIL %>', 
	                        		'<bean:write name="ProjectUserForm" property="projectId"/>')">Project Detail</a></li>
			<li class="active">Project Member Detail</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Data Project</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUser">
                		<html:hidden name="ProjectUserForm" property="task" value="<%=Constants.Task.PROJECT.DOCREATETASK%>"/>
                		<html:hidden name="ProjectUserForm" property="back"/>
						<html:hidden name="ProjectUserForm" property="taskId"/>
						<html:hidden name="ProjectUserForm" property="employeeId"/>
						<html:hidden name="ProjectUserForm" property="taskBean.taskId"/>
                		<html:hidden name="ProjectUserForm" property="projectBean.projectId" />
                		<html:hidden name="ProjectUserForm" property="projectBean.employeeId" />
                		<html:hidden name="ProjectUserForm" property="projectBean.taskBean.taskStatus" value='<%=Constants.Status.CREATE+""%>'/>
                		<html:hidden name="ProjectUserForm" property="projectBean.taskBean.taskChangeNote" value=""/>
                		<table class="form-input" align="center">
                			<tr>
                				<td  width="200px">Task Name</td>
                				<td>:</td>
                				<td><html:text name="ProjectUserForm" property="projectBean.taskBean.taskName" styleClass="form-control" styleId="taskName"/></td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-taskName" class="error-validator"></span></td>
                			</tr>
                			<tr>
                				<td>Member Name</td>
                				<td>:</td>
                				<td><html:text name="ProjectUserForm" property="projectBean.employeeName" styleClass="form-control" disabled="true" styleId="employeeName" /></td>
                			</tr>
                			<tr>
                				<td>Role</td>
                				<td>:</td>
                				<td><html:select name="ProjectUserForm" property="projectBean.roleBean.roleId" styleId="roleid" styleClass="form-control">
		                  		  		<html:options collection="listRoles" property="roleId" labelProperty="roleName"/>
		                  		  	</html:select>
								</td>
                			</tr> 	
                			<tr>
                				<td>Start Date</td>
                				<td>:</td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                					<html:text name="ProjectUserForm" property="projectBean.taskBean.taskStartDate" styleClass="form-control" styleId="start-date"/>
                					</div>
               					</td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-startDate" class="error-validator"></span></td>
                			</tr>
                			<tr>
                				<td>Estimate Date</td>
                				<td>:</td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                					<html:text name="ProjectUserForm" property="projectBean.taskBean.taskEstimateDate" styleClass="form-control" styleId="estimate-date"/>
									</div>
								</td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-estimateDate" class="error-validator"></span></td>
                			</tr>
                			
                			
                			<tr>
                				<td>Task Note</td>
                				<td>:</td>
                				<td><html:textarea name="ProjectUserForm" property="projectBean.taskBean.taskDescription" styleClass="form-control"></html:textarea></td>
                			</tr>
                			
                			<tr>
                				<td colspan="3" align="center">
                					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="validateForm()"/>
                					<input type="button" class="btn btn-default" value='Cancel' onclick="flyToTaskDetail(
                     	        				'<%=Constants.Task.PROJECT.GOTOTASKMEMBER%>', 
                     	        				'<bean:write name="ProjectUserForm" property="employeeBean.employeeId"/>')">
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