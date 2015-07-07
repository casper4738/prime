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
		
		function page(page) {
			var tmpForm = document.forms[0];
			tmpForm.task.value = "<%=Constants.Task.ACTIVITY.GOTOCHANGESTATUS%>";
			if(page == -1) {
				tmpForm.goToPage.value = document.getElementById('page').value;
			} else {
				tmpForm.goToPage.value = page;			
			}
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}

		function dosubmit(value) {
			document.forms[0].activityStatus.value = value;
			menuLoadHandler(document.forms[0].action, serialize(document.forms[0]));
		}
		
		function doSubmitX(activityId, taskId) {
			alert(activityId+"|"+taskId);
			modalLoadHandler("task=activityNote&param2=" + activityId + "&param3=" + taskId);
		}
	</script>
</head> 
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Tasks<small> As Head</small></h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#" onclick="flyToBack('home')">Tasks & Activities</a></li>
		  	<li><a href="#" onclick="flyToBack('<%=Constants.Task.GOTOVIEW%>')">Tasks Detail</a></li>
		  	<li class="active">Activity Status</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Activity Status</h3></div>
				<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
				<tr><td>Task Name : <bean:write name="TaskSubordinateUserForm" property="activityBean.taskName"/> </td>
					<td>Activity Name : <bean:write name="TaskSubordinateUserForm" property="activityBean.activityName" /> </td>
				</tr>
				<tr><td>Last Status :
					<jsp:include page="/content/Status.jsp">
       	    			<jsp:param name="status" value="${TaskSubordinateUserForm.activityBean.activityLastStatus}" />
       	    		</jsp:include>
				</td>
					<td>Last Change Date : <bean:write name="TaskSubordinateUserForm" property="activityBean.activityChangeDate"  format="dd MMMM yyyy hh:mm:ss"/> </td>
				</tr>
				<tr><td colspan="2">Description : <bean:write name="TaskSubordinateUserForm" property="activityBean.activityDescription" /> </td></tr>
				</table>
				
				<p><span class="message"><bean:write name="TaskSubordinateUserForm" property="message" /></span></p>
				<jsp:include page="/content/ButtonActivityStatus.jsp">
  	    			<jsp:param name="taskId" value="${TaskSubordinateUserForm.taskId}" />
  	    			<jsp:param name="activityId" value="${TaskSubordinateUserForm.activityBean.activityId}" />
  	    			<jsp:param name="status" value="${TaskSubordinateUserForm.activityBean.activityLastStatus}" />
  	    			<jsp:param name="taskAssigner" value="${TaskSubordinateUserForm.taskBean.taskAssigner}" />
    				<jsp:param name="taskReceiver" value="${TaskSubordinateUserForm.taskBean.taskReceiver}" />
  	    		</jsp:include>
				<br/>
			
				<div class="search-table">
					<html:form action="/TaskSubordinateUser" >
						<html:hidden name="TaskSubordinateUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOCHANGESTATUS%>"/>
						<html:hidden name="TaskSubordinateUserForm" property="taskBean.taskId"/>
						<html:hidden name="TaskSubordinateUserForm" property="taskId"/>
						<html:hidden name="TaskSubordinateUserForm" property="activityId"/>
						<html:hidden name="TaskSubordinateUserForm" property="activityChangeDate"/>
	               		<html:hidden name="TaskSubordinateUserForm" property="activityBean.activityId" />
	               		<html:hidden name="TaskSubordinateUserForm" property="activityBean.activityChangeNote"/>
	               		<html:hidden name="TaskSubordinateUserForm" property="activityStatus" />
						<html:hidden name="TaskSubordinateUserForm" property="goToPage"/>
						<html:hidden name="TaskSubordinateUserForm" property="showInPage"/>
						<html:hidden name="TaskSubordinateUserForm" property="isShowAll"/>
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
		    			<jsp:param name="formName" value="TaskSubordinateUserForm" />
		    		</jsp:include>
					<!-- End of Paging -->
        	</div></div>
        </div>
	</section>
	
</body>
</html>