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
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script src="resources/prime.js" type="text/javascript"></script>
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
			loadProjectProgress();
		});
		
		//##.Activity Progress
		function loadProjectProgress(){
	  		//Do Login Data checking
	  		$('#table-wrapper').html(PAGE_LOADING);
	  		$('#table-wrapper').load("<%=Constants.PAGES_LIST[Constants.Page.USER_PROJECT_HEAD]%>", "task=refreshProjectProgress", function( response, status, xhr ) {
								//---.Show Some Respect For Error Status
								if(status == "error"){
									$('#table-wrapper').html(PAGE_LOAD_ERROR);
								} else {
					  	    	    var table = $('#table-1').dataTable({
					  										 			ordering 		: false,
					  										 			paging    		: false,
					  										 			searching 		: false,
					  										 			info	  		: false,
					  										 			scrollY	  		: "250px",
					  										 		    scrollX	  		: "100%",
					  										 		    scrollCollapse	: true,
					  										 		 	columnDefs: [
							  										 		            { width: '1%' , targets: 0 },
							  										 		            { width: '3%' , targets: 1 },
							  										 		            { width: '15%', targets: 2 },
							  										 		            { width: '3%' , targets: 3 }
							  										 		        ],
					  													language  		: {"emptyTable":  "<center><%=Constants.Response.TABLE_HEAD_EMPTY %></center>"}
					  										 	    });
						  		  	$('#table-wrapper').css('min-height','200');
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
			<tr><td>Project Name : ${ProjectUserFormAsHead.projectBean.projectId} <bean:write name="ProjectUserFormAsHead" property="projectBean.projectName"/></td>
				<td>Project Assigner : <bean:write name="ProjectUserFormAsHead" property="projectBean.projectAssigner" /> - <bean:write name="ProjectUserFormAsHead" property="projectBean.projectAssignerName" /> </td>
			</tr>
			<tr><td>Start Date : <bean:write name="ProjectUserFormAsHead" property="projectBean.projectStartDate" format="dd MMMM yyyy"/> </td>
				<td>Project Receiver : <bean:write name="ProjectUserFormAsHead" property="projectBean.projectReceiver"/> - <bean:write name="ProjectUserFormAsHead" property="projectBean.projectReceiverName"/> </td>
			</tr><tr><td>Estimated Date : <bean:write name="ProjectUserFormAsHead" property="projectBean.projectEstimateDate" format="dd MMMM yyyy" />
				</td><td>Status :  
					<jsp:include page="/content/Status.jsp">
       	    			<jsp:param name="status" value="${ProjectUserFormAsHead.projectBean.projectLastStatus}" />
       	    		</jsp:include>
				</td>
			</tr>
			<tr><td>Actual Start Date: <bean:write name="ProjectUserFormAsHead" property="projectBean.actualStart" format="dd MMMM yyyy" /></td>
				<td>Actual Start End : <bean:write name="ProjectUserFormAsHead" property="projectBean.actualEnd" format="dd MMMM yyyy"/></td>
			</tr>
			<tr><td>Main Days : <bean:write name="ProjectUserFormAsHead" property="projectBean.mainDays" /></td>
				<td>Progress Percentage : <bean:write name="ProjectUserFormAsHead" property="projectBean.percentage"/></td>
			</tr>
			<tr><td colspan="2">Description : <bean:write name="ProjectUserFormAsHead" property="projectBean.projectDescription" /> </td>
			</tr></table>
			
			<p><span class="message"><bean:write name="ProjectUserFormAsHead" property="message" /></span></p>
                 
            <div class="form-action">
				<table align="center"><tr>
				<logic:equal name="ProjectUserFormAsHead" property="projectBean.projectLastStatus" value="3">
					<td style="padding:5px;"><input type="button" value="Approve"	class="btn btn-sm btn-primary" onclick="flyToPage('approve')"/></td>
					<td style="padding:5px;"><input type="button" value="Reject" 	class="btn btn-sm  btn-primary" onclick="flyToPage('reject', '<bean:write name="ProjectUserFormAsHead" property="projectId" />')"/></td>
				</logic:equal>	
				<logic:notEqual name="ProjectUserFormAsHead" property="projectBean.projectLastStatus" value="5">
					<td style="padding:5px;"><input type="button" value="Abort" 	class="btn btn-sm  btn-primary" onclick="flyToPage('abort', '<bean:write name="ProjectUserFormAsHead" property="projectId" />')"/></td>
				</logic:notEqual>
					<td style="padding:5px;"><input type="button" value="Change PM" class="btn btn-sm  btn-primary" onclick="flyToPage('changePM', '<bean:write name="ProjectUserFormAsHead" property="projectId" />')"/></td>
				</tr></table>
            </div>
			
			<div class="show-in-page">
				Show per page
				<html:select name="ProjectUserFormAsHead" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
				</html:select>
			</div>
			
			<div class="search-table">
				<html:form action="/ProjectUserAsHead" >
					<html:hidden name="ProjectUserFormAsHead" property="task"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectId"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectName"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectReceiverName"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectLastStatus"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectReceiver"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.projectAssigner"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectId"/>
					<html:hidden name="ProjectUserFormAsHead" property="employeeId"/>
					<html:hidden name="ProjectUserFormAsHead" property="goToPage"/>
					<html:hidden name="ProjectUserFormAsHead" property="showInPage"/>
					<html:hidden name="ProjectUserFormAsHead" property="tempRoleId"/>
					<html:hidden name="ProjectUserFormAsHead" property="projectBean.employeeIdReceiver"/>
					<html:select name="ProjectUserFormAsHead" property="columnSearch" styleClass="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="ProjectUserFormAsHead" property="search" styleClass="textSearch"/>
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
                    <th width="90px">Actions</th>
                </tr></thead>
                <tbody>
                <logic:notEmpty name="listProjectMember">
					<logic:iterate id="iter" name="listProjectMember">
	                	<tr>
	                		<td width="30px"><bean:write name="iter" property="employeeId"/></td>
	                		<td width="250px"><bean:write name="iter" property="employeeName"/></td>
	                		<td>
	                		
	                		<logic:notEqual name="iter" property="roleName" value="">
	                			<bean:write name="iter" property="roleName"/>
	                		</logic:notEqual>
	                		<logic:equal name="iter" property="roleName" value="">
	                			<center><span class="label label-danger">Not Active</span></center>
	                		</logic:equal>
	                		</td>
	                		<td align="center" width="150px"><bean:write name="iter" property="divisionName" /></td>
	                		<td><bean:write name="iter" property="email"/></td>
	                		<td><bean:write name="iter" property="contactNumber"/></td>
	                		<td align="center">
	                        	<logic:notEqual name="iter" property="roleName" value="">
                     	        <input type="image" value='Details' onclick="flyToTaskDetail(
                     	        				'detailMemberAsHead', 
                     	        				'<bean:write name="iter" property="employeeId"/>')"
     	        								src="resources/image/viewmore.png"
                     	       			/>
                     	       	 </logic:notEqual>	
	                        </td>	
	                    </tr> 
                    </logic:iterate>
					</logic:notEmpty>
                  </tbody>
            </table></div>
            
            <!-- Paging -->
            <jsp:include page="/content/Pagination.jsp">
    			<jsp:param name="formName" value="ProjectUserFormAsHead" />
    		</jsp:include>
			<!-- End of Paging -->
			
        </div>
        </div></div>
        
        
<!--        	 Activity Progress -->
<!--             <div class="box"> -->
<!--                <div class="box-header"> -->
<!-- 				<i class="ion ion-clipboard"></i> -->
<!--                  	<h3 class="box-title">Project Progress</h3> -->
<!--                  	<br><br>Search by Date : <br><br> -->
<!--                  	<table width="370px"> -->
<!--                  		<tr> -->
<!--                  			<td> -->
<!--                   			<div class="input-group" style="width:220px; height:20px; background-color:yellow;"> -->
<!-- 		                 		<div class="input-group-addon"> -->
<!-- 			           				<i class="fa fa-calendar"></i> -->
<!-- 			           			</div> -->
<!-- 							</div> -->
<!--                  			</td> -->
<!--                  			<td> -->
<!--                  				<input type="button" class="btn bg-olive" style="height:32px" onclick="loadProjectProgress()" value='Search'/> -->
<!-- 							<input type="button" class="btn bg-olive" style="height:32px" onclick="loadProjectProgress()" value='Today'/> -->
<!--                  			</td>			 -->
<!--                  		</tr> -->
<!--                  	</table> -->
<!-- 				<div class="box-body no-padding"> -->
<!--                  	  <center><h3 id="date_activitydate"></h3></center> -->
<!--                   	<div id="table-wrapper"> -->
<!--                   	</div> -->
<!--                 </div>/.box-body -->
<!--             </div> -->
<!--            </div> -->
<!--         End of Activity Progress -->
	</section>
	<!-- /.content-wrapper -->
	
</body>
</html>