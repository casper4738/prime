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
			alert("1."+value);
			document.forms[0].activityStatus.value = value;
			alert("2."+value);
			menuLoadHandler(document.forms[0].action, serialize(document.forms[0]));
		}
		
		function doSubmitX(activityId, taskId) {
			modalLoadHandler("task=activityNote&param2=" + activityId + "&param3=" + taskId);
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
					<jsp:include page="/content/Status.jsp">
       	    			<jsp:param name="status" value="${TaskHeadUserForm.activityBean.activityLastStatus}" />
       	    		</jsp:include>
				</td>
					<td>Last Change Date : <bean:write name="TaskHeadUserForm" property="activityBean.activityChangeDate"  format="dd MMMM yyyy HH:mm:ss"/> </td>
				</tr>
				<tr><td colspan="2">Description : <bean:write name="TaskHeadUserForm" property="activityBean.activityDescription" /> </td></tr>
				</table>
				
				<p><span class="message"><bean:write name="TaskHeadUserForm" property="message" /></span></p>
				<jsp:include page="/content/ButtonActivityStatus.jsp">
  	    			<jsp:param name="taskId" value="${TaskHeadUserForm.taskId}" />
  	    			<jsp:param name="activityId" value="${TaskHeadUserForm.activityBean.activityId}" />
  	    			<jsp:param name="status" value="${TaskHeadUserForm.activityBean.activityLastStatus}" />
  	    			<jsp:param name="taskAssigner" value="${TaskHeadUserForm.taskBean.taskAssigner}" />
    				<jsp:param name="taskReceiver" value="${TaskHeadUserForm.taskBean.taskReceiver}" />
  	    		</jsp:include>
				
				<div class="search-table">
					<html:form action="/TaskHeadUser" >
						<html:hidden name="TaskHeadUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOCHANGESTATUS%>"/>
						<html:hidden name="TaskHeadUserForm" property="taskBean.taskId"/>
						<html:hidden name="TaskHeadUserForm" property="taskId"/>
						<html:hidden name="TaskHeadUserForm" property="activityId"/>
						<html:hidden name="TaskHeadUserForm" property="activityChangeDate"/>
	               		<html:hidden name="TaskHeadUserForm" property="activityBean.activityId" />
	               		<html:hidden name="TaskHeadUserForm" property="activityStatus" />
	               		<html:hidden name="TaskHeadUserForm" property="activityBean.activityChangeNote" />
						<html:hidden name="TaskHeadUserForm" property="goToPage"/>
						<html:hidden name="TaskHeadUserForm" property="showInPage"/>
						<html:hidden name="TaskHeadUserForm" property="isShowAll"/>
					</html:form>
				</div>
				<div class="box-body">
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
			                		<jsp:include page="/content/Status.jsp">
				       	    			<jsp:param name="status" value="${iter.activityStatus}" />
				       	    		</jsp:include>
		                		</td>
		                		<td><bean:write name="iter" property="activityChangeNote"/></td>
		                    </tr> 
	                    </logic:iterate>
						</logic:notEmpty>
	                </tbody>
	            	</table></div>
					<!-- Paging -->
		            <jsp:include page="/content/Pagination.jsp">
		    			<jsp:param name="formName" value="TaskHeadUserForm" />
		    		</jsp:include>
					<!-- End of Paging -->
        	</div></div>
        </div>
	</section>
	
</body>
</html>