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
			<li><a href="javascript:flyToPage()" >Manage Project</a></li>
			<li class="active">Project Detail</li>
		</ol>
	</section>

	<section class="content">	
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Data Project Member</h3></div>
			<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
			<tr><td>Project Name : ${ProjectUserForm.projectBean.projectId} <bean:write name="ProjectUserForm" property="projectBean.projectName"/></td>
				<td>Project Assigner : <bean:write name="ProjectUserForm" property="projectBean.projectAssignerName" /> </td>
			</tr>
			<tr><td>Start Date : <bean:write name="ProjectUserForm" property="projectBean.projectStartDate" format="dd MMMM yyyy"/> </td>
				<td>Project Receiver : <bean:write name="ProjectUserForm" property="projectBean.projectReceiverName"/> </td>
			</tr><tr><td>Estimated Date : <bean:write name="ProjectUserForm" property="projectBean.projectEstimateDate" format="dd MMMM yyyy" />
				</td><td>Status :  
					<jsp:include page="/content/Status.jsp">
       	    			<jsp:param name="status" value="${ProjectUserForm.projectBean.projectLastStatus}" />
       	    		</jsp:include>
				</td>
			</tr>
			<tr><td colspan="2">Description : <bean:write name="ProjectUserForm" property="projectBean.projectDescription" /> </td>
			</tr></table>
			
			<p><span class="message"><bean:write name="ProjectUserForm" property="message" /></span></p>
                 
            <div class="form-action">
				<table align="center"><tr>
				<logic:equal name="ProjectUserForm" property="projectBean.projectLastStatus" value="3">
					<td style="padding:5px;"><input type="button" value="Approve" class="btn btn-sm btn-primary" onclick="flyToPage('approve')"/></td>
					<td style="padding:5px;"><input type="button" value="Reject" class="btn btn-sm  btn-primary" onclick="flyToPage('reject', '<bean:write name="ProjectUserForm" property="projectId" />')"/></td>
				</logic:equal>	
					<td style="padding:5px;"><input type="button" value="Change PM" class="btn btn-sm  btn-primary" onclick="flyToPage('changePM', '<bean:write name="ProjectUserForm" property="projectId" />')"/></td>
				</tr></table>
            </div>
			
			<div class="show-in-page">
				Show per page
				<html:select name="ProjectUserForm" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
				</html:select>
			</div>
			
			<div class="search-table">
				<html:form action="/ProjectUser" >
					<html:hidden name="ProjectUserForm" property="task"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectId"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectName"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectReceiverName"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectLastStatus"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectReceiver"/>
					<html:hidden name="ProjectUserForm" property="projectBean.projectAssigner"/>
					<html:hidden name="ProjectUserForm" property="projectId"/>
					<html:hidden name="ProjectUserForm" property="employeeId"/>
					<html:hidden name="ProjectUserForm" property="goToPage"/>
					<html:hidden name="ProjectUserForm" property="showInPage"/>
					<html:hidden name="ProjectUserForm" property="tempRoleId"/>
					<html:hidden name="ProjectUserForm" property="employeeIdReceiver"/>
					<html:select name="ProjectUserForm" property="columnSearch" styleClass="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="ProjectUserForm" property="search" styleClass="textSearch"/>
					<input type="submit" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOEDIT%>')" class="buttonSearch myButton" value='Search'>
				</html:form>
				dfs<bean:write name="ProjectUserForm" property="employeeIdReceiver"/>
			</div>
			<div class="box-body">
				<table id="table-1" class="table table-bordered table-striped table-hover">
				<thead><tr>
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
	                        	
                     	        <input type="image" value='Details' onclick="flyToTaskDetail(
                     	        				'detailMemberAsHead', 
                     	        				'<bean:write name="iter" property="employeeId"/>')"
     	        								src="resources/image/viewmore.png"
                     	        				>
	                        </td>	
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
	</section>
	<!-- /.content-wrapper -->
	
</body>
</html>