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
	
	function removeOption(){
		 var x = document.getElementById("mondayDate");
		//remove selected index
	    for(i=0;i<6;i++){
		   	x.remove(0)
	    }
	}
	function getMondays(pMonth) {
		removeOption();
	
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
	        //mondays.push(new Date(d.getTime()));
	        var date = new Date(d.getTime());
	        mondays.push(date.getDate() + '/' + (date.getMonth() + 1) + '/' +  date.getFullYear());
	        d.setDate(d.getDate() + 7);
	    }
		// To Return in Combobox
	    var str = mondays.toString();
	    var res = str.split(",");
		
	    document.getElementById('viewMondayDate').style.display="inline"
	    //
	    
	    //view combobox Monday Date
	    var x = document.getElementById("mondayDate");
	 
	   	//create element select option	
	   	for(i=0;i<res.length;i++){
	    	var option = document.createElement("option");
		    option.text = res[i]
		    option.value = res[i]
		    x.add(option);
	    } 
	}
	
	function doSetWeekEnd(){
		var tmpValidated 	= true;
		var monthYear = $('#monthYear').val();
		
		$('#validatorStartFrom').html("");

		if(monthYear == null || monthYear == "") {
			 $('#validatorStartFrom').html("Start Weekend must be select");
			 tmpValidated = false;
		}
		
		var weekEnds="";
  		for(var i=0; i < document.forms[0].weekEnd.length; i++)
  		{
  			if(document.forms[0].weekEnd[i].checked)
  			{
  				weekEnds+=document.forms[0].weekEnd[i].value+","
  			}
  		}
  		
  		weekEnds = weekEnds.substring(0, weekEnds.length - 1);
  		
  		if(weekEnds == null || weekEnds == ""){
  			 $('#validatorWeekend').html("Start Weekend must be select");
			 tmpValidated = false;
  		}else{
	  		document.forms[0].weekEnds.value=weekEnds;
	  		document.forms[0].listMondayDate.value=document.forms[0].mondayDate.value;
		}
	
		if(tmpValidated){
			  $('#employee-validating').html("<i class=\"fa fa-refresh fa-spin\"></i> Validating employee data");
			  $('#btn-save').hide();
			  $('#btn-cancel').hide();
			  $.ajax({ 
		          type	  : "POST",
		          url	  : '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>',  
		          data	  : 'task=<%=Constants.Task.DOVALIDATEWEEKEND%>&employeeBean.startMondayDate=' + $('#mondayDate').val() +'&employeeBean.employeeId='+$('#employeeId').val(),
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
						        	  	/* menuLoadHandler(tmpForm.action, serialize(tmpForm)); */
										menuLoadHandler('<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>', 'task=<%=Constants.Task.GOTOVIEW%>&message=Insert Weekend Successful&tmpId='+$('#tmpId').val());  
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
								value="<%=Constants.Task.DOWEEKEND%>" />
							<html:hidden name="EmployeeAdminForm"
								property="employeeBean.divisionId" />
							<html:hidden name="EmployeeAdminForm"
								property="employeeBean.managerId" />
							<html:hidden name="EmployeeAdminForm"
								property="weekEnds" />
							<html:hidden name="EmployeeAdminForm"
								property="listMondayDate" />
							<html:hidden name="EmployeeAdminForm" property="tmpId" styleId="tmpId"/>
							<html:hidden name="EmployeeAdminForm" property="employeeBean.employeeId"/>
							<table class="form-input" align="center" style="width: 500px;">
								<tr>
									<td>Employee ID</td>
									<td>:</td>
									<td><html:text name="EmployeeAdminForm"
											property="employeeBean.employeeId" styleClass="form-control"
											disabled="true" styleId="employeeId"/></td>
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
										<div id="viewMondayDate" style="display: none">
											<%-- <html:select name="EmployeeAdminForm"
											property="mondayDate" styleClass="form-control"
											styleId="mondayDate">
											</html:select> --%>
											<select name="mondayDate" id="mondayDate" class="form-control">
											</select>
										</div>
									</td>
								</tr>
								<tr>
	                				<td></td>
	                				<td></td>
	                				<td>
	                					<i><span id="validatorStartFrom" style="color: red;font-size: 8"></span></i>
	                				</td>
	                			</tr>
								<tr>
									<td>Set Weekend</td>
									<td>:</td>
									<td>
										<html:checkbox property="weekEnd" name="EmployeeAdminForm" value="Monday">Monday</html:checkbox> <br>
										<html:checkbox property="weekEnd" name="EmployeeAdminForm" value="Tuesday">Tuesday</html:checkbox> <br> 
										<html:checkbox property="weekEnd" name="EmployeeAdminForm" value="Wednesday">Wednesday</html:checkbox> <br>
										<html:checkbox property="weekEnd" name="EmployeeAdminForm" value="Thursday">Thursday</html:checkbox><br> 
										<html:checkbox property="weekEnd" name="EmployeeAdminForm" value="Friday">Friday</html:checkbox> <br>
										<html:checkbox property="weekEnd" name="EmployeeAdminForm" value="Saturday">Saturday</html:checkbox><br>
										<html:checkbox property="weekEnd" name="EmployeeAdminForm" value="Sunday">Sunday</html:checkbox>
									</td>
								</tr>
								<tr>
	                				<td></td>
	                				<td></td>
	                				<td>
	                					<i><span id="validatorWeekend" style="color: red;font-size: 8"></span></i>
	                				</td>
	                			</tr>
								<tr>
									<td>Description</td>
									<td>:</td>
									<td>
										<html:textarea name="EmployeeAdminForm" property="employeeBean.descriptionWeekEnd" styleClass="form-control"/>
									</td>
								</tr>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
								<tr>
	                  				<td></td>
									<td></td>
	                  				<td><div id="employee-validating"></div></td>
	                  			</tr>
								<tr>
                 				<td colspan="3" align="center">
                 					<html:button property="" value="Save" styleClass="btn btn-default" onclick="doSetWeekEnd()" styleId="btn-save"/>
                 					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('t10')" styleId="btn-cancel"/>
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