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
			var tmpTable ="employeeHead";
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=projectMember", $('#result'));
		}
	</script>
	
	<!-- End JS -->
	
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
			<div class="box-header"><h3 class="box-title">Add New Project Member</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUser">
                		<html:hidden name="ProjectUserForm" property="task" value="<%=Constants.Task.Project.DOCREATEMEMBER%>"/>
                		<html:hidden name="ProjectUserForm" property="projectBean.projectId" />
                		<html:hidden name="ProjectUserForm" property="projectBean.projectName" />
                	    <html:hidden name="ProjectUserForm" property="employeeId" />
                		<table class="form-input" align="center">
                			<tr>
                				<td>Employee Name</td>
                				<td>:</td>
                				<td class="input-group">
                					<html:text name="ProjectUserForm" property="projectBean.employeeName" styleClass="form-control" styleId="employeeName" disabled="true"/>
	               					<span class="input-group-btn">
                    					<input type="button" class="btn btn-info" type="button" onclick="openModalHandler()" style="background-image:url(resources/image/search.png); background-repeat: no-repeat; background-position:center"/>
						            </span>
								</td>
                			</tr>
                			
                			<tr>
                				<td>Choose Member Role</td>
                				<td>:</td>
                				<td>
                					<html:select name="ProjectUserForm" property="projectBean.roleBean.roleId" styleId="roleid" styleClass="form-control">
		                  		  		<html:options collection="listAllRoles" property="roleId" labelProperty="roleName"/>
		                  		  	</html:select>
                				</td>
                				
                			</tr>
                			
                			<tr>
                				<td colspan="3" align="center">
                					<html:button property=""  value="Save" styleClass="btn btn-primary" onclick="dosubmit()"/>
                					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
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