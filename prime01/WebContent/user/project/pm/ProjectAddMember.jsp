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
	<script src="resources/prime.js" type="text/javascript"></script>
	<script type="text/javascript">
		
		function openModalHandler(){
			//##0.Preparing Parameter For Modal Showing
			var tmpTask ="modalTable";
			var tmpTable ="employeeProjectMember";
			var idAssigner=document.getElementById('idAssigner').value;
			var projectId=document.getElementById('projectId').value;
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + idAssigner + "&param4=" + projectId , $('#result')); 
		}
		
		function isNullCheckedRool(){
			var tmpForm = document.forms[0];
			
			var tempRoleId=""; 
			var bool = true;
			for(var i=0; i < tmpForm.roleId.length; i++) {
				if(tmpForm.roleId[i].checked) {
					tempRoleId+=tmpForm.roleId[i].value+",";
					bool = false;
			  	}
			}
		  	tempRoleId = tempRoleId.substring(0, tempRoleId.length - 1);
		  	tmpForm.tempRoleId.value=tempRoleId;
		  	
		  	return bool;
		}
		
		function nullCheked(err_var1, title) {
			if(isNullCheckedRool()) { 
				err_var1.html(title+" must be checked minimal one");
				return true;
			}
			return false;
		}
		
		function flyToBack(task, value) {
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
			tmpForm.projectId.value = value;
		
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function validateForm() {
			var employeeName = checkNull($('#employeeName'), $('#err-employeeName'), "Employee Name");
			var checkedRole =  nullCheked($('#err-checkedRole'), "Role"); 
			
			if(employeeName || checkedRole) {
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
			<li><a href="javascript:void(0)" onclick="menuLoadHandler('${homepage}')"> <i class="fa fa-dashboard"></i> Home</a></li> 
			<li><a href="javascript:flyToPage()" >Manage Project</a></li>
			<li class="active">Project Detail</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Add New Project Member</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUser">
                		<html:hidden name="ProjectUserForm" property="task" value="<%=Constants.Task.PROJECT.DOCREATEMEMBER%>"/>
                		<html:hidden name="ProjectUserForm" property="projectBean.projectId" />
                		<html:hidden name="ProjectUserForm" property="projectBean.projectName" />
                	    <html:hidden name="ProjectUserForm" property="employeeId" />
                	    <html:hidden name="ProjectUserForm" property="tempRoleId" />
                	    <html:hidden name="ProjectUserForm" property="projectId" styleId="projectId" />
                	    <html:hidden name="ProjectUserForm" property="idAssigner" styleId="idAssigner"/>
                	
                		<table class="form-input" align="center" style="width:60%" >
                			<tr><td width="200px">Employee Name</td>
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
                			<tr><td valign="top">Choose Member Role</td>
                				<td valign="top">:</td>
                				<td><logic:notEmpty name="listAllRoles">
		                  		  		<logic:iterate id="iterate" name="listAllRoles">
		                  		  			<html:checkbox property="roleId" value="${iterate.roleId}" /> <bean:write name="iterate" property="roleName"/><br>
		                  		  		</logic:iterate>
		                  		  	</logic:notEmpty>
                				</td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-checkedRole" class="error-validator"></span></td>
                			</tr>
                			<tr><td colspan="3" align="center">
                					<html:button property=""  value="Save" styleClass="btn btn-primary" onclick="validateForm()"/>
                					<input type="button" class="btn btn-default" value='Cancel' onclick="flyToBack(
	                        		'<%=Constants.Task.PROJECT.GOTOPROJECTDETAIL %>', 
	                        		'<bean:write name="ProjectUserForm" property="projectId"/>')">
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
