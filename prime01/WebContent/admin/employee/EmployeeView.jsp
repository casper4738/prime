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
			<div class="box-header"><h3 class="box-title">Data Manage Employee</h3></div>
			<div class="box-body">
               	<html:form action="/EmployeeAdmin">
               		<html:hidden name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOADD%>"/>
               		<html:hidden name="EmployeeAdminForm" property="employeeBean.employeeId" />
               		<html:hidden name="EmployeeAdminForm" property="employeeBean.divisionId" />
               		<html:hidden name="EmployeeAdminForm" property="employeeBean.managerId" />
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
               				<td><bean:write name="EmployeeAdminForm" property="employeeBean.employeeName"/></td>
               			</tr>
               			<tr>
               				<td>Address</td>
               				<td>:</td>
               				<td>
               					<bean:write name="EmployeeAdminForm" property="employeeBean.address"/>
							</td>
               			</tr>
               			<tr>
               				<td>Birth Date</td>
               				<td>:</td>
               				<td>
		               			<bean:write name="EmployeeAdminForm" property="employeeBean.birthdate" format="dd MMMM yyyy"/>
							</td>
               			</tr>
               			<tr>
               				<td>Contact Number</td>
               				<td>:</td>
               				<td>
		               			<bean:write name="EmployeeAdminForm" property="employeeBean.contactNumber"/>
							</td>
               			</tr>
               			<tr>
               				<td>Email</td>
               				<td>:</td>
               				<td>
               					<bean:write name="EmployeeAdminForm" property="employeeBean.email"/>
							</td>
               			</tr>
               			<tr>
               				<td>Gender</td>
               				<td>:</td>
               				<td> 
                 				<logic:equal name="EmployeeAdminForm" property="employeeBean.gender" value="0">
			                		Male
					            </logic:equal>
					            <logic:equal name="EmployeeAdminForm" property="employeeBean.gender" value="1">
					                		Female
					            </logic:equal>	
							</td>
               			</tr>
               			<tr>
               				<td>Division</td>
               				<td>:</td>
               				<td>
               					<bean:write name="EmployeeAdminForm" property="employeeBean.divisionName"/>
						</td>
               			</tr>
               			<tr>
               				<td>Position</td>
               				<td>:</td>
               				<td>
               					<bean:write name="EmployeeAdminForm" property="employeeBean.positionName"/>
							</td>
               			</tr>
               			<tr>
               				<td>Head</td>
               				<td>:</td>
               				<td>
               					<bean:write name="EmployeeAdminForm" property="employeeBean.managerName"/>
							</td>
               			</tr>
               			<tr>
               				<td>Hire Date</td>
               				<td>:</td>
               				<td>
               					<bean:write name="EmployeeAdminForm" property="employeeBean.hireDate" format="dd MMMM yyyy"/>
							</td>
               			</tr>
               			<tr>
               				<td>Resign Date</td>
               				<td>:</td>
               				<td>
               					<bean:write name="EmployeeAdminForm" property="employeeBean.resignDate"/>
							</td>
               			</tr>
               			<tr>
               				<td>Resign Note</td>
               				<td>:</td>
               				<td>
		               			<bean:write name="EmployeeAdminForm" property="employeeBean.resignNote"/>
							</td>
               			</tr>
               			<tr>
               				<td>Photo</td>
               				<td>:</td>
               				<td>
               				<%-- <html:image src="resources/image/photodummy.png" /> --%>
							</td>
               			</tr>
               			<tr>
               				<td colspan="3">
               					<table class="form-input" align="center" style="width: 500px;">
			             			<tr>
			               				<td width="150px">
			               					<input type="button" property="" value="Set DayOff" styleClass="btn btn-default" 
			               					onclick="flyToEditDelete('<%=Constants.Task.GOTODAYOFF%>', '<bean:write name="EmployeeAdminForm" property="employeeBean.employeeId"/>')"/>
			               				</td>
			               			</tr>
			               		</table>
			               		<table id="table-1" class="table table-bordered table-striped table-hover">
									<thead>
										<tr>
											<th>Start Date</th>
											<th>End Date</th>
											<th>Total Days</th>
											<th>Desc</th>
						                </tr>
						            </thead>	
			             		</table>
               				</td>
               			</tr>
               			<tr>
               				<td colspan="3">
               					<table class="form-input" align="center" style="width: 500px;">
			             			<tr>
			               				<td width="150px"><input type="button" property="" value="Set WeekEnd" styleClass="btn btn-default" onclick="flyToEditDelete('<%=Constants.Task.GOTOWEEKEND%>', '<bean:write name="EmployeeAdminForm" property="employeeBean.employeeId"/>')"/></td>
			               			</tr>
			               		</table>
			               		<table id="table-1" class="table table-bordered table-striped table-hover">
									<thead>
										<tr>
											<th>Start Weekend</th>
											<th>Set Weekend</th>
						                </tr>
						            </thead>	
			             		</table>
							</td>
               			</tr>
               			<tr>
               				<td colspan="3" align="center">
               					<html:submit value="Edit" styleClass="btn btn-primary"/>
               					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
               					<html:button property="" value="Resign" styleClass="btn btn-default" onclick="flyToPage('success')"/>
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