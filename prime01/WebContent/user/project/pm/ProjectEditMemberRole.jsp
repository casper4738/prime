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
		$(document).ready(function () {
	        var data = $('#roleId').val();
			var arr = data.split(', ');
	        for(i=0;i<arr.length;i++){
	        	var temp = "#" + arr[i].toString();
	        	$(temp).attr("checked", true);
	        }  
	    });
		
		function dosubmit() {
			var tmpForm = document.forms[0];
			var tempRoleId = "";
			for(var i=0; i < tmpForm.roleId.length; i++) {
				if(tmpForm.roleId[i].checked) {
					tempRoleId+=tmpForm.roleId[i].value+",";
				}
			}
			tempRoleId = tempRoleId.substring(0, tempRoleId.length - 1);
			//alert(tempRoleId);
			tmpForm.tempRoleId.value = tempRoleId; 
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
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
			<div class="box-header"><h3 class="box-title">Edit Member Role</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUser"  >
                		<html:hidden name="ProjectUserForm" property="task" value="<%=Constants.Task.PROJECT.DOEDITMEMBER%>"/>
                		<html:hidden name="ProjectUserForm" property="projectBean.projectId" />
                		<html:hidden name="ProjectUserForm" property="projectBean.employeeId" />
                		<html:hidden name="ProjectUserForm" property="tempRoleId" />
                		<html:hidden name="ProjectUserForm" property="projectId" />
                		<table class="form-input" align="center" style="width:60%">
	                		<tr><td width="200px">Employee Name</td>
                				<td>:</td>
                				<td class="input-group">
                					<html:text name="ProjectUserForm" property="projectBean.employeeName" styleClass="form-control" styleId="employeeName" disabled="true"/>
	               					<span class="input-group-btn">
                    					<input type="button" class="btn btn-info" type="button" style="background-image:url(resources/image/search.png); background-repeat: no-repeat; background-position:center"/>
						            </span>
							</td></tr>
                			<tr><td valign="top">Choose Member Role</td>
                				<td valign="top">:</td>
                				<td><logic:iterate id="iter" name="listRoles">
                						<logic:equal name="iter" property="projectMemberId" value="0">
                							<input type="checkbox" name="roleId" value="${iter.roleId};${iter.projectMemberId};${iter.projectMemberStatus}"/><bean:write name="iter" property="roleName" />
                						</logic:equal>
                						<logic:notEqual name="iter" property="projectMemberId" value="0">
	                						<logic:equal name="iter" property="projectMemberStatus" value="1">
    	            							<input type="checkbox" name="roleId" value="${iter.roleId};${iter.projectMemberId};${iter.projectMemberStatus}" checked="checked"/><bean:write name="iter" property="roleName" />
	                						</logic:equal>
	                						<logic:equal name="iter" property="projectMemberStatus" value="0">
    	            							<input type="checkbox" name="roleId" value="${iter.roleId};${iter.projectMemberId};${iter.projectMemberStatus}"/><bean:write name="iter" property="roleName" />
	                						</logic:equal>
                						</logic:notEqual>
                						<br/>
	                  		  		</logic:iterate>
                			</td></tr>
                			<tr><td colspan="3" align="center">
                					<html:button property=""  value="Save" styleClass="btn btn-primary" onclick="dosubmit()"/>
                					<input type="button" class="btn btn-default" value='Cancel' onclick="flyToBack(
	                        		'<%=Constants.Task.PROJECT.GOTOPROJECTDETAIL %>', 
	                        		'<bean:write name="ProjectUserForm" property="projectBean.projectId"/>')">
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