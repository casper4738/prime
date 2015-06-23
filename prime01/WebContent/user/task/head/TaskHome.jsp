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
	<section class="content-header">
		<h1>Manage Tasks</h1></h1>
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
				<html:form action="/TaskHeadUser" >
					<html:hidden name="TaskHeadUserForm" property="task"/>
					<html:hidden name="TaskHeadUserForm" property="taskId"/>
					<html:hidden name="TaskHeadUserForm" property="goToPage"/>
					<html:hidden name="TaskHeadUserForm" property="showInPage"/>
					<html:select name="TaskHeadUserForm" property="columnSearch" styleClass="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="TaskHeadUserForm" property="search" styleClass="textSearch"/>
					<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="flyToPage('search')" value='Search'/>
					<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchAll('search')" value='Show All'/>
				</html:form>
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
	                	    		<span class="badge bg-green"><bean:write name="iter" property="percentage"/>%</span>
		                		</logic:greaterThan>
		                		<logic:lessEqual name="iter" property="percentage" value="50">
	                	    		<span class="badge bg-red"><bean:write name="iter" property="percentage"/>%</span>
		                		</logic:lessEqual>
	                	    </td>
	                	    <td><bean:write name="iter" property="taskDescription"/></td>
	                	    <td><bean:write name="iter" property="taskAssignerName"/></td>
	                	    <td><bean:write name="iter" property="taskReceiverName"/></td>
	                	    <td align="center"><bean:write name="iter" property="taskStartDate" format="dd MMMM yyyy"/></td>
	                	    <td align="center"><bean:write name="iter" property="taskEstimateDate" format="dd MMMM yyyy"/></td>
	                	    <td align="center">
		                		<logic:equal name="iter" property="taskLastStatus" value='<%=Constants.Status.CREATE+""%>'>
		                			<span class="label label-warning">Receive</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="taskLastStatus" value='<%=Constants.Status.SUBMIT+""%>'>
		                			<span class="label label-primary">Submit</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="taskLastStatus" value='<%=Constants.Status.PAUSE+""%>'>
		                			<span class="label label-warning">Pause</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="taskLastStatus" value='<%=Constants.Status.FINISH+""%>'>
		                			<span class="label label-primary">Finish</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="taskLastStatus" value='<%=Constants.Status.ABORT+""%>'>
		                			<span class="label label-danger">Abort</span>
		                		</logic:equal>
		                		<logic:equal name="iter" property="taskLastStatus" value='<%=Constants.Status.PROGRESS+""%>'>
		                			<span class="label label-success">Progress</span>
		                		</logic:equal>
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
			<!-- End of Paging -->
        </div></div>
        
        </div>
	</section>
</body>
</html>