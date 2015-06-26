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
		
		function doTaskAct(taskId, task) {
			alert("cek dulu "+taskId+"|"+task);
			modalLoadHandler("task=taskNote&param2=" + taskId+"&param3="+task);
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
			<tr><td>Task Name : <bean:write name="TaskHeadUserForm" property="taskBean.taskName"/></td>
				<td>Task Assigner : <bean:write name="TaskHeadUserForm" property="taskBean.taskAssignerName" /> </td>
			</tr>
			<tr><td>Start Date : <bean:write name="TaskHeadUserForm" property="taskBean.taskStartDate" format="dd MMMM yyyy"/> </td>
				<td>Task Receiver : <bean:write name="TaskHeadUserForm" property="taskBean.taskReceiverName"/> </td>
			</tr><tr><td>Estimated Date : <bean:write name="TaskHeadUserForm" property="taskBean.taskEstimateDate" format="dd MMMM yyyy" />
				</td><td>Status : 
					<jsp:include page="/content/Status.jsp">
	  	    			<jsp:param name="status" value="${TaskHeadUserForm.taskBean.taskLastStatus}" />
	  	    		</jsp:include>
				</td>
			</tr>
			<tr><td colspan="2">Description : <bean:write name="TaskHeadUserForm" property="taskBean.taskDescription" /> </td></tr>
			</table>
			
			
			<p><span class="message"><bean:write name="TaskHeadUserForm" property="message" /></span></p>
			<jsp:include page="/content/ButtonTaskStatus.jsp">
    			<jsp:param name="taskId" value="${TaskHeadUserForm.taskId}" />
    			<jsp:param name="taskAssigner" value="${TaskHeadUserForm.taskBean.taskAssigner}" />
    			<jsp:param name="taskReceiver" value="${TaskHeadUserForm.taskBean.taskReceiver}" />
    		</jsp:include>
			
			<div class="show-in-page">
				Show per page
				<html:select name="TaskHeadUserForm" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listShowEntries" label="value" value="key"/>
				</html:select>
			</div>
			
			<div class="search-table">
				<html:form action="/TaskHeadUser" >
					<html:hidden name="TaskHeadUserForm" property="task"/>
					<html:hidden name="TaskHeadUserForm" property="taskBean.taskId"/>
					<html:hidden name="TaskHeadUserForm" property="taskId"/>
					<html:hidden name="TaskHeadUserForm" property="activityId"/>
					<html:hidden name="TaskHeadUserForm" property="activityChangeDate"/>
					<html:hidden name="TaskHeadUserForm" property="goToPage"/>
					<html:hidden name="TaskHeadUserForm" property="showInPage"/>
					<html:select name="TaskHeadUserForm" property="columnSearch" styleClass="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="TaskHeadUserForm" property="search" styleClass="textSearch"/>
					<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="flyToPage('<bean:write name="TaskHeadUserForm" property="task" />')" value='Search'/>
					<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchAll('<bean:write name="TaskHeadUserForm" property="task" />')" value='Show All'/>
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
	                		<td width="250px">
	                		<bean:write name="iter" property="activityId"/> |
	                		<bean:write name="iter" property="activityName"/>
	                		
	                		</td>
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
					<html:text name="TaskHeadUserForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
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