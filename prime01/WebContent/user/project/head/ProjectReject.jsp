<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script type="text/javascript">
		
		function openModalHandler(){
			//##0.Preparing Parameter For Modal Showing
			var tmpDataPosition=2;
			var tmpTask ="modalTable";
			var tmpTable ="employeeHead";
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=projectMember", $('#result'));
		}
		
		function flyToBack(task, value) {
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
			tmpForm.projectId.value = value;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function sendNotifandDoSubmit(){
			sendNotification($('#projectReceiverId').val(),
		            		 <%=Constants.NotificationType.PROJECT_SUBMITAPPROVALRETURN%>,  
		         			"<%=Constants.PAGES_LIST[Constants.Page.USER_PROJECT]%>;;" + $('#projectId').val() + ";" + $('#projectReceiverId').val());
			dosubmit();
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
			<li class="active"><a href="javascript:flyToBack(
	                        		'detailsAsHead', 
	                        		'<bean:write name="ProjectUserFormAsHead" property="projectId"/>')">Project Detail</a></li>
			<li class="active">Project Rejected Form</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Project Rejected Form</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUserAsHead">
                		<html:hidden name="ProjectUserFormAsHead" property="task" value="doReject"/>
                	
             			<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectId" styleId="projectId"/>
             			<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectReceiver" styleId="projectReceiverId"/>
						<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectAssigner"/>
             			<html:hidden name="ProjectUserFormAsHead" property="projectId"/>
                		<table class="form-input" align="center">
                		
                			<tr>
                				<td>Project Name</td>
                				<td>:</td>
                				<td><html:text name="ProjectUserFormAsHead" property="projectBean.projectName" styleClass="form-control" disabled="true"/></td>
                			</tr>
                		
                		
                			<tr>
                				<td>Note </td>
                				<td>:</td>
                				<td><html:textarea name="ProjectUserFormAsHead" property="projectBean.projectChangeNote" styleClass="form-control"></html:textarea></td>
                				
                			</tr>
                			
                			<tr>
                				<td colspan="3" align="center">
                					<html:button property=""  value="Save" styleClass="btn btn-primary" onclick="sendNotifandDoSubmit()"/>
                					<input type="button" property="" value="Cancel" class="btn btn-default" onclick="flyToBack('detailsAsHead','<bean:write name="ProjectUserFormAsHead" property="projectId"/>')"/>
                				</td>
                			</tr>
                		</table>
                	</html:form>
                  </div>
        	</div>
	</section>
	<!-- /.content-wrapper -->
		
	
</body>
</html>