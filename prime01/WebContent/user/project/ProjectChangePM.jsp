<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<!-- End CSS -->
	
	<!-- JS -->
	<script type="text/javascript">
		
	function openModalHandler(){
		//##0.Preparing Parameter For Modal Showing
		var tmpDataPosition=2;
		var tmpTask ="modalTable";
		var tmpTable ="employeeList";
		
		//##1.Accessing Prime Method For Modal Showing
		modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=projectAssigner", $('#result'));
	}
	
		
			
		function flyToBack(task, value) {
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
			tmpForm.projectId.value = value;
		
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function validateForm() {
			var employeeName = checkNull($('#employeeName'), $('#err-employeeName'), "New Project Member");
			
			
			
			if(employeeName) {
				//alert("error lho");
			} else {
				dosubmit();
			}
			
		}
	</script>
	
	<!-- End JS -->
	
</head>
<body class="skin-blue sidebar-mini">
	
	<section class="content-header">
		<h1>Project User</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li><a href="javascript:flyToPage()" >Manage Project</a></li>
			<li class="active">Project Detail</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Change Project Manager</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUser">
                		<html:hidden name="ProjectUserForm" property="task" value="doChangePM"/>
                		<html:hidden name="ProjectUserForm" property="projectBean.projectId" />
                		<html:hidden name="ProjectUserForm" property="projectBean.projectName" />
                	    <html:hidden name="ProjectUserForm" property="employeeId" />
                	    <html:hidden name="ProjectUserForm" property="projectBean.employeeId" />
                	    <html:hidden name="ProjectUserForm" property="tempRoleId" />
                	    <html:hidden name="ProjectUserForm" property="projectId" />
                	    <html:hidden name="ProjectUserForm" property="projectBean.projectReceiver"/>
                	    <html:hidden name="ProjectUserForm" property="projectBean.projectAssigner"/>
                	    <html:hidden name="ProjectUserForm" property="projectBean.employeeIdReceiver"/>
                	    
                	    <html:hidden name="ProjectUserForm" property="projectBean.projectLastStatus"/>
                		<table class="form-input" align="center" style="width: 500px" >
                			<tr><td width="200px">ID Project</td>
                				<td>:</td>
                				<td class="input-group">
                				<span class="input-group-btn">
                					<html:text name="ProjectUserForm" property="projectBean.projectId" styleClass="form-control"  disabled="true"/>
								</span>
							</td></tr>
                			<tr><td width="200px">Project Name</td>
                				<td>:</td>
                				<td class="input-group">
                				<span class="input-group-btn">
                					<html:text name="ProjectUserForm" property="projectBean.projectName" styleClass="form-control"  disabled="true"/>
								</span>
							</td></tr>
							<tr><td width="200px">Old Project Manager</td>
                				<td>:</td>
                				<td class="input-group">
                				<span class="input-group-btn">
                					<html:text name="ProjectUserForm" property="projectBean.projectReceiverName" styleClass="form-control"  disabled="true"/>
								</span>
							</td></tr>
                			<tr><td width="200px">New Project Manager</td>
                				<td>:</td>
                				<td class="input-group">
                					<html:text name="ProjectUserForm" property="projectBean.employeeName" styleClass="form-control" styleId="employeeName" disabled="true"/>
	               					<span class="input-group-btn">
                    					<input type="button" class="btn btn-info" type="button" onclick="openModalHandler()" style="background-image:url(resources/image/search.png); background-repeat: no-repeat; background-position:center"/>
						            </span>
							</td></tr>
							<tr><td></td>
                				<td></td>
                				<td><span id="err-employeeName" class="error-validator"></span></td>
                			</tr>
                			<tr>
                				<td>Note Changing</td>
                				<td>:</td>
                				<td><html:textarea name="ProjectUserForm" property="projectBean.projectChangeNote" styleClass="form-control"></html:textarea></td>
                				
                			</tr>
                			
                			<tr><td colspan="3" align="center">
                					<html:button property=""  value="Save" styleClass="btn btn-primary" onclick="validateForm()"/>
                					<input type="button" class="btn btn-default" value='Cancel' onclick="flyToBack(
	                        		'detailsAsHead', 
	                        		'<bean:write name="ProjectUserForm" property="projectBean.projectId"/>')">
                				</td>
                			</tr>
                		</table>
                	</html:form>
                  </div>
        	</div>
        	</div>
        	</div>
	</section>
</body>
</html>
