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
            $('#datepicker_startdate').datepicker({
                format: "yyyy-mm-dd"
            }); 
            $('#datepicker_enddate').datepicker({
                format: "yyyy-mm-dd"
            });
        });
		
		function validateForm(){
			var descDayOff = $('#descDayOff').val();
			var startDate 		= $('#datepicker_startdate').val();
			var startDateFormat = new Date(startDate);
			var endDate 		= $('#datepicker_enddate').val();
			var endDateFormat = new Date(endDate);
			
			var today = new Date();
			var tmpValidated 	= true;
			
			$('#validatorDescDayOff').html("");
			$('#validatorStartDate').html("");
			$('#validatorEndDate').html("");
			
			if(descDayOff == null || descDayOff == "") {
				 $('#validatorDescDayOff').html("Description must be filled out");
				 tmpValidated = false;
			}
			
			if(startDate == null || startDate == "") {
				 $('#validatorStartDate').html("Start Date must be filled out");
				 tmpValidated = false;
			}
			
		    if (startDateFormat < today){
		    	$('#validatorStartDate').html("Start Date is not allowed lower than today");
		    	tmpValidated = false;
		    }
		    
		    if(endDate == null || endDate == "") {
				 $('#validatorEndDate').html("End Date must be filled out");
				 tmpValidated = false;
			}
			
		    if (endDateFormat < today){
		    	$('#validatorEndDate').html("End Date is not allowed lower than today");
		    	tmpValidated = false;
		    }else if (endDateFormat < startDateFormat){
		    	$('#validatorEndDate').html("End Date is not allowed lower than Start Date");
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
			          data	  : 'task=<%=Constants.Task.DOVALIDATEDAYOFF%>&employeeBean.startDate=' + $('#datepicker_startdate').val() + '&employeeBean.endDate=' + $('#datepicker_enddate').val() + '&employeeBean.employeeId='+$('#employeeId').val(),
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
							        	 /*  menuLoadHandler(tmpForm.action, "task=t10&message=Insert Day Off Successful"); */
										menuLoadHandler('<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>', 'task=<%=Constants.Task.GOTOVIEW%>&message=Insert Day Off Successful&tmpId='+$('#tmpId').val());  
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
		
		function checkDays(){
		 	$('#totalDay').html("<i class=\"fa fa-refresh fa-spin\"></i> Checking ");
		  	$('#totalDay').show();
			$.ajax({ 
		          type	  : "POST",
		          url	  : '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>',  
		          data	  : 'task=<%=Constants.Task.DOCOUNTDAYOFF%>&employeeBean.employeeId='+$('#employeeId').val()+'&employeeBean.startDate='+ $('#datepicker_startdate').val()+'&employeeBean.endDate='+ $('#datepicker_enddate').val(),
		          success : function(msg){
	        		  $('#totalDay').html(msg);
		          },
		          
		          error: function(){
		        	  //TO DO :: Add Error Handling
		          }
		       });
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
				<div class="box-header"><h3 class="box-title">Data Manage Employee Day Off</h3></div>
				<div class="box-body">
                 	<html:form action="/EmployeeAdmin">
                 		<html:hidden name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DODAYOFF%>"/>
                 		<html:hidden name="EmployeeAdminForm" property="tmpId" styleId="tmpId"/>
                 		<html:hidden name="EmployeeAdminForm" property="employeeBean.employeeId"/>
                 		<table class="form-input" align="center" style="width: 500px;">
                 			<tr>
                 				<td>Employee Id</td>
                 				<td>:</td>
                 				<td>
                 				<html:text name="EmployeeAdminForm" property="employeeBean.employeeId" styleClass="form-control" disabled="true" styleId="employeeId"/>
							</td>
                 			</tr>
               				<tr>
                 				<td width="150px">Name</td>
                 				<td>:</td>
                 				<td><html:text name="EmployeeAdminForm" property="employeeBean.employeeName" styleClass="form-control" disabled="true"/></td>
                 			</tr>
                 			<tr>
                 				<td>Start Date</td>
                 				<td>:</td>
                 				<td>
                 					<div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                 				  		<html:text name="EmployeeAdminForm" property="employeeBean.startDate" styleClass="form-control pull-right" styleId="datepicker_startdate" onchange="checkDays()"/>
                 				  	</div>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>
                					<i><span id="validatorStartDate" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                 			<tr>
                 				<td>End Date</td>
                 				<td>:</td>
                 				<td>
                 					<div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                 				  		<html:text name="EmployeeAdminForm" property="employeeBean.endDate" styleClass="form-control pull-right" styleId="datepicker_enddate" onchange="checkDays()"/>
                 				  	</div>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td><span id="totalDay" style="color: blue;font-size: 8;font-style: normal;"></span></td>
                			</tr>
                			<tr>
                				<td></td>
                				<td></td>
                				<td>
                					<i><span id="validatorEndDate" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                 			<tr>
                 				<td>Description</td>
                 				<td>:</td>
                 				<td>
                 					<html:textarea name="EmployeeAdminForm" property="employeeBean.descriptionDayOff" styleClass="form-control" styleId="descDayOff"/>
								</td>
                 			</tr>
                 			<tr>
                				<td></td>
                				<td></td>
                				<td>
                					<i><span id="validatorDescDayOff" style="color: red;font-size: 8"></span></i>
                				</td>
                			</tr>
                			<tr>
                  				<td></td>
								<td></td>
                  				<td><div id="employee-validating"></div></td>
                  			</tr>
                 			<tr>
                 				<td colspan="3" align="center">
                 					<html:button property="" value="Save" styleClass="btn btn-default" onclick="validateForm()" styleId="btn-save"/>
                 					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('t10')" styleId="btn-cancel"/>
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