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
		
		function dosubmit(value) {
			document.forms[0].activityStatus.value = value;
			menuLoadHandler(document.forms[0].action, serialize(document.forms[0]));
		}
		
		function doSubmitX(activityId, taskId) {
			//document.forms[0].activityStatus.value = value;
			//menuLoadHandler(document.forms[0].action, serialize(document.forms[0]));
			modalLoadHandler("task=simpleNote&param2=" + activityId + "&param3=" + taskId);
		}
	</script>
</head> 
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Tasks</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li>Task & Activities</li>
			<li>As Head</li>
		  	<li>Task Detail</li>
		  	<li class="active">Activity Status</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Activity Status</h3></div>
				<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
				<tr><td>Task Name : <bean:write name="TaskHeadUserForm" property="activityBean.taskName"/> </td>
					<td>Activity Name : <bean:write name="TaskHeadUserForm" property="activityBean.activityName" /> </td>
				</tr>
				<tr><td>Last Status : 
					<logic:equal name="TaskHeadUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.CREATE+""%>'>
	            		<span class="label label-warning">Receive</span>
	          		</logic:equal>
	          		<logic:equal name="TaskHeadUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.SUBMIT+""%>'>
	          			<span class="label label-primary">Submit</span>
	          		</logic:equal>
	          		<logic:equal name="TaskHeadUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.PAUSE+""%>'>
	          			<span class="label label-warning">Pause</span>
	          		</logic:equal>
	          		<logic:equal name="TaskHeadUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.FINISH+""%>'>
	          			<span class="label label-primary">Finish</span>
	          		</logic:equal>
	          		<logic:equal name="TaskHeadUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.ABORT+""%>'>
	          			<span class="label label-danger">Abort</span>
	          		</logic:equal>
	          		<logic:equal name="TaskHeadUserForm" property="activityBean.activityLastStatus" value='<%=Constants.Status.PROGRESS+""%>'>
	          			<span class="label label-success">Progress</span>
	          		</logic:equal>
				</td>
					<td>Last Change Date : <bean:write name="TaskHeadUserForm" property="activityBean.activityChangeDate"  format="dd MMMM yyyy hh:mm:ss"/> </td>
				</tr>
				<tr><td colspan="2">Description : <bean:write name="TaskHeadUserForm" property="activityBean.activityDescription" /> </td></tr>
				</table>
				
				<p><span class="message"><bean:write name="TaskHeadUserForm" property="message" /></span></p>
				<jsp:include page="../ButtonActivityStatus.jsp">
  	    			<jsp:param name="status" value="${TaskHeadUserForm.activityBean.activityLastStatus}" />
  	    		</jsp:include>
				<br/>
			
				<div class="box-body">
	               	<html:form action="/TaskHeadUser">
	               		<html:hidden name="TaskHeadUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOCHANGESTATUS%>"/>
	               		<html:hidden name="TaskHeadUserForm" property="activityBean.activityId" />
	               		<html:hidden name="TaskHeadUserForm" property="activityStatus" />
	               		<html:hidden name="TaskHeadUserForm" property="activityBean.activityChangeNote" />
	               		<html:hidden name="TaskHeadUserForm" property="taskId" />
	               	</html:form>
                	
                	
				<div class="search-table">
					<html:form action="/TaskHeadUser" >
						<html:hidden name="TaskHeadUserForm" property="task"/>
						<html:hidden name="TaskHeadUserForm" property="taskBean.taskId"/>
						<html:hidden name="TaskHeadUserForm" property="taskId"/>
						<html:hidden name="TaskHeadUserForm" property="activityId"/>
						<html:hidden name="TaskHeadUserForm" property="activityChangeDate"/>
						<html:hidden name="TaskHeadUserForm" property="goToPage"/>
						<html:hidden name="TaskHeadUserForm" property="showInPage"/>
					</html:form>
				</div>
					<table id="table-1" class="table table-bordered table-striped table-hover">
					<thead><tr>
						<th width="150px">Change Date</th>
						<th width="100px">Status</th>
						<th>Note</th>
	                </tr></thead>
	                <tbody>
	                <logic:notEmpty name="listActivity">
						<logic:iterate id="iter" name="listActivity">
		                	<tr>
		                		<td align="center"><bean:write name="iter" property="activityChangeDate" format="dd MMMM yyyy HH:mm:ss"/></td>
		                		<td align="center">
			                		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.CREATE+""%>'>
					            		<span class="label label-warning">Receive</span>
					          		</logic:equal>
					          		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.SUBMIT+""%>'>
					          			<span class="label label-primary">Submit</span>
					          		</logic:equal>
					          		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.PAUSE+""%>'>
					          			<span class="label label-warning">Pause</span>
					          		</logic:equal>
					          		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.FINISH+""%>'>
					          			<span class="label label-primary">Finish</span>
					          		</logic:equal>
					          		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.ABORT+""%>'>
					          			<span class="label label-danger">Abort</span>
					          		</logic:equal>
					          		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.PROGRESS+""%>'>
					          			<span class="label label-success">Progress</span>
					          		</logic:equal>
		                		</td>
		                		<td><bean:write name="iter" property="activityChangeNote"/></td>
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