<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head>
	<link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css"" rel="stylesheet" type="text/css" />
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

		 function generateReport() {
			var tempTask = document.forms[0].task.value;
			document.forms[0].target = "_blank";
			document.forms[0].task.value = "<%=Constants.Task.REPORT.GENERATEREPORTEMPLOYEETASK%>";
			document.forms[0].task.value = tempTask;
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
	<html:form action="/ReportEmployees" >
		<html:hidden name="ReportUserEmployeesForm" property="task"/>
		<html:hidden name="ReportUserEmployeesForm" property="tmpId"/>
		<html:hidden name="ReportUserEmployeesForm" property="goToPage"/>
		<html:hidden name="ReportUserEmployeesForm" property="showInPage"/>
		<html:hidden name="ReportUserEmployeesForm" property="isShowAll"/>
	</html:form>
					
	<section class="content-header">
		<h1>Employee Tasks</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Employee Report</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Employee Report</h3></div>
			<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
			<tr><td width="50%">Employee Id : <bean:write name="ReportUserEmployeesForm" property="reportEmployeesBean.employeeId"/></td>
				<td>Employee Name : <bean:write name="ReportUserEmployeesForm" property="reportEmployeesBean.employeeName" /> </td>
			</tr>
			<tr><td>Gender : <bean:write name="ReportUserEmployeesForm" property="reportEmployeesBean.gender"/> </td>
				<td>Email : <bean:write name="ReportUserEmployeesForm" property="reportEmployeesBean.email"/> </td>
			</tr><tr><td>Division : <bean:write name="ReportUserEmployeesForm" property="reportEmployeesBean.divisionName"/>
				</td><td>Position : <bean:write name="ReportUserEmployeesForm" property="reportEmployeesBean.positionName" /> 
				</td>
			</tr>
			<tr>
			<td colspan="2">Manager : <bean:write name="ReportUserEmployeesForm" property="reportEmployeesBean.managerName" /></td>
			</tr>
			</table>
			 <p><span class="button-add btn btn-app bg-olive btnCancel" onclick="generateReport()">
	               <i class="fa fa-save"></i>Export
	              </span>
	              </p>
            <!-- Search Handler Tag -->
			<div class="show-in-page">
				Show per page
				<html:select name="ReportUserEmployeesForm" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listShowEntries" label="value" value="key"/>
				</html:select>
			</div>
			<div class="search-table">
				<html:form action="/TaskSubordinateUser" >
					<html:hidden name="ReportUserEmployeesForm" property="task"/>
					<html:hidden name="ReportUserEmployeesForm" property="taskId"/>
					<html:hidden name="ReportUserEmployeesForm" property="goToPage"/>
					<html:hidden name="ReportUserEmployeesForm" property="showInPage"/>
					<html:hidden name="ReportUserEmployeesForm" property="isShowAll"/>
					<table>
						<tr>
							<td style="padding-left:5px"><html:select name="ReportUserEmployeesForm" property="columnSearch" styleClass="form-control columnSearch">
									<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
								</html:select>
							</td>
							<td style="padding-left:5px"><html:text name="ReportUserEmployeesForm" property="search" styleClass="form-control textSearch" styleId="textSearch"/></td>
							<td style="padding-left:5px">
								<div id="date_start">
								<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
	     				  					<html:text name="ReportUserEmployeesForm" property="startDate" styleClass="form-control pull-right" styleId="start"/>
	     				  				</div>
	     				  				</div>
	     				  			</td>
							<td style="padding-left:5px"><div id="date_line">-</div></td>
							<td style="padding-left:5px">
								<div id="date_until">
								<div class="input-group" style="width:140px"><div class="input-group-addon"><i class="fa fa-calendar" ></i></div>
	     				  					<html:text name="ReportUserEmployeesForm" property="untilDate" styleClass="form-control pull-right" styleId="until" />
	     				  				</div>
	     				  				</div>
   				  			</td>
							<td style="padding-left:5px">
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="ReportUserEmployeesForm" property="task" />', 'false')" value='Search'/>
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="ReportUserEmployeesForm" property="task" />', 'true')" value='Show All'/>					
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
					<th width="80px">Start Date</th>
					<th width="85px">Estimate Date</th>
					<th>From Project</th>
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
	                	    <td align="center"><bean:write name="iter" property="taskStartDate" format="dd MMMM yyyy"/></td>
	                	    <td align="center"><bean:write name="iter" property="taskEstimateDate" format="dd MMMM yyyy"/></td>
	                	    <td><bean:write name="iter" property="projectName"/></td>
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
    			<jsp:param name="formName" value="ReportUserEmployeesForm" />
    		</jsp:include>
			<!-- End of Paging -->
			
        </div></div>
        
        </div>
	</section>
</body>
</html>