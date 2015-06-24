<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head>
<!-- CSS -->
<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<link href="resources/ionicons-2.0.1/css/ionicons.min.css"
	rel="stylesheet" type="text/css" />
<link href="resources/plugins/datepicker/datepicker3.css"
	rel="stylesheet" type="text/css" />
<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet"
	type="text/css" />
<link href="resources/dist/css/skins/_all-skins.min.css"
	rel="stylesheet" type="text/css" />
<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
<!-- End Of CSS -->
<!-- JS -->
<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
<script src="resources/bootstrap/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="resources/plugins/datepicker/bootstrap-datepicker.js"
	type="text/javascript"></script>
<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js"
	type="text/javascript"></script>
<script src="resources/plugins/fastclick/fastclick.min.js"></script>
<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
<script src="resources/dist/js/demo.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#datepicker_startdate').datepicker({
			format : "yyyy-mm-dd"
		});
		$('#datepicker_enddate').datepicker({
			format : "yyyy-mm-dd"
		});
	});
	
	function getMondays(pMonth) {
	    var d = new Date(),
		mondays = [];

	    monthSelected=pMonth.value
	    d.setDate(1);
	    d.setMonth(monthSelected);
	    // Get the first Monday in the month
	    while (d.getDay() !== 1) {
	    	d.setDate(d.getDate() + 1);
	    }

	    // Get all the other Mondays in the month
	    while (d.getMonth() == monthSelected) {
	        mondays.push(new Date(d.getTime()));
	        d.setDate(d.getDate() + 7);
	    }
		
	    alert(mondays)
	    
	    document
	    /* 
	    while(){
	    	listMondayDate.add()
	    } */
	}
</script>
<!-- End Of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>
			Manage Employee<small>management system</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage Employee</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">Data Manage Employee</h3>
					</div>
					<div class="box-body">
						<html:form action="/EmployeeAdmin">
							<html:hidden name="EmployeeAdminForm" property="task"
								value="<%=Constants.Task.DOEDIT%>" />
							<html:hidden name="EmployeeAdminForm"
								property="employeeBean.divisionId" />
							<html:hidden name="EmployeeAdminForm"
								property="employeeBean.managerId" />
							<table class="form-input" align="center" style="width: 500px;">
								<tr>
									<td>Employee ID</td>
									<td>:</td>
									<td><html:text name="EmployeeAdminForm"
											property="employeeBean.employeeId" styleClass="form-control"
											disabled="true" /></td>
								</tr>
								<tr>
									<td width="150px">Name</td>
									<td>:</td>
									<td><html:text name="EmployeeAdminForm"
											property="employeeBean.employeeName"
											styleClass="form-control" disabled="true" /></td>
								</tr>
								<tr>
									<td>Start Weekend</td>
									<td>:</td>
									<td>
										<html:select name="EmployeeAdminForm"
											property="employeeBean.monthYear" styleClass="form-control"
											styleId="monthYear" onchange="getMondays(this)">
											<html:option value="">--Select--</html:option>
											<html:optionsCollection name="listMonthYear" label="value" value="key" />
										</html:select>
									</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;</td>
									<td>
										<html:select name="EmployeeAdminForm" property="employeeBean.mondayDate" styleClass="form-control" styleId="mondayDate">
											<html:optionsCollection name="listMonthYear" label="value" value="key" />
										</html:select>
									</td>
								</tr>
								<tr>
									<td>Set Weekend</td>
									<td>:</td>
									<td>
										<html:checkbox property="employeeBean.weekEnd">Monday</html:checkbox> <br>
										<html:checkbox property="employeeBean.weekEnd">Tuesday</html:checkbox> <br> 
										<html:checkbox property="employeeBean.weekEnd">Wednesday</html:checkbox> <br>
										<html:checkbox property="employeeBean.weekEnd">Thursday</html:checkbox><br> 
										<html:checkbox property="employeeBean.weekEnd">Friday</html:checkbox> <br>
										<html:checkbox property="employeeBean.weekEnd">Saturday</html:checkbox><br>
										<html:checkbox property="employeeBean.weekEnd">Sunday</html:checkbox>
									</td>
								</tr>
								<tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr>
                 				<td colspan="3" align="center">
                 					<html:button property="" value="Save" styleClass="btn btn-default" onclick="dosubmit()"/>
                 					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('view')"/>
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