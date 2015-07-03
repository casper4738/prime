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
			<li>As Head</li>
			<li class="active">Task Detail</li>
		</ol>
	</section>
	
	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Data Task</h3></div>
			<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
			<tr><td>Task Name : <bean:write name="ProjectUserForm" property="taskBean.taskName"/></td>
				<td>Task Assigner : <bean:write name="ProjectUserForm" property="taskBean.taskAssignerName" /> </td>
			</tr>
			<tr><td>Start Date : <bean:write name="ProjectUserForm" property="taskBean.taskStartDate" format="dd MMMM yyyy"/> </td>
				<td>Task Receiver : <bean:write name="ProjectUserForm" property="taskBean.taskReceiverName"/> </td>
			</tr><tr><td>Estimated Date : <bean:write name="ProjectUserForm" property="taskBean.taskEstimateDate" format="dd MMMM yyyy" />
				</td><td>Status : </td>
			</tr>
			<tr><td colspan="2">Description : <bean:write name="ProjectUserForm" property="taskBean.taskDescription" /> </td></tr>
			</table>
			
			<div class="show-in-page">
				Show per page
				<html:select name="ProjectUserForm" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listShowEntries" label="value" value="key"/>
				</html:select>
			</div>
			
			<div class="search-table">
				<html:form action="/ProjectUser" >
					<html:hidden name="ProjectUserForm" property="task"/>
					<html:hidden name="ProjectUserForm" property="taskBean.taskId"/>
					<html:hidden name="ProjectUserForm" property="taskId"/>
					<html:hidden name="ProjectUserForm" property="goToPage"/>
					<html:hidden name="ProjectUserForm" property="showInPage"/>
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
					<th>Activity Name</th>
					<th>Description</th>
					<th>Activity Change Date</th>
					<th>Status</th>
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
        </div></div>
        
        </div>
	</section>
</body>
</html>