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

		function generateReport(){
				document.forms[0].target = "_blank";
				document.forms[0].task.value = "<%=Constants.Task.REPORT.GENERATEREPORTPROJECTTASK%>";
				document.forms[0].submit();
		}

		function generateReportMember(){
			document.forms[0].target = "_blank";
			document.forms[0].task.value = "<%=Constants.Task.REPORT.GENERATEREPORTPROJECTMEMBER%>";
			document.forms[0].submit();
		}
		 
		 $(document).ready(function () {
	            $('#start').datepicker({
	                format: "yyyy-mm-dd"
	            });  
	            $('#until').datepicker({
	                format: "yyyy-mm-dd"
	            });  
	            
	            $('.columnSearch').on('change',function(){
	            	onselect($(this).val());
	            });
	           
	            onselect($('.columnSearch').val());
	        });
			
			function onselect(value) {
				
				if(value == "STARTDATE" || value == "ESTIMATEDATE") {
	            	$('#textSearch').css('display', 'none') ;
	            	$('#date_start').css('display', 'block') ;
	            	$('#date_line').css('display', 'block') ;
	            	$('#date_until').css('display', 'block') ;
	            } else {
	            	$('#textSearch').css('display', 'block') ;
	            	$('#date_start').css('display', 'none') ;
	            	$('#date_line').css('display', 'none') ;
	            	$('#date_until').css('display', 'none') ;
	            }
			}
	</script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Project's Tasks Report</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Project Report</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Project Report</h3></div>
			<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
			<tr><td>Project Name : ${ReportUserProjectForm.reportProjectBean.projectId} <bean:write name="ReportUserProjectForm" property="reportProjectBean.projectName"/></td>
				<td>Project Assigner : <bean:write name="ReportUserProjectForm" property="reportProjectBean.projectAssignerName" /> </td>
			</tr>
			<tr><td>Start Date : <bean:write name="ReportUserProjectForm" property="reportProjectBean.projectStartDate" format="dd MMMM yyyy"/> </td>
				<td>Project Receiver : <bean:write name="ReportUserProjectForm" property="reportProjectBean.projectReceiverName"/> </td>
			</tr><tr><td>Estimated Date : <bean:write name="ReportUserProjectForm" property="reportProjectBean.projectEstimateDate" format="dd MMMM yyyy" />
				</td><td>Status :  
					<jsp:include page="/content/Status.jsp">
       	    			<jsp:param name="status" value="${ReportUserProjectForm.reportProjectBean.projectLastStatus}" />
       	    		</jsp:include>
				</td>
			</tr>
			<tr><td colspan="2">Description : <bean:write name="ReportUserProjectForm" property="reportProjectBean.projectDescription" /> </td>
			</tr>
			</table>
			<p>
			 	<span class="button-add btn btn-app bg-olive btnCancel" onclick="generateReport()">
	               <i class="fa fa-save"></i>Export Task
	            </span>
	            <span class="button-add btn btn-app bg-olive btnCancel" onclick="generateReportMember()">
	               <i class="fa fa-save"></i>Export Member
	            </span>
	        </p>
            <!-- Search Handler Tag -->
			<div class="show-in-page">
				Show per page
				<html:select name="ReportUserProjectForm" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listShowEntries" label="value" value="key"/>
				</html:select>
			</div>
			<div class="search-table">
				<html:form action="/ReportProject" >
					<html:hidden name="ReportUserProjectForm" property="task"/>
					<html:hidden name="ReportUserProjectForm" property="goToPage"/>
					<html:hidden name="ReportUserProjectForm" property="showInPage"/>
					<html:hidden name="ReportUserProjectForm" property="isShowAll"/>
					<html:hidden name="ReportUserProjectForm" property="projectId"/>
					<table>
						<tr>
							<td style="padding-left:5px"><html:select name="ReportUserProjectForm" property="columnSearch" styleClass="form-control columnSearch">
									<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
								</html:select>
							</td>
							<td style="padding-left:5px"><html:text name="ReportUserProjectForm" property="search" styleClass="form-control textSearch" styleId="textSearch"/></td>
							<td style="padding-left:5px">
								<div id="date_start">
								<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
	     				  					<html:text name="ReportUserProjectForm" property="startDate" styleClass="form-control pull-right" styleId="start"/>
	     				  				</div>
	     				  				</div>
	     				  			</td>
							<td style="padding-left:5px"><div id="date_line">-</div></td>
							<td style="padding-left:5px">
								<div id="date_until">
								<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
	     				  					<html:text name="ReportUserProjectForm" property="untilDate" styleClass="form-control pull-right" styleId="until" />
	     				  				</div>
	     				  				</div>
   				  			</td>
							<td style="padding-left:5px">
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="ReportUserProjectForm" property="task" />', 'false')" value='Search'/>
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="ReportUserProjectForm" property="task" />', 'true')" value='Show All'/>					
							</td>
						</tr>
					</table>
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
	                	    		<span class="badge bg-red" style="font-size: 8pt">
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
	                    </tr>
                    </logic:iterate>
					</logic:notEmpty>
                  </tbody>
            </table></div>
            <!-- End Of Table List -->
			            
            <!-- Paging -->
            <jsp:include page="/content/Pagination.jsp">
    			<jsp:param name="formName" value="ReportUserProjectForm" />
    		</jsp:include>
			<!-- End of Paging -->
			
        </div></div>
        
        </div>
	</section>
</body>
</html>