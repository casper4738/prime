<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head>
	<link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	
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

	</script>
</head>
<body class="skin-blue sidebar-mini">
	<html:form action="/TaskHeadUser" >
		<html:hidden name="TaskHeadUserForm" property="task"/>
		<html:hidden name="TaskHeadUserForm" property="taskId"/>
		<html:hidden name="TaskHeadUserForm" property="goToPage"/>
		<html:hidden name="TaskHeadUserForm" property="showInPage"/>
	</html:form>
					
	<section class="content-header">
		<h1>Manage Tasks</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Task & Activities</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Data Manage Tasks</h3></div>
			
			<p><span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.TASK.GOTOTASKTYPE%>')">
                   <i class="fa fa-edit"></i>Add
                  </span>
                  <span class="message"><bean:write name="TaskHeadUserForm" property="message" /></span>
            </p>
            <!-- Search Handler Tag -->
			<div class="show-in-page">
				Show per page
				<html:select name="TaskHeadUserForm" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listShowEntries" label="value" value="key"/>
				</html:select>
				<input type="button" class="btn bg-olive" style="height:32px" onclick="flyToPage('<%=Constants.Task.DOSEARCH%>')" value='Refresh'/>
			</div>
			<div class="search-table">
				<html:select name="TaskHeadUserForm" property="columnSearch" styleClass="columnSearch">
					<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
				</html:select>
				<html:text name="TaskHeadUserForm" property="search" styleClass="textSearch"/>
				<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="flyToPage('<bean:write name="TaskHeadUserForm" property="task" />')" value='Search'/>
				<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchAll('<bean:write name="TaskHeadUserForm" property="task" />')" value='Show All'/>
			</div>
			<!-- End Of Search Handler -->
			
			<!-- Table List -->
			<div class="box-body">
			<table id="table-1" class="table table-bordered table-striped table-hover">
				<thead><tr>
					<th>Task Name</th>
					<th width="15px"></th>
					<th>Task Description</th>
					<th width="100px">Task Assigner</th>
					<th width="100px">Task Receiver</th>
					<th width="80px">Start Date</th>
					<th width="85px">Estimate Date</th>
					<th width="50px">Status</th>
                    <th width="40px">Actions</th>
                </tr></thead>
                <tbody>
                <logic:notEmpty name="listTask">
					<logic:iterate id="iter" name="listTask">
	                	<tr>
	                	    <td><bean:write name="iter" property="taskName"/></td>
	                	    <td align="center">
	                	    	<logic:greaterThan name="iter" property="percentage" value="50">
	                	    		<span class="badge bg-green">
		                	    		<jsp:include page="/content/Percentage.jsp">
		                	    			<jsp:param name="status" value="${iter.taskLastStatus}" />
		                	    			<jsp:param name="percentage" value="${iter.percentage}" />
		                	    		</jsp:include>
	                	    		</span>
		                		</logic:greaterThan>
		                		<logic:lessEqual name="iter" property="percentage" value="50">
	                	    		<span class="badge bg-red">
		                	    		<jsp:include page="/content/Percentage.jsp">
		                	    			<jsp:param name="status" value="${iter.taskLastStatus}" />
		                	    			<jsp:param name="percentage" value="${iter.percentage}" />
		                	    		</jsp:include>
	                	    		</span>
		                		</logic:lessEqual>
	                	    </td>
	                	    <td><bean:write name="iter" property="taskDescription"/></td>
	                	    <td><bean:write name="iter" property="taskAssignerName"/></td>
	                	    <td><bean:write name="iter" property="taskReceiverName"/></td>
	                	    <td align="center"><bean:write name="iter" property="taskStartDate" format="dd MMMM yyyy"/></td>
	                	    <td align="center"><bean:write name="iter" property="taskEstimateDate" format="dd MMMM yyyy"/></td>
	                	    <td align="center">
		                		<jsp:include page="/content/Status.jsp">
                	    			<jsp:param name="status" value="${iter.taskLastStatus}" />
                	    		</jsp:include>
	                		</td>
	                        <td align="center">
	                        	<input type="submit" class="btn btn-primary btn-xs" value='Details' onclick="flyToTaskDetail('<%=Constants.Task.GOTOVIEW %>', '<bean:write name="iter" property="taskId"/>')">
	                        </td>
	                    </tr>
                    </logic:iterate>
					</logic:notEmpty>
                  </tbody>
            </table></div>
            <!-- End Of Table List -->
			            
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