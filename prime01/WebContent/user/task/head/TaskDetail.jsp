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
			<tr><td>Task Name : <bean:write name="TaskHeadUserForm" property="taskBean.taskName"/></td>
				<td>Task Assigner : <bean:write name="TaskHeadUserForm" property="taskBean.taskAssignerName" /> </td>
			</tr>
			<tr><td>Start Date : <bean:write name="TaskHeadUserForm" property="taskBean.taskStartDate" format="dd MMMM yyyy"/> </td>
				<td>Task Receiver : <bean:write name="TaskHeadUserForm" property="taskBean.taskReceiverName"/> </td>
			</tr><tr><td>Estimated Date : <bean:write name="TaskHeadUserForm" property="taskBean.taskEstimateDate" format="dd MMMM yyyy" />
				</td><td>Status : </td>
			</tr>
			<tr><td colspan="2">Description : <bean:write name="TaskHeadUserForm" property="taskBean.taskDescription" /> </td></tr>
			</table>
			
			
			<p><span class="message"><bean:write name="TaskHeadUserForm" property="message" /></span></p>
			<br/><br/>
			<div class="form-action"><table align="center">
               <tr>	<td style="padding:5px;">
	               		<logic:notEqual name="isAllFinished" value="true">
	               			<logic:equal name="TaskHeadUserForm" property="taskBean.taskAssigner" value="${TaskHeadUserForm.taskBean.taskReceiver}" >
		               			<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
	               			</logic:equal>
	               		</logic:notEqual>
               			<logic:equal name="isAllFinished" value="true">
	               			<logic:equal name="TaskHeadUserForm" property="taskBean.taskAssigner" value="${TaskHeadUserForm.taskBean.taskReceiver}">
		               			<input type="button" value="Submit" class="btn btn-sm  btn-primary" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/>
	               			</logic:equal>
	               		</logic:equal>
              			<logic:equal name="isAlreadySubmit" value="true">
	               			<logic:notEqual name="TaskHeadUserForm" property="taskBean.taskAssigner" value="${TaskHeadUserForm.taskBean.taskReceiver}">
		               			<input type="button" value="Approval" class="btn btn-sm  btn-success" onclick="flyToPage('<%=Constants.Task.TASK.DOAPPROVAL%>')"/>
		               			<input type="button" value="Reject" class="btn btn-sm  btn-primary" onclick="doTaskAct('<%=Constants.Task.TASK.DOREJECT%>')"/>
	               			</logic:notEqual>
	               		</logic:equal>
	               		<logic:equal name="isAlreadyReject" value="true">
	               			<logic:notEqual name="TaskHeadUserForm" property="taskBean.taskAssigner" value="${TaskHeadUserForm.taskBean.taskReceiver}">
		               			<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('<%=Constants.Task.TASK.DOABORT%>')"/>
	               			</logic:notEqual>
	               		</logic:equal>
	               	</td>
               </tr>
            </table></div>
			
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
		                		<logic:equal name="iter" property="activityLastStatus" value='<%=Constants.Status.CREATE+""%>'>
		                			<span class="label label-warning">Receive</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="activityLastStatus" value='<%=Constants.Status.SUBMIT+""%>'>
		                			<span class="label label-primary">Submit</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="activityLastStatus" value='<%=Constants.Status.PAUSE+""%>'>
		                			<span class="label label-warning">Pause</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="activityLastStatus" value='<%=Constants.Status.FINISH+""%>'>
		                			<span class="label label-primary">Finish</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="activityLastStatus" value='<%=Constants.Status.ABORT+""%>'>
		                			<span class="label label-danger">Abort</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="activityLastStatus" value='<%=Constants.Status.PROGRESS+""%>'>
		                			<span class="label label-success">Progress</span>
		                		</logic:equal>
	                		</td>
	                		<td align="center">
	                        	<input type="submit" class="btn btn-info btn-xs" value='Edit' onclick="flyToEditDeleteAct('<%=Constants.Task.ACTIVITY.GOTOEDIT%>', '<bean:write name="iter" property="activityId"/>')" src="resources/image/edit.png" width="18px"/>
	                        	<input type="submit" class="btn btn-primary btn-xs" value='Details' onclick="flyToChangeStatusAct('<%=Constants.Task.ACTIVITY.GOTOCHANGESTATUS%>', 
		                        	'<bean:write name="iter" property="activityId"/>',
		                        	'<bean:write name="iter" property="activityChangeDate" format="yyyy-MM-dd hh:mm:ss"/>')" />
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