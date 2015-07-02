<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#startDate').datepicker({
                format: "yyyy-mm-dd"
            });  
            $('#estimateDate').datepicker({
                format: "yyyy-mm-dd"
            });
        });
		
		function openModalHandler(){
			//##0.Preparing Parameter For Modal Showing
			var tmpDataPosition=document.forms[0].positionId.value;
			var tmpTask ="modalTable";
			var tmpTable ="employeeTree";
			var tmpDiv =document.forms[0].divisionId.value;
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=projectAssigner"+"&param5="+tmpDiv, $('#result'));
		}
		
		function validateForm() {
			var projectName = checkNull($('#projectName'), $('#err-projectName'), "Project Name");
			var startDate = checkNull($('#startDate'), $('#err-startDate'), "Project Start Date");
			var estimateDate = checkNull($('#estimateDate'), $('#err-estimateDate'), "Project Estimate Date");
			var employeeName = checkNull($('#employeeName'), $('#err-employeeName'), "Project Assigner");
			var projectDescription = checkNull($('#projectDescription'), $('#err-projectDescription'), "Project Description");
			
			var checkDate = checkForDate($('#startDate'), $('#estimateDate'), $('#err-startDate'), $('#err-estimateDate'), "Project Start Date", "Project Estimate Date");
			
			if(projectName || startDate || estimateDate || projectDescription) {
			} else {
				dosubmit();
			}
		}
	</script>
	
	<!-- End JS -->
	
</head>
<body class="skin-blue sidebar-mini">
	
	<section class="content-header">
		<h1>Project</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')" >Manage Project</html:link></li>
			<li class="active">Project</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header" align="center"><h3 class="box-title">Add New Project</h3></div>
			<div class="box-body">
                	<html:form action="/ProjectUser">
                		<html:hidden name="ProjectUserForm" property="task" value="<%=Constants.Task.DOADD%>"/>
                		<html:hidden name="ProjectUserForm" property="projectBean.projectName" />
                		<html:hidden name="ProjectUserForm" property="employeeId" />
                		<html:hidden name="ProjectUserForm" property="projectBean.projectAssigner" />
                		<html:hidden name="ProjectUserForm" property="projectBean.projectReceiver" />
                		<html:hidden name="ProjectUserForm" property="divisionId" />
                		<html:hidden name="ProjectUserForm" property="positionId"/>
                		
                		<table class="form-input" align="center" style="width: 500px;">
                			<tr><td width="150px">Project Name</td>
                				<td>:</td>
                				<td><html:text name="ProjectUserForm" property="projectBean.projectName" styleId="projectName" styleClass="form-control"/></td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-projectName" class="error-validator"></span></td>
                			</tr>
                			<tr><td>Start Date</td>
                				<td>:</td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                					<html:text name="ProjectUserForm" property="projectBean.projectStartDate" styleClass="form-control" styleId="startDate"/>
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
                						<html:text name="ProjectUserForm" property="projectBean.projectEstimateDate" styleClass="form-control" styleId="estimateDate"/>
									</div>
								</td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-estimateDate" class="error-validator"></span></td>
                			</tr>
                			<tr><td>Project Assigner</td>
                				<td>:</td>
                				<td class="input-group">
                					<html:text name="ProjectUserForm" property="projectBean.employeeName" styleClass="form-control" styleId="employeeName" disabled="true"/>
	               					<span class="input-group-btn">
                    					<input type="button" class="btn btn-info" type="button" onclick="openModalHandler()" style="background-image:url(resources/image/search.png); background-repeat: no-repeat; background-position:center"/>
						            </span>
								</td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-employeeName" class="error-validator"></span></td>
                			</tr>
                			
                			<tr><td>Project Description</td>
                				<td>:</td>
                				<td><html:textarea name="ProjectUserForm" property="projectBean.projectDescription" styleId="projectDescription" styleClass="form-control"></html:textarea></td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-projectDescription" class="error-validator"></span></td>
                			</tr>
                			<tr>
                				<td colspan="3" align="center">
                					<html:button property=""  value="Save" styleClass="btn btn-primary" onclick="validateForm()"/>
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
