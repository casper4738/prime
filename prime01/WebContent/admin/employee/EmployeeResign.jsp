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
            $('#datepicker_resigndate').datepicker({
                format: "yyyy-mm-dd"
            });
        });
		
		function openModalHandler(){
			//##0.Preparing Parameter For Modal Showing
			var tmpDataPosition=$('#positionId').val();
			var tmpTask ="modalTable";
			var tmpTable ="employeeHead";
			var tmpParam =document.forms[0].employeeId.value;
			var tmpDiv =document.forms[0].divisionId.value;
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable + "&param2=" + tmpDataPosition+ "&param3=employeeResign&param4="+tmpParam+"&param5="+tmpDiv , $('#result'));
		}
		
		function validateForm(){
			var resignNote = $('#resignNote').val();
			var resignDate 		= $('#datepicker_resigndate').val();
			var resignDateFormat = new Date(resignDate);
			
			var today = new Date();
			var tmpValidated 	= true;
			
			$('#validatorResignNote').html("");
			$('#validatorBirthDate').html("");
			
			
			
			if(resignNote == null || resignNote == "") {
				 $('#validatorResignNote').html("Resign Note must be filled out");
				 tmpValidated = false;
			}
			
			if(resignDate == null || resignDate == "") {
				 $('#validatorResignDate').html("Resign Date must be filled out");
				 tmpValidated = false;
			}
			
		    if (resignDateFormat > today){
		    	$('#validatorResignDate').html("Resign Date is not allowed greater than today");
		    	tmpValidated = false;
		    }
		    
			
			 
			if(tmpValidated){
				 //Do Database Checking, if Success Fly To
				  $('#employee-validating').html("<i class=\"fa fa-refresh fa-spin\"></i> Validating employee data");
				  $('#btn-save').hide();
				  $('#btn-cancel').hide();
				  $.ajax({ 
			          type	  : "POST",
			          url	  : '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>',  
			          data	  : 'task=<%=Constants.Task.DOVALIDATE1%>&managerId=' + $('#managerId').val(),
			          success : function(msg){
							 param = msg.split('#');
							 
							 if(param[0] == "0"){ //Success
								$('#employee-validating').html("<i class=\"fa fa-refresh fa-spin\"></i> Uploading employee data");
							 	var formData = new FormData(document.forms[0]);
							 	$.ajax({ 
							          type	  	  : "POST",
							          url	  	  : '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>',  
							          data	  	  : formData,
							          contentType : false,
							          processData : false,
							          success : function(){
											menuLoadHandler('<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>', "message=Resign Successful");
							          }
							 	});							 	
							 } else {			   //Failed
								 $('#employee-validating').html(param[1]);
							 	 $('#btn-save').show();
								 $('#btn-cancel').show();
							 }
			          },
			          
			          error: function(){
							alert("ERROR");
			        	  	//TO DO :: Add Error Handling
			          }
			     });
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
				<div class="box-header"><h3 class="box-title">Data Manage Employee</h3></div>
				<div class="box-body">
                 	<html:form action="/EmployeeAdmin">
                 		<html:hidden name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DORESIGN%>"/>
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.divisionId" />
                 		<html:hidden name="EmployeeAdminForm" property="divisionId" />
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.managerId" />
                 		<html:hidden name="EmployeeAdminForm" property="employeeId" />
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.treeId"/>
                 		<html:hidden name="EmployeeAdminForm" property="substituteHeadId" />
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.employeeId" />
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.positionId" styleId="positionId"/>
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
                 				<td>Resign Date</td>
                 				<td>:</td>
                 				<td>
                 					<div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                 				  		<html:text name="EmployeeAdminForm" property="employeeBean.resignDate" styleClass="form-control pull-right" styleId="datepicker_resigndate"/>
                 				  	</div>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>	    
                					<i><span id="validatorResignDate" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                 			<tr>
                 				<td>Resign Note</td>
                 				<td>:</td>
                 				<td>
	                 				<html:textarea name="EmployeeAdminForm" property="employeeBean.resignNote" styleClass="form-control" styleId="resignNote"/>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>	    
                					<i><span id="validatorResignNote" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                 			<tr>
                 				<td>Choose Subtitute Head</td>
                 				<td>:</td>
                 				<td class="input-group">
	                 				<html:text name="EmployeeAdminForm" property="employeeBean.substituteHead" styleClass="form-control" styleId="substituteHead" disabled="true"/>
	               					<span class="input-group-btn">
                    					<input type="button" class="btn btn-info" type="button" onclick="openModalHandler()" style="background-image:url(resources/image/search.png); background-repeat: no-repeat; background-position:center"/>
						            </span>
								</td>
                 			</tr>
                 			<tr>
                  				<td></td>
								<td></td>
                  				<td><div id="employee-validating"></div></td>
                  			</tr>
                 			<tr>
                 				<td colspan="3" align="center">
                 					<html:button value="Save" styleClass="btn btn-primary" onclick="validateForm()" property="" id="btn-save"/>
                 					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')" id="btn-cancel"/>
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