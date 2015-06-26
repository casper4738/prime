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
			alert(activityId+"|"+taskId);
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
			<li>As Subordinate</li>
		  	<li>Task Detail</li>
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
							<html:text name="TaskSubordinateUserForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
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