<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>Prime</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
	
		<jsp:include page="/content/Header.jsp"></jsp:include>
		<div class="content-wrapper">
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
                  				<td width="150px">Name</td>
                  				<td>:</td>
                  				<td><html:text name="EmployeeAdminForm" property="employeeBean.employeeName" styleClass="form-control"/></td>
                  			</tr>
                  			<%-- <tr>
                  				<td>Address</td>
                  				<td>:</td>
                  				<td>
                  				<html:text name="EmployeeAdminForm" property="employeeBean.address" styleClass="form-control"/>
								</td>
                  			</tr>
                  			<tr>
                  				<td>Birth Date</td>
                  				<td>:</td>
                  				<td>
                  					<div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                  				  		<html:text name="EmployeeAdminForm" property="employeeBean.birthdate" styleClass="form-control pull-right" styleId="datepicker_birthdate"/>
                  				  	</div>
								</td>
                  			</tr>
                  			<tr>
                  				<td>Contact Number</td>
                  				<td>:</td>
                  				<td>
                  				<html:text name="EmployeeAdminForm" property="employeeBean.contactNumber" styleClass="form-control"/>
								</td>
                  			</tr>
                  			<tr>
                  				<td>Email</td>
                  				<td>:</td>
                  				<td>
                  				<html:text name="EmployeeAdminForm" property="employeeBean.email" styleClass="form-control"/>
								</td>
                  			</tr>
                  			<tr>
                  				<td>Gender</td>
                  				<td>:</td>
                  				<td>              			
                  					<html:radio name="EmployeeAdminForm" property="employeeBean.gender" value="0" styleClass="minimal">Male</html:radio>
                  					<html:radio name="EmployeeAdminForm" property="employeeBean.gender" value="1" styleClass="minimal">Female</html:radio>
								</td>
                  			</tr>
                  			<tr>
                  				<td>Division</td>
                  				<td>:</td>
                  				<td>
                  				<html:text name="EmployeeAdminForm" property="employeeBean.divisionName" styleClass="form-control" disabled="true"/>
								</td>
                  			</tr>
                  			<tr>
                  				<td>Position</td>
                  				<td>:</td>
                  				<td>
                  				<html:select name="EmployeeAdminForm" property="employeeBean.positionId" styleClass="form-control">
                  					<html:options collection="listPosition" property="positionId" labelProperty="positionName" />
                  				</html:select>
								</td>
                  			</tr>
                  			<tr>
                  				<td>Level</td>
                  				<td>:</td>
                  				<td>
                  				<html:select name="EmployeeAdminForm" property="employeeBean.employeeLevel" styleClass="form-control">
                  					<html:optionsCollection name="listEmployeeLevel" label="value" value="key" />
                  				</html:select>
								</td>
                  			</tr>
                  			<tr>
                  				<td>Head</td>
                  				<td>:</td>
                  				<td>
                  				<html:text name="EmployeeAdminForm" property="employeeBean.managerName" styleClass="form-control" disabled="true"/>
								</td>
                  			</tr>
                  			<tr>
                  				<td>Hire Date</td>
                  				<td>:</td>
                  				<td>
                  					<div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                  				  		<html:text name="EmployeeAdminForm" property="employeeBean.hireDate" styleClass="form-control pull-right" styleId="datepicker_hiredate"/>
                  				  	</div>
								</td>
                  			</tr> --%>
                  			<tr>
                  				<td>Profile Picture</td>
                  				<td>:</td>
                  				<td>
                  				  <input type="file" id="exampleInputFile">
								</td>
                  			</tr>
                  			<tr>
                  				<td colspan="3" align="center">
                  					<html:submit value="Save" styleClass="btn btn-primary"/>
                  					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
                  				</td>
                  			</tr>
						</table>
                    </html:form>
                    </div>
		        	</div></div>
		        </div>
			</section>
		</div>
		<!-- /.content-wrapper -->
		<jsp:include page="/content/Footer.jsp"></jsp:include>
	</div>

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
</body>
</html>