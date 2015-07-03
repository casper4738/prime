<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<script type="text/javascript">	
		function openModalHandler(){
			//##0.Preparing Parameter For Modal Showing
			var tmpDataPosition=2;
			var tmpTask ="modalTable";
			var tmpTable ="employeeHead";
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=projectMember", $('#result'));
		}
		
		function sendNotifandDoSubmit(){
			alert($('#projectAssignerId').val());
			alert($('#projectId').val());
			
			sendNotification($('#projectAssignerId').val(),
		            		 <%=Constants.NotificationType.PROJECT_CREATEAPPROVAL%>,  
		         			"<%=Constants.PAGES_LIST[Constants.Page.USER_PROJECT_HEAD]%>;;" + $('#projectId').val() + ";" + $('#projectAssignerId').val());
			//dosubmit();
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
			<div class="box-header"><h3 class="box-title">Data Project</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUser">
                		<html:hidden name="ProjectUserForm" property="task" value="doSubmit"/>
                		<html:hidden name="ProjectUserForm" property="projectBean.projectName" />
             			<html:hidden name="ProjectUserForm" property="projectBean.projectId" styleId="projectId"/>
             			<html:hidden name="ProjectUserForm" property="projectBean.projectReceiver"/>
						<html:hidden name="ProjectUserForm" property="projectBean.projectAssigner" styleId="projectAssignerId"/>
                		<table class="form-input" align="center">
                		
                			<tr>
                				<td>Project Name</td>
                				<td>:</td>
                				<td><html:text name="ProjectUserForm" property="projectBean.projectName" styleClass="form-control" disabled="true"/></td>
                			</tr>
                		
                		
                			<tr>
                				<td>Note </td>
                				<td>:</td>
                				<td><html:textarea name="ProjectUserForm" property="projectBean.projectChangeNote" styleClass="form-control"></html:textarea></td>
                				
                			</tr>
                			
                			<tr>
                				<td colspan="3" align="center">
                					<html:button property=""  value="Save" styleClass="btn btn-primary" onclick="sendNotifandDoSubmit()"/>
                					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
                				</td>
                			</tr>
                		</table>
                	</html:form>
                  </div>
        	</div>
	</section>
	<!-- /.content-wrapper -->
		
	<!-- Modal -->
	<div class="modal fade" id="search-modal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">Search Assigner</h4>
	      </div>
	      <div class="modal-body" id="search-modal-body">
	      
	      </div>
	      <div class="modal-footer">
	      </div>
	    </div>
	  </div>
	</div>
	<!--/. Modal  -->
		
		
	
</body>
</html>