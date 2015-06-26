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
	<script type="text/javascript">
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false,
			language  : { "emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>"  }
	    });
		
		function flyToTaskDetail(task, value) {
			var tmpForm = document.forms[0];
			tmpForm.task.value = task;
			tmpForm.taskId.value = value;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function flyToBack(task, value) {
			var tmpForm = document.forms[0]; 
			tmpForm.task.value = task;
			tmpForm.projectId.value = value;
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
			<li class="active">Project</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<input type="submit" class="btn btn-primary btn-xs" value='Back' onclick="flyToBack(
	                        		'<%=Constants.Task.PROJECT.GOTOPROJECTDETAIL %>', 
	                        		'<bean:write name="ProjectUserForm" property="projectId"/>')">
				<div class="box-header"><h3 class="box-title-center">Data Project Member</h3></div>
				<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
				<tr><td>Member Name : <bean:write name="ProjectUserForm" property="employeeBean.employeeName"/> </td>
					<td>Position : <bean:write name="ProjectUserForm" property="employeeBean.positionName" /> </td>
				</tr>
				<tr><td>Phone Number : <bean:write name="ProjectUserForm" property="employeeBean.contactNumber"/> </td>
					<td>Division : <bean:write name="ProjectUserForm" property="employeeBean.divisionName" /> </td>
				<tr><td>Email : <bean:write name="ProjectUserForm" property="employeeBean.email"/> </td>
				</tr>
				</table>
				
				<p><span class="message"><bean:write name="ProjectUserForm" property="message" /></span></p>
				<div class="form-action"><table align="center">
                  <tr><td style="padding:5px;">
                  		<input type="button" value="Add New Task" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.PROJECT.GOTOCREATETASK%>')"/>
               	  </td></tr>
				</table></div>
				
				<div class="show-in-page">
					Show per page
					<html:select name="ProjectUserForm" property="showInPage" onchange="change(this.value)" >
						<html:optionsCollection name="listShowEntries" label="value" value="key"/>
					</html:select>	
				</div>
				
				<div class="search-table">
					<html:form action="/ProjectUser" >
						<html:hidden name="ProjectUserForm" property="task"/>
						<html:hidden name="ProjectUserForm" property="taskId"/>
						<html:hidden name="ProjectUserForm" property="projectBean.projectId"/>
						<html:hidden name="ProjectUserForm" property="projectBean.employeeId"/>
						<html:hidden name="ProjectUserForm" property="projectBean.employeeName"/>
						<html:hidden name="ProjectUserForm" property="goToPage"/>
						<html:hidden name="ProjectUserForm" property="showInPage"/>
						<html:hidden name="ProjectUserForm" property="projectId"/>
						<html:select name="ProjectUserForm" property="columnSearch" styleClass="columnSearch">
							<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
						</html:select>
						<html:text name="ProjectUserForm" property="search" styleClass="textSearch"/>
						<input type="submit" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOEDIT%>')" class="buttonSearch myButton" value='Search'>
					</html:form>
				</div>
				<div class="box-body">
					<table class="table table-bordered table-striped table-hover">
					<thead><tr>
						<th>Task Name</th>
						<th>Role</th>
						<th>Task Assigner</th>
						<th>Start Date </th>
						<th>Estimate Date</th>
						<th>Status</th>
						<th>Progress</th>
	                    <th width="90px">Actions</th>
	                </tr></thead>
	                <tbody>
	                <logic:notEmpty name="listProjectMemberDetails">
						<logic:iterate id="iter" name="listProjectMemberDetails">
		                	<tr>
		                		<td width="250px"><bean:write name="iter" property="taskBean.taskName"/></td>
		                		<td align="center"><bean:write name="iter" property="roleBean.roleName"/></td>
		                		<td><bean:write name="iter" property="taskBean.taskAssignerName"/></td>
		                		<td align="center"><bean:write name="iter" property="taskBean.taskStartDate" format="dd MMMM yyyy"/></td>
		                		<td align="center"><bean:write name="iter" property="taskBean.taskEstimateDate" format="dd MMMM yyyy"/></td>
		                		<td align="center">
			                		<jsp:include page="/content/Status.jsp">
	                	    			<jsp:param name="status" value="${iter.taskBean.taskLastStatus}" />
	                	    		</jsp:include>
		                		</td>
		                		<td align="center">
			                		<logic:greaterThan name="iter" property="taskBean.percentage" value="50">
		                	    		<span class="badge bg-green">
			                	    		<jsp:include page="/content/Percentage.jsp">
			                	    			<jsp:param name="status" value="${iter.taskBean.taskLastStatus}" />
			                	    			<jsp:param name="percentage" value="${iter.taskBean.percentage}" />
			                	    		</jsp:include>
		                	    		</span>
			                		</logic:greaterThan>
			                		<logic:lessEqual name="iter" property="taskBean.percentage" value="50">
		                	    		<span class="badge bg-red">
			                	    		<jsp:include page="/content/Percentage.jsp">
			                	    			<jsp:param name="status" value="${iter.taskBean.taskLastStatus}" />
			                	    			<jsp:param name="percentage" value="${iter.taskBean.percentage}" />
			                	    		</jsp:include>
		                	    		</span>
			                		</logic:lessEqual>
		                		</td>
		                		<td align="center">
		                        	<input type="submit" class="btn btn-primary btn-xs" value='Details' onclick="flyToTaskDetail('<%=Constants.Task.TASK.GOTODETAIL %>', '<bean:write name="iter" property="taskBean.taskId"/>')">
		                        </td>	
		                    </tr> 
	                    </logic:iterate>
						</logic:notEmpty>
	                  </tbody>
	            </table></div>
				<ul class="pagination">
					<li tabindex="0"><html:link styleClass="paging" href="#" onclick="page(${pageFirst})">First</html:link></li>
					<li tabindex="1"><html:link styleClass="paging" href="#" onclick="page(${pagePrev})"><<</html:link> </li>
					
					<logic:iterate id="p" name="listPage">
						<logic:equal name="p" value="${pageNow}">
							<li><html:link styleClass="active" href="#">${p}</html:link> </li>
						</logic:equal>
						<logic:notEqual name="p" value="${pageNow}">
							<li><html:link styleClass="paging" href="#" onclick="page(${p})">${p}</html:link> </li>
						</logic:notEqual>
					</logic:iterate>
					<li><html:link styleClass="paging" href="#" onclick="page(${pageNext})" >>></html:link> </li>
					<li><html:link styleClass="paging" href="#" onclick="page(${pageLast})" >Last</html:link></li>
					
					<div class="paginate-3">
						<html:text name="ProjectUserForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
						<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
					</div>
				</ul>
				
				<div class="paginate-2">
					Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
				</div>
	        </div>
		</div></div>
	</section>
	
		<!-- /.content-wrapper -->
</body>
</html>