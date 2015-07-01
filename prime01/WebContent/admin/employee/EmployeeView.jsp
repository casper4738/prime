<%@page import="java.sql.Date"%>
<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DateFormat" %>  
<%@ page import="prime.admin.employee.EmployeeBean" %>
<%@ page import="prime.admin.employee.EmployeeManagerImpl" %>
<%@ page import="prime.admin.employee.EmployeeManager" %>
<%@ page import="prime.admin.holiday.HolidayManagerImpl" %>
<%@ page import="prime.admin.holiday.HolidayManager" %>
<%@ page import="prime.admin.holiday.HolidayBean" %>
<%@ page import="prime.admin.employee.EmployeeAction" %>
<%@ page import="prime.utility.PrimeUtil" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>

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
            
            var tmpImage = '<%=((EmployeeBean)request.getAttribute("empBean")).getConvertedFilePic()%>';
      	  	if(tmpImage == "null"){
          		$("#profpic").attr("src","resources/image/user-photo.png");
	      	} else {
	         	$("#profpic").attr("src","data:image/;base64," + tmpImage);  
	      	} 
      	  
	      	$("#input-image").change(function (e) {
			    if(this.disabled) 
			    	return alert('File upload not supported!');
			    var F = this.files;
			    if(F && F[0]) {
			    	var pathFile = document.getElementById("input-image").value;
					var tmppath = URL.createObjectURL(event.target.files[0]);
			    	for(var i=0; i<F.length; i++){
			    		readImage( F[i] );
			    	}
			    }
			});
	    });
		
		function readImage(file) {
		    var reader = new FileReader();
		    var image  = new Image();
		    
		    reader.readAsDataURL(file);  
		    reader.onload = function(_file) {
		        image.src    = _file.target.result;              // url.createObjectURL(file);
		        image.onload = function() {
		            var w = this.width;
		            var h = this.height;
		            var t = file.type;                           // ext only: // file.type.split('/')[1],
		            var n = file.name;
		            var s = file.size/1024;
		            	
	            	if(s <= <%=Constants.MAX_IMAGE_FILESIZE%>){
		            	$('#upload-preview').html('<img src="'+ this.src +'" style="width:64px;height:64px"> <br/><b>' + w +'x' +h+ ' <br/>'+s +'KB <br/>'+t+' <br>'+n+'<br/></b>');
	            	} else {
			            alert("File size too big !!");
			            
			            //Reset and Readd Event [Will think for better solution than double hardcode]
	            		$("#input-image").replaceWith($("#input-image").clone());
	            		$("#input-image").change(function (e) {
	            		    if(this.disabled) 
	            		    	return alert('File upload not supported!');
	            		    var F = this.files;
	            		    if(F && F[0]) {
	            		    	for(var i=0; i<F.length; i++){
	            		    		readImage( F[i] );
	            		    	}
	            		    }
	            		});
	            	}
		        };
		        image.onerror= function() {
            		$("#input-image").replaceWith($("#input-image").clone());
		            alert("Invalid file type ! Only input images files type");
		        };      
		    };
		    
		}
		function doGoToEdit() {
			var tmpForm = document.forms[0];
			tmpForm.task.value = "<%=Constants.Task.GOTOEDIT%>";
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function doGoToResign() {
			var tmpForm = document.forms[0];
			tmpForm.task.value = "<%=Constants.Task.GOTORESIGN%>";
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function flyToEditWeekend(task, valueId, valueString) {
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
			tmpForm.tmpId.value = valueId;
			tmpForm.tmpString.value = valueString;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function flyToDelete(task, valueId, valueString, confirmMessage) {
			var tmpForm = document.forms[0]; 
			if(confirmMessage != null){
				if(!confirm(confirmMessage))	
					return;
			}
			tmpForm.task.value = task;
			tmpForm.tmpId.value = valueId;
			tmpForm.tmpString.value = valueString;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function changePic(){
			$('#employee-validating').html("<i class=\"fa fa-refresh fa-spin\"></i> Upload Picture");
		 	$('#btn-save').hide();
		 	$('#btn-edit').hide();
		 	$('#btn-resign').hide();
		 	$('#btn-cancel').hide();
		 	$('#btn-setDayOff').hide();
		 	$('#btn-setWeekEnd').hide();
		 	$('#btn-delete-DayOff').hide();
		 	$('#btn-delete-WeekEnd').hide();

			var formData = new FormData(document.forms[0]);
			$.ajax({ 
	   	          type	  		: "POST",
	   	          url	  		: "<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>",  // Send the login info to this page
	   	          data	  		: formData,
	   	       	  contentType 	: false,
		          processData 	: false,
	   	          success : function(msg){
	   	        	 menuLoadHandler('<%=Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]%>', "task=&message=Change Picture Successful");
	   	          },
	   	          
	   	          error: function(){
					  //TO DO :: Do Some Error Handling at Here
	   	        	  alert("<%=Constants.Response.FAIL_DO%>");
	   	          }
	   	    });
		}
		
		function fShowBtn(){
			if(document.getElementById('input-image').value!=""){
				document.getElementById('changePic').style.display="inline"
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
		<div class="col-xs-12"><div class="box"><div class="box" align="center">
			<div class="box-header"><h1 class="box-title"><br/><br/><b>Data Manage Employee</b><br/><br/></h1></div>
			<div class="box-body">
               	<html:form action="/EmployeeAdmin" method="post" enctype="multipart/form-data" styleId="formViewEmp">
               		<html:hidden name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOCHANGEPIC%>"/>
               		<html:hidden name="EmployeeAdminForm" property="employeeBean.divisionId" />
               		<html:hidden name="EmployeeAdminForm" property="employeeBean.managerId" />
               		<html:hidden name="EmployeeAdminForm" property="employeeBean.employeeId" />
               		<html:hidden name="EmployeeAdminForm" property="tmpId" />
               		<html:hidden name="EmployeeAdminForm" property="tmpString" />
               		<table class="form-input" style="width: 500px;">
               			<tr>
              				<td>Employee ID</td>
              				<td>:</td>
              				<td>
               					<bean:write name="EmployeeAdminForm" property="employeeBean.employeeId"/>
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
               					<img class="photo" id="profpic" width="100px" height="100px"/>
							</td>
               			</tr>
               			<tr>
               				<td>Change Picture [Max. <%=Constants.MAX_IMAGE_FILESIZE %> KB]</td>
               				<td>:</td>
               				<td>
               				  <html:file name="EmployeeAdminForm" property="profpic" styleId="input-image"  onchange="fShowBtn()"/>
							</td>
               			</tr>
               			<tr>
               				<td></td>
               				<td></td>
               				<td>
							  <div id="upload-preview"></div>
               				</td>
               			</tr>
               			<tr>
                  			<td></td>
							<td></td>
                  			<td><div id="employee-validating"></div></td>
                  		</tr>
               			<tr>
               				<td colspan="3" align="center">
               					<div id="changePic" style="display:none">
               						<input type="button" value="Change Pic" class="btn btn-primary"  id="btn-save" onclick="changePic()"/> 				
               					</div>
               				</td>
               			</tr>
               			<tr>
               				<td colspan="3">
               					<span class="message"><bean:write name="EmployeeAdminForm" property="message" /></span>
               					<table class="form-input" align="center" style="width: 500px;">
			             			<tr>
			               				<td width="150px">
			               					<logic:equal name="EmployeeAdminForm" property="employeeBean.resignDate" value="">
				               					<input type="button" property="" value="Set DayOff" class="btn btn-primary" 
				               					onclick="flyToEditDelete('<%=Constants.Task.GOTODAYOFF%>', '<bean:write name="EmployeeAdminForm" property="employeeBean.employeeId"/>')" id="btn-setDayOff"/>
			               					</logic:equal>
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
											<th>Action</th>
						                </tr>
						            </thead>	
						            <tbody>
						            <logic:notEmpty name="listDayoffByEmployeeId">
									   <logic:iterate id="iter" name="listDayoffByEmployeeId">
						                	<tr>
						                		<td><bean:write name="iter" property="startDate"/> </td>
						                		<td><bean:write name="iter" property="endDate"/> </td>
						                		<bean:define id="dateStart" name="iter" property="startDate"  toScope="request"/>
						                		<bean:define id="dateEnd" name="iter" property="endDate"  toScope="request"/>
						                		<bean:define id="employeeId" name="EmployeeAdminForm" property="employeeBean.employeeId"  toScope="request"/>
						                		<%
						                			java.sql.Date endDate = (java.sql.Date) request.getAttribute("dateEnd");
						                			java.sql.Date startDate = (java.sql.Date) request.getAttribute("dateStart");
						                			
						                			EmployeeManager manager = new EmployeeManagerImpl();
						                			HolidayManager tmpHolidayManager  = new HolidayManagerImpl();
						                			EmployeeAction empAction = new EmployeeAction();
						                			Calendar cal = Calendar.getInstance();
						                			List<HolidayBean> listHoliday = tmpHolidayManager.getListByYear(cal.get(Calendar.YEAR));
						                			List<EmployeeBean> listWeekend = manager.getListWeekendByEmployeeId((Integer)request.getAttribute("employeeId"));
						                			Integer sumOFHoliday = empAction.getSumHoliday(listHoliday, startDate, endDate);
							            			Integer sumOFWeekend = empAction.getSumWeekEnd(listWeekend, startDate, endDate);
							            			Integer totalDayOff = PrimeUtil.getDayBetweenDate(startDate, endDate) - sumOFHoliday - sumOFWeekend;
						                		%>
						                		<td align="center"><%=totalDayOff%></td>
						                		<td><bean:write name="iter" property="descriptionDayOff"/> </td>
						                		<td>
						                			<% 
						                			
							                		try {
							                			//java.sql.Date startDate = (java.sql.Date) request.getAttribute("dateStart");
						                				java.sql.Date date = new java.sql.Date(new java.util.Date().getTime());
					                					if(date.compareTo(startDate) < 0) {
					                				%>
					                					<input type="button" value="Del" styleClass="btn btn-default" onclick="flyToDelete('<%=Constants.Task.DOEDITDAYOFF%>', <bean:write name="EmployeeAdminForm" property="employeeBean.employeeId"/>, '<bean:write name="iter" property="startDate"/>','<%=Constants.Confirmation.DELETE %>')" id="btn-delete-DayOff"/>
					                				<%
					                					} 
						                			} catch (Exception e) {
						                				out.print("CAST : "+e.getMessage());
						                			}
						                			%>
						                		</td>
						                	</tr>
							           	</logic:iterate>
									</logic:notEmpty>
									<logic:empty name="listDayoffByEmployeeId">
										<tr>
											<td align="center" colspan="11"><bean:message key="label.table.notfound" /></td>
										</tr>
									</logic:empty>
									</tbody>
			             		</table>
               				</td>
               			</tr>
               			<tr>
               				<td colspan="3">
               					<table class="form-input" align="center" style="width: 500px;">
			             			<tr>
			               				<td width="150px">
			               					<logic:equal name="EmployeeAdminForm" property="employeeBean.resignDate" value="">
			               						<input type="button"  value="Set WeekEnd" class="btn btn-primary" onclick="flyToEditDelete('<%=Constants.Task.GOTOWEEKEND%>', '<bean:write name="EmployeeAdminForm" property="employeeBean.employeeId"/>')" id="btn-setWeekEnd"/>
			               					</logic:equal>
			               				</td>
			               			</tr>
			               		</table>
			               		<table id="table-1" class="table table-bordered table-striped table-hover">
									<thead>
										<tr>
											<th>Start Weekend</th>
											<th>Set Weekend</th>
											<th>Action</th>
						                </tr>
						            </thead>	
						            <tbody>
						            <logic:notEmpty name="listWeekendByEmployeeId">
									   <logic:iterate id="iter" name="listWeekendByEmployeeId">
						                	<tr>
						                		<td><bean:write name="iter" property="startFrom"/> </td>
						                		<td><bean:write name="iter" property="weekEnd"/> </td>
						                		<td><bean:define id="datex" name="iter" property="startFrom"  toScope="request"/>
						                			<% 
							                			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
						                			
							                			try {
							                				java.sql.Date startForm = (java.sql.Date) request.getAttribute("datex");
							                				java.sql.Date date = new java.sql.Date(new java.util.Date().getTime());
					                					if(date.compareTo(startForm) < 0) {
					                				%>
					                					<%-- <input type="button" value="Edit" styleClass="btn btn-default" onclick="flyToEditWeekend('<%=Constants.Task.GOTOEDITWEEKEND%>', <bean:write name="EmployeeAdminForm" property="employeeBean.employeeId"/>, '<bean:write name="iter" property="startFrom"/>')"/> --%>
					                					<input type="button" value="Del" styleClass="btn btn-default" onclick="flyToDelete('<%=Constants.Task.DOEDITWEEKEND%>', <bean:write name="EmployeeAdminForm" property="employeeBean.employeeId"/>, '<bean:write name="iter" property="startFrom"/>','<%=Constants.Confirmation.DELETE %>')" id="btn-delete-WeekEnd"/>
					                				<%
					                					} 
						                			} catch (Exception e) {
						                				out.print("CAST : "+e.getMessage());
						                				
						                			}
						                			%>
						                		</td>
						                	</tr>
							           	</logic:iterate>
									</logic:notEmpty>
									<logic:empty name="listWeekendByEmployeeId">
										<tr>
											<td align="center" colspan="11"><bean:message key="label.table.notfound" /></td>
										</tr>
									</logic:empty>
									</tbody>
			             		</table>
							</td>
               			</tr>
               			<tr>
               				<td colspan="3" align="center">
               					<logic:equal name="EmployeeAdminForm" property="employeeBean.resignDate" value="">
               						<html:button property="" value="Edit" styleClass="btn btn-primary" onclick="doGoToEdit()" styleId="btn-edit"/>
               						<html:button property="" value="Resign" styleClass="btn btn-primary" onclick="doGoToResign()" styleId="btn-resign"/>
               					</logic:equal>
               					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')" styleId="btn-cancel"/>
               				</td>
               			</tr>
					</table>
                 </html:form>
              </div>
        	</div>
        	</div>
        </div>
        </div>
	</section>
</body>
</html>