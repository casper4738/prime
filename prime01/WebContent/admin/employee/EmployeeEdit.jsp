<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<!-- End Of CSS -->
	
	<!-- JS -->
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#datepicker_birthdate').datepicker({
                format: "yyyy-mm-dd"
            }); 
            $('#datepicker_hiredate').datepicker({
                format: "yyyy-mm-dd"
            });
        });
		
		function validateForm(){
			var specialChars 	= "/*!@#$%^&*()\"{}[]|\\?/<>,";
			var numexp = /^[0-9]+$/;
			var employeeName 	= $('#employeeName').val();
			var employeeAddress = $('#employeeAddress').val();
			var birthDate 		= $('#datepicker_birthdate').val();
			var contactNumber 	= $('#contactNumber').val();
			var email 		= $('#email').val();
			var hireDate 	= $('#datepicker_hiredate').val();
			var birthDateFormat = new Date(birthDate);
			var hireDateFormat = new Date(hireDate);
			
			var today = new Date();
			var tmpValidated 	= true;
			
			$('#validatorName').html("");
			$('#validatorAddress').html("");
			$('#validatorBirthDate').html("");
			$('#validatorContactNumber').html("");
			$('#validatorEmail').html("");
			$('#validatorGender').html("");
			$('#validatorPosition').html("");
			$('#validatorHead').html("");
			$('#validatorDivision').html("");
			$('#validatorHireDate').html("");
			
			if(employeeName == null || employeeName == "") {
				$('#validatorName').html("Employee must be filled out");
				tmpValidated = false;
			}
			
			if(employeeAddress == null || employeeAddress == "") {
				 $('#validatorAddress').html("Address must be filled out");
				 tmpValidated = false;
			}
			
			if(birthDate == null || birthDate == "") {
				 $('#validatorBirthDate').html("Birth Date must be filled out");
				 tmpValidated = false;
			}
			
		    if (birthDateFormat > today){
		    	$('#validatorBirthDate').html("Birth Date is not greater than today");
		    	tmpValidated = false;
		    }
		    
			if(contactNumber == null || contactNumber == "") {
				 $('#validatorContactNumber').html("Contact Number must be filled out");
				 tmpValidated = false;
			}
			
			if(contactNumber != null || contactNumber != ""){
			 	if(!contactNumber.match(numexp)){
			 		$("#validatorContactNumber").html("Alphabet are not allowed"); 
		        	tmpValidated = false;
		       	}
			}
			
			if(email == null || email == "") {
				 $('#validatorEmail').html("Email must be filled out");
				 tmpValidated = false;
			}else {
				 var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

			    if (!filter.test(email)) {
		  		  $('#validatorEmail').html("Email is not valid");
		  		  tmpValidated = false;
			    }
			}
			
			if(hireDate == null || hireDate == "") {
				 $('#validatorHireDate').html("Hire Date must be filled out");
				 tmpValidated = false;
			}
			
			 if (hireDateFormat > today){
				$('#validatorHireDate').html("Hire Date is not greater than today");
		    	tmpValidated = false;
		    }
			 
			if(tmpValidated){
				 dosubmit();
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
				<li><html:link href="#" onclick="flyToBack('home')" >Manage Employee</html:link></li>
				<li class="active">Manage Employee</li>
			</ol>
		</section>

		<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Manage Employee</h3></div>
				<div class="box-body">
                 	<html:form action="/EmployeeAdmin">
                 		<html:hidden name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOEDIT%>"/>
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.divisionId" />
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.managerId" />
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.employeeId" />
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
                 				<td><html:text name="EmployeeAdminForm" property="employeeBean.employeeName" styleClass="form-control" styleId="employeeName"/></td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>	    
                					<i><span id="validatorName" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                 			<tr>
                 				<td>Address</td>
                 				<td>:</td>
                 				<td>
	                 				<html:text name="EmployeeAdminForm" property="employeeBean.address" styleClass="form-control" styleId="employeeAddress"/>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>	    
                					<i><span id="validatorAddress" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                 			<tr>
                 				<td>Birth Date</td>
                 				<td>:</td>
                 				<td>
                 					<div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                 				  		<html:text name="EmployeeAdminForm" property="employeeBean.birthdate" styleClass="form-control pull-right" styleId="datepicker_birthdate" />
                 				  	</div>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>	    
                					<i><span id="validatorBirthDate" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                 			<tr>
                 				<td>Contact Number</td>
                 				<td>:</td>
                 				<td>
	                 				<html:text name="EmployeeAdminForm" property="employeeBean.contactNumber" styleClass="form-control" styleId="contactNumber"/>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>	    
                					<i><span id="validatorContactNumber" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                 			<tr>
                 				<td>Email</td>
                 				<td>:</td>
                 				<td>
	                 				<html:text name="EmployeeAdminForm" property="employeeBean.email" styleClass="form-control" styleId="email"/>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>	    
                					<i><span id="validatorEmail" style="color: red;font-size: 8"></span></i>
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
                 				<td>Position</td>
                 				<td>:</td>
                 				<td>
	                 				<%-- <html:select name="EmployeeAdminForm" property="employeeBean.positionId" styleClass="form-control">
	                 					<html:options collection="listPosition" property="positionId" labelProperty="positionName" />
	                 				</html:select> --%>
	                 				<html:text name="EmployeeAdminForm" property="employeeBean.positionName" styleClass="form-control" disabled="true"/>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>	    
                					<i><span id="validatorPosition" style="color: red;font-size: 8"></span></i>
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
                 				<td>Division</td>
                 				<td>:</td>
                 				<td>
                 				<html:text name="EmployeeAdminForm" property="employeeBean.divisionName" styleClass="form-control" disabled="true"/>
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
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>	    
                					<i><span id="validatorHireDate" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                 			<tr>
                 				<td colspan="3" align="center">
                 					<html:button value="Save" styleClass="btn btn-primary" onclick="validateForm()" property=""/>
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
