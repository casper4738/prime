<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>Prime</title>
	<!-- CSS -->
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/fullcalendar/fullcalendar.print.css" rel="stylesheet" type="text/css" media='print' />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/extensions/FixedColumns/css/dataTables.fixedColumns.min.css" rel="stylesheet" type="text/css" />
	<!-- End of CSS -->
	
	<!-- JS -->
    <script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src='resources/plugins/fastclick/fastclick.min.js'></script>
    <script src="resources/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/extensions/FixedColumns/js/dataTables.fixedColumns.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false,
		    language  : { 
		    	"emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>" 
		    }
	    });
		
		$(document).ready(function(){
            $('#projectChartStartDate').datepicker({
                format: "dd-mm-yyyy"
            });  
            $('#projectChartEndDate').datepicker({
                format: "dd-mm-yyyy"
            }); 
            
			
			$('#projectChartStartDate').datepicker('setDate', '<%=request.getAttribute("progressStartDate")%>');
			$('#projectChartEndDate').datepicker('setDate', '<%=request.getAttribute("progressEndDate")%>');
			
			loadProjectProgress();
		});
		
		//##.Project Progress
		function loadProjectProgress(){
			var tmpDate;
			tmpDate = $('#projectChartStartDate').datepicker('getDate');
			var tmpStartDate =  tmpDate.getDate() + "/" +
								(tmpDate.getMonth() + 1) + "/" + 
								tmpDate.getFullYear();
			
			
			
			tmpDate = $('#projectChartEndDate').datepicker('getDate');
			var tmpEndDate   = tmpDate.getDate() + "/" +
							   (tmpDate.getMonth() + 1) + "/" + 
							   tmpDate.getFullYear();
			
			
			
	  		//Do Login Data checking
	  		$('#table-wrapper').html(PAGE_LOADING);
	  		$('#table-wrapper').load("<%=Constants.PAGES_LIST[Constants.Page.USER_PROJECT]%>", 
	  								 "task=refreshProjectProgress&projectId=" + $('#projectId').val() + 
	  								 "&progressStartDate=" + tmpStartDate + 
	  								 "&progressEndDate=" + tmpEndDate, function( response, status, xhr ) {
								//---.Show Some Respect For Error Status
								if(status == "error"){
									$('#table-wrapper').html(PAGE_LOAD_ERROR);
								} else {
					  	    	    var table = $('#table-2').dataTable({
								 			ordering 		: false,
															 			paging    		: false,
															 			searching 		: false,
															 			info	  		: false,
															 			scrollY	  		: "250px",
															 		    scrollX	  		: "100%",
															 		    scrollCollapse	: true,
					  										 		 	columnDefs: [
							  										 		            { width: '1%' , targets: 0 },
							  										 		            { width: '8%' , targets: 1 },
							  										 		            { width: '20%', targets: 2 },
							  										 		            { width: '3%' , targets: 3 }
							  										 		        ],
					  													language  		: {"emptyTable":  "<center><%=Constants.Response.TABLE_HEAD_EMPTY %></center>"}
					  										 	    });
						  		    new $.fn.dataTable.FixedColumns(table, {leftColumns: 4});
								}
	  		});
		}
				
		
		function flyToTaskDetail(task, valueMember) {
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
			tmpForm.employeeId.value = valueMember;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		function flyToEdit(task, employeeId){
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
			tmpForm.employeeId.value = employeeId;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		
		function flyToSubmit(task) {
		//	alert(valueProjectId);
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
		//	tmpForm.projectId.value = valueProjectId;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		$(document).ready(function () {
            $('#start').datepicker({
                format: "yyyy-mm-dd"
            });  
            $('#until').datepicker({
                format: "yyyy-mm-dd"
            });  
            
            $('.columnSearch').on('change',function(){
            	onselect($(this).val());
            });
            
            onselect($('.columnSearch').val());
        });
		
		function onselect(value) {
			if(value == "STARTDATE" || value == "ESTIMATEDATE") {
            	$('#textSearch').css('display', 'none') ;
            	$('#date_start').css('display', 'block') ;
            	$('#date_line').css('display', 'block') ;
            	$('#date_until').css('display', 'block') ;
            } else {
            	$('#textSearch').css('display', 'block') ;
            	$('#date_start').css('display', 'none') ;
            	$('#date_line').css('display', 'none') ;
            	$('#date_until').css('display', 'none') ;
            }
		}
	
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Project User</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li><a href="javascript:flyToSubmit('success')" >Manage Project</a></li>
			<li class="active">Project Detail</li>
		</ol>
	</section>

	<section class="content">	
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Data Project Member</h3></div>
			<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
			<tr><td>Project Name : ${ProjectUserForm.projectBean.projectId} <bean:write name="ProjectUserForm" property="projectBean.projectName"/></td>
				<td>Project Assigner : <bean:write name="ProjectUserForm" property="projectBean.projectAssigner" /> - <bean:write name="ProjectUserForm" property="projectBean.projectAssignerName" /> </td>
			</tr>
			<tr><td>Start Date : <bean:write name="ProjectUserForm" property="projectBean.projectStartDate" format="dd MMMM yyyy"/> </td>
				<td>Project Receiver : <bean:write name="ProjectUserForm" property="projectBean.projectReceiver"/> - <bean:write name="ProjectUserForm" property="projectBean.projectReceiverName"/> </td>
			</tr><tr><td>Estimated Date : <bean:write name="ProjectUserForm" property="projectBean.projectEstimateDate" format="dd MMMM yyyy" />
				</td><td>Status :  
					<jsp:include page="/content/Status.jsp">
       	    			<jsp:param name="status" value="${ProjectUserForm.projectBean.projectLastStatus}" />
       	    		</jsp:include>
				</td>
			</tr>
			<tr><td>Actual Start Date: <bean:write name="ProjectUserForm" property="projectBean.actualStart" format="dd MMMM yyyy" /></td>
				<td>Actual Start End : <bean:write name="ProjectUserForm" property="projectBean.actualEnd" format="dd MMMM yyyy"/></td>
			</tr>
			<tr><td>Main Days : <bean:write name="ProjectUserForm" property="projectBean.mainDays" /></td>
				<td>Progress Percentage : <bean:write name="ProjectUserForm" property="projectBean.percentage"/></td>
			</tr>
			<tr><td colspan="2">Description : <bean:write name="ProjectUserForm" property="projectBean.projectDescription" /> </td>
			</tr></table>
			
			<p><span class="message"><bean:write name="ProjectUserForm" property="message" /></span></p>
                 
            <div class="form-action">
				<table align="center"><tr>
					<td style="padding:5px;">
						<logic:equal name="ProjectUserForm" property="projectBean.isPM" value="1">	
							<logic:notEqual name="ProjectUserForm" property="projectBean.projectLastStatus" value="5">
								<input type="button" value="Add New Project Member" class="btn btn-sm btn-primary" onclick="flyToPage('addmember')"/></td>
								<logic:equal name="ProjectUserForm" property="projectBean.percentStatus" value="100">
			               			<td><input type="button" value="Submit" class="btn btn-sm  btn-primary" onclick="flyToSubmit('<%=Constants.Task.TASK.GOTOSUBMIT%>', '<bean:write name="ProjectUserForm" property="projectId" />')"/></td>
			               		</logic:equal>
		               		</logic:notEqual>
	               		</logic:equal>
					
				</tr></table>
            </div>
			
			<div class="show-in-page">
				Show per page  <bean:write name="ProjectUserForm" property="projectBean.projectLastStatus"  />
				<html:select name="ProjectUserForm" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
				</html:select>
			</div>
			
			<div class="search-table">
				<html:form action="/ProjectUser" >
					<html:hidden name="ProjectUserForm" property="task"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectId"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectName"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectReceiver"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectAssigner"/>
					<html:hidden name="ProjectUserForm" property="projectId" styleId="projectId"/>
					<html:hidden name="ProjectUserForm" property="employeeId"/>
					<html:hidden name="ProjectUserForm" property="goToPage"/>
					<html:hidden name="ProjectUserForm" property="showInPage"/>
					<html:hidden name="ProjectUserForm" property="tempRoleId"/>
					<html:select name="ProjectUserForm" property="columnSearch" styleClass="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="ProjectUserForm" property="search" styleClass="textSearch"/>
					<input type="submit" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOEDIT%>')" class="buttonSearch myButton" value='Search'>
				</html:form>
			</div>
			<div class="box-body">
				<table id="table-1" class="table table-bordered table-striped table-hover">
				<thead><tr>
					<th>Employee Id</th>
					<th>Employee Name</th>
					<th>Role</th>
					<th>Division</th>
					<th>Email</th>
					<th>Phone Number</th>
					<logic:equal name="ProjectUserForm" property="projectBean.isPM" value="1">
						<th width="90px">Actions</th>
					</logic:equal>
                    
                </tr></thead>
                <tbody>
                <logic:notEmpty name="listProjectMember">
					<logic:iterate id="iter" name="listProjectMember">
	                	<tr>
	                		<td width="40px"><bean:write name="iter" property="employeeId"/></td>
	                		<td width="150px"><bean:write name="iter" property="employeeName"/></td>
	                		<td width="350px">
	                		
	                		<logic:notEqual name="iter" property="roleName" value="">
	                			<bean:write name="iter" property="roleName"/>
	                		</logic:notEqual>
	                		<logic:equal name="iter" property="roleName" value="">
	                			<center><span class="label label-danger">Not Active</span></center>
	                		</logic:equal>
	                		</td>
	                		<td align="center" width="50px"><bean:write name="iter" property="divisionName" /></td>
	                		<td><bean:write name="iter" property="email"/></td>
	                		<td><bean:write name="iter" property="contactNumber"/></td>
	                		<logic:equal name="ProjectUserForm" property="projectBean.isPM" value="1">
	                		<td align="center">
	                        	<input type="image" onclick="flyToEdit('<%=Constants.Task.PROJECT.GOTOEDITMEMBER%>', '<bean:write name="iter" property="employeeId"/>')" src="resources/image/edit.png" />
                     	        <logic:notEqual name="iter" property="roleName" value="">
                     	        <input type="image" value='Details' onclick="flyToTaskDetail(
                     	        				'<%=Constants.Task.PROJECT.GOTOTASKMEMBER%>', 
                     	        				'<bean:write name="iter" property="employeeId"/>')"
     	        								src="resources/image/viewmore.png"
                     	        				/>
                     	        </logic:notEqual>
	                        </td>
	                        </logic:equal>	
	                    </tr> 
                    </logic:iterate>
					</logic:notEmpty>
                  </tbody>
            </table></div>
            
            <!-- Paging -->
            <jsp:include page="/content/Pagination.jsp">
    			<jsp:param name="formName" value="ProjectUserForm" />
    		</jsp:include>
			<!-- End of Paging -->
			
        </div>
        </div></div>
        
       	 <!-- Project Progress -->
            <div class="box">
               <div class="box-header">
				<i class="ion ion-clipboard"></i>
                 	<h3 class="box-title">Project Progress</h3>
                 	<br><br>Search by Date : <br><br>
						<table>
							<tr>
								<td style="padding-left:5px">
									<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
										<input type="text" class="form-control pull-right" id="projectChartStartDate"/>
       				  				</div>
       				  			</td>
								<td style="padding-left:5px"> - </td>
								<td style="padding-left:5px">
									<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
       				  					<input type="text" class="form-control pull-right" id="projectChartEndDate"/>
       				  				</div>
       				  			</td>
								<td style="padding-left:5px">
									<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="loadProjectProgress()" value='Search'/>
								</td>
							</tr>
						</table>
				<div class="box-body no-padding">
                 	  <center><h3 id="date_activitydate"></h3></center>
                  	<div id="table-wrapper">
                  	</div>
                </div><!-- /.box-body -->
            </div>
           </div>
        <!-- End of Project Progress -->      
        
	</section>
	<!-- /.content-wrapper -->
	
</body>
</html>
