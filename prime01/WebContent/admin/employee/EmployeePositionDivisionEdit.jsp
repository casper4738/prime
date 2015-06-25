<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
	<!-- End Of CSS -->
	<!-- JS -->
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#datepicker_birthdate').datepicker({
                format: "yyyy-mm-dd"
            }); 
            $('#datepicker_hiredate').datepicker({
                format: "yyyy-mm-dd"
            });
        });
		
		function openModalHandler(pParam){
			//##0.Preparing Parameter For Modal Showing
			var tmpDataPosition=$('#positionId').val();
			var tmpTask ="modalTable";
			var tmpTable ="employeeHead";
			alert("AA"+ pParam)
			//##1.Accessing Prime Method For Modal Showing
			if(pParam=='head'){
				modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=employeeAdd", $('#result'));
			}else if(pParam=='substituteHead'){
				alert("BB")
				var tmpParam =document.forms[0].employeeId.value;
				alert(tmpParam)
				modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=employeeResign&param4="+tmpParam, $('#result'));
			}
		}
		
		function fChange(pView){
			if(pView.value=="YES"){
				  document.getElementById('viewSubstituteHead').style.display="inline"
			}else{
				document.getElementById('viewSubstituteHead').style.display="none"
			}
		}
    </script>
    <!-- End Of JS -->
</head>
<body class="skin-blue sidebar-mini">
		<section class="content-header">
			<h1>Manage Employee<small>management system</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li class="active">Manage Employee</li>
			</ol>
		</section>

		<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Manage Employee Edit Position Division</h3></div>
				<div class="box-body">
                 	<html:form action="/EmployeeAdmin">
                 		<html:hidden name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOEDITPOSITION%>"/>
                 		<html:text name="EmployeeAdminForm" property="employeeBean.divisionId" />
                 		<html:text name="EmployeeAdminForm" property="employeeBean.divisionName" />
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.employeeId" />
			            <html:hidden name="EmployeeAdminForm" property="employeeBean.managerId" />
                 		<html:hidden name="EmployeeAdminForm" property="managerId"/>
                 		<html:hidden name="EmployeeAdminForm" property="employeeId"/>
                 		<html:hidden name="EmployeeAdminForm" property="substituteHeadId" />
                 		<table class="form-input" align="center" style="width: 500px;">
                 			<tr>
                 				<td>Employee ID</td>
                 				<td>:</td>
                 				<td>
	                 				<html:text name="EmployeeAdminForm" property="employeeBean.employeeId" styleClass="form-control" disabled="true"/>
								</td>
                 			</tr>
               				<tr>
                 				<td width="150px">Name</td>
                 				<td>:</td>
                 				<td><html:text name="EmployeeAdminForm" property="employeeBean.employeeName" styleClass="form-control" disabled="true"/></td>
                 			</tr>
                 			<tr>
	               				<td>Position</td>
	               				<td>:</td>
	               				<td>
		               				<html:select name="EmployeeAdminForm" property="employeeBean.positionId" styleClass="form-control" styleId="positionId">
		               					<html:options collection="listPosition" property="positionId" labelProperty="positionName" />
		               				</html:select>
								</td>
	               			</tr>
	               			<tr>
	               				<td>Head</td>
	               				<td>:</td>
	               				<td class="input-group">
	               					<html:text name="EmployeeAdminForm" property="employeeBean.managerName" styleClass="form-control" styleId="headName" disabled="true"/>
	               					<span class="input-group-btn">
                    							<input type="button" class="btn btn-info" type="button" onclick="openModalHandler('head')" style="background-image:url(resources/image/search.png); background-repeat: no-repeat; background-position:center"/>
						            </span>
								</td>
	               			</tr>
	               			<tr>
	               				<td>Division</td>
	               				<td>:</td>
		               			<td>
		               				<div id="isDivision" style="display: none">
					               		<html:hidden name="EmployeeAdminForm" property="divisionId" />
		               					<html:text name="EmployeeAdminForm" property="employeeBean.divisionName" styleClass="form-control" disabled="true" styleId="divisionName"/>
									</div>
									<div id="chooseDivision" style="display:inline">
		               					<html:select name="EmployeeAdminForm" property="divisionId" styleClass="form-control" styleId="divisionId">
			               					<html:option value="NULL">--All--</html:option>
			               					<html:options collection="listDivision" property="divisionId" labelProperty="divisionName" />
			               				</html:select>
			               			</div>
								</td>
	               			</tr>
	               			<tr>
	               				<td>Change Subtitute Head For Subordinate</td>
	               				<td>:</td>
		               			<td>
		               				<select name="changeSubstituteHead" class="form-control" onchange="fChange(this)">
		               					<option value="NO">NO</option>
		               					<option value="YES">YES</option>
		               				</select>
								</td>
	               			</tr>
	               			<tr>
	               				<td colspan="2">&nbsp;</td>
		               			<td>
		               				<div id="viewSubstituteHead" style="display: none" class="input-group">
		                 				<html:text name="EmployeeAdminForm" property="employeeBean.substituteHead" styleClass="form-control" styleId="substituteHead" disabled="true"/>
		               					<span class="input-group-btn">
	                    					<input type="button" class="btn btn-info" type="button" onclick="openModalHandler('substituteHead')" style="background-image:url(resources/image/search.png); background-repeat: no-repeat; background-position:center"/>
							            </span>
						            </div>
								</td>
	               			</tr>
                 			<tr>
                 				<td colspan="3" align="center">
                 					<html:button value="Save" styleClass="btn btn-primary" onclick="dosubmit()" property=""/>
                 					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
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