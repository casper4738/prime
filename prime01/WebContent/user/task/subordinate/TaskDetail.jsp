<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End of CSS -->
	
	<!-- JS -->
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false,
		    language  : { 
		    	"emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>" 
		    }
	    });
		
		function flyToTaskDetail(task, value) {
			var tmpForm = document.forms[0];
			tmpForm.task.value = task;
			tmpForm.taskId.value = value;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function flyToChangeStatusAct(task, activityId, activityChangeDate) {
			alert(activityId+" | "+activityChangeDate) ;
			var tmpForm = document.forms[0];
			tmpForm.task.value = task;
			tmpForm.activityId.value = activityId;
			tmpForm.activityChangeDate.value = activityChangeDate;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function flyToEditDeleteAct(task, activityId) {
			var tmpForm = document.forms[0];
			tmpForm.task.value = task;
			tmpForm.activityId.value = activityId;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function doTaskAct(taskId) {
			modalLoadHandler("task=taskNote&param2=" + taskId);
		}
	</script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Tasks</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>Tasks & Activities</li>
			<li>As Subordinate</li>
			<li class="active">Task Detail</li>
		</ol>
	</section>
	
	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Data Task</h3></div>
			<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
			<tr><td>Task Name : <bean:write name="TaskSubordinateUserForm" property="taskBean.taskName"/> </td>
				<td>Task Assigner : <bean:write name="TaskSubordinateUserForm" property="taskBean.taskAssignerName" /> </td>
			</tr>
			<tr><td>Start Date : <bean:write name="TaskSubordinateUserForm" property="taskBean.taskStartDate" format="dd MMMM yyyy"/> </td>
				<td>Task Receiver : <bean:write name="TaskSubordinateUserForm" property="taskBean.taskReceiverName"/> </td>
			</tr><tr><td>Estimated Date : <bean:write name="TaskSubordinateUserForm" property="taskBean.taskEstimateDate" format="dd MMMM yyyy" />
				</td><td>Status : 
						<jsp:include page="/content/Status.jsp">
		  	    			<jsp:param name="status" value="${TaskSubordinateUserForm.taskBean.taskLastStatus}" />
		  	    		</jsp:include>
				</td>
			</tr>
			<tr><td>Actual Start Date: <bean:write name="TaskSubordinateUserForm" property="taskBean.actualStart" format="dd MMMM yyyy" /></td>
				<td>Actual Start End : <bean:write name="TaskSubordinateUserForm" property="taskBean.actualEnd" format="dd MMMM yyyy"/></td>
			</tr>
			<tr><td>Main Days : <bean:write name="TaskSubordinateUserForm" property="taskBean.mainDays" /></td>
				<td>Progress Percentage : <bean:write name="TaskSubordinateUserForm" property="taskBean.percentage"/></td>
			</tr>
			<tr><td colspan="2">Description : <bean:write name="TaskSubordinateUserForm" property="taskBean.taskDescription" /> </td></tr>
			</table>
			
			
			<p><span class="message"><bean:write name="TaskSubordinateUserForm" property="message" /></span></p>
			<jsp:include page="/content/ButtonTaskStatus.jsp">
				<jsp:param name="taskId" value="${TaskSubordinateUserForm.taskId}" />
    			<jsp:param name="taskAssigner" value="${TaskSubordinateUserForm.taskBean.taskAssigner}" />
    			<jsp:param name="taskReceiver" value="${TaskSubordinateUserForm.taskBean.taskReceiver}" />
    		</jsp:include>
			
			<div class="show-in-page">
				Show per page
				<html:select name="TaskSubordinateUserForm" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listShowEntries" label="value" value="key"/>
				</html:select>
			</div>
			
			<div class="search-table">
				<html:form action="/TaskSubordinateUser" >
					<html:hidden name="TaskSubordinateUserForm" property="task"/>
					<html:hidden name="TaskSubordinateUserForm" property="taskBean.taskId"/>
					<html:hidden name="TaskSubordinateUserForm" property="taskId"/>
					<html:hidden name="TaskSubordinateUserForm" property="activityId"/>
					<html:hidden name="TaskSubordinateUserForm" property="activityChangeDate"/>
					<html:hidden name="TaskSubordinateUserForm" property="goToPage"/>
					<html:hidden name="TaskSubordinateUserForm" property="showInPage"/>
					<html:hidden name="TaskSubordinateUserForm" property="isShowAll"/>
					<html:hidden name="TaskSubordinateUserForm" property="taskBean.taskAssigner"/>
					<html:hidden name="TaskSubordinateUserForm" property="taskBean.taskReceiver"/>
					<html:select name="TaskSubordinateUserForm" property="columnSearch" styleClass="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="TaskSubordinateUserForm" property="search" styleClass="textSearch"/>
					<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="TaskSubordinateUserForm" property="task" />', 'false')" value='Search'/>
					<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="TaskSubordinateUserForm" property="task" />', 'true')" value='Show All'/>					
				</html:form>
			</div>
			<div class="box-body">
				<table id="table-1" class="table table-bordered table-striped table-hover">
				<thead><tr>
					<th>Activity Name</th>
					<th>Description</th>
					<th>Activity Change Date</th>
					<th>Status</th>
                    <th width="90px">Actions</th>
                </tr></thead>
                <tbody>
                <logic:notEmpty name="listActivity">
					<logic:iterate id="iter" name="listActivity">
	                	<tr>
	                		<td width="250px"><bean:write name="iter" property="activityName"/></td>
	                		<td><bean:write name="iter" property="activityDescription"/></td>
	                		<td align="center" width="150px"><bean:write name="iter" property="activityChangeDate" format="dd MMMM yyyy HH:mm:ss"/></td>
	                		<td align="center" width="80px">
		                		<jsp:include page="/content/Status.jsp">
                	    			<jsp:param name="status" value="${iter.activityLastStatus}" />
                	    		</jsp:include>
	                		</td>
	                		<td align="center">
		                		<logic:notEqual name="iter" property="activityLastStatus" value='<%=Constants.Status.FINISH+""%>'>
			                		<logic:notEqual name="iter" property="activityLastStatus" value='<%=Constants.Status.ABORT+""%>'>
			                        	<input type="submit" class="btn btn-info btn-xs" value='Edit' onclick="flyToEditDeleteAct('<%=Constants.Task.ACTIVITY.GOTOEDIT%>', '<bean:write name="iter" property="activityId"/>')" src="resources/image/edit.png" width="18px"/>
									</logic:notEqual>
								</logic:notEqual>
	                        	<input type="submit" class="btn btn-primary btn-xs" value='Details' onclick="flyToChangeStatusAct('<%=Constants.Task.ACTIVITY.GOTOCHANGESTATUS%>', 
		                        	'<bean:write name="iter" property="activityId"/>',
		                        	'<bean:write name="iter" property="activityChangeDate" format="yyyy-MM-dd HH:mm:ss"/>')" />
	                        </td>	
	                    </tr> 
                    </logic:iterate>
					</logic:notEmpty>
                  </tbody>
            </table></div>
			
			<!-- Paging -->
            <jsp:include page="/content/Pagination.jsp">
    			<jsp:param name="formName" value="TaskSubordinateUserForm" />
    		</jsp:include>
			<!-- End of Paging -->
        </div></div>
        
        </div>
	</section>
</body>
</html>