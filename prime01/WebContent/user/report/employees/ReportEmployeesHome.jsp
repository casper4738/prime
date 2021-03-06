<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<html>
<head> 
	<!-- CSS -->
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
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
	    } );
		
		
		function flyToEmployeeTaskDetail(task, value) {
			var tmpForm = document.forms[0];
			tmpForm.task.value = task;
			tmpForm.employeeId.value = value;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		 function generateReport(){
			var tempTask = document.forms[0].task.value;
			document.forms[0].target = "_blank";
			document.forms[0].task.value = "<%=Constants.Task.REPORT.GENERATEREPORTEMPLOYEE%>";
			document.forms[0].submit();
			document.forms[0].task.value = tempTask;
		 }
		 
		 $(document).ready(function () {
          	$('.columnSearch').on('change',function(){
            	onselect($(this).val());
            });
            
            onselect($('.columnSearch').val());
         });
		 function onselect(value) {
			if(value == "GENDER") {
            	$('#textSearch').css('display', 'none') ;
            	$('#genderSearch').css('display', 'block') ;
            	$('#statusSearch').css('display', 'none') ;
            } else if(value == "STATUS") {
            	$('#textSearch').css('display', 'none') ;
            	$('#genderSearch').css('display', 'none') ;
            	$('#statusSearch').css('display', 'block') ;
            } else {
            	$('#textSearch').css('display', 'block') ;
            	$('#genderSearch').css('display', 'none') ;
            	$('#statusSearch').css('display', 'none') ;
            }
		}
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Employee Report</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li class="active">Employee Report</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Employee Report Data</h3></div>
	            <p><span class="button-add btn btn-app bg-olive btnCancel" onclick="generateReport()">
	               <i class="fa fa-save"></i>Export
	              </span>
	              </p>
            <p><span class="message"><bean:write name="ReportUserEmployeesForm" property="message" /></span></p>    
				<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select property="showInPage" name="ReportUserEmployeesForm" onchange="change(this.value)">
						<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
				<html:form action="/ReportEmployees">
					<html:hidden name="ReportUserEmployeesForm" property="task"/>
					<html:hidden name="ReportUserEmployeesForm" property="tmpId"/>
					<html:hidden name="ReportUserEmployeesForm" property="goToPage"/>
					<html:hidden name="ReportUserEmployeesForm" property="showInPage"/>
					<html:hidden name="ReportUserEmployeesForm" property="employeeId"/>
					<html:hidden name="ReportUserEmployeesForm" property="isShowAll"/>
					<html:hidden name="ReportUserEmployeesForm" property="tempTask"/>
			<table>
				<tr>
					<td style="padding-left:5px">
						<html:select name="ReportUserEmployeesForm" property="columnSearch" styleClass="form-control columnSearch">
							<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
						</html:select>
					</td>
					<td style="padding-left:5px"><html:text name="ReportUserEmployeesForm" property="search" styleId="textSearch" styleClass="form-control textSearch"/></td>
					<td style="padding-left:5px">
						<html:select name="ReportUserEmployeesForm" property="genderSearch" styleClass="form-control" styleId="genderSearch" style="width:150px">
							<html:option value="0">Male</html:option>
							<html:option value="1">Female</html:option>
						</html:select>
					</td>
					<td style="padding-left:5px">
						<html:select name="ReportUserEmployeesForm" property="statusSearch" styleClass="form-control" styleId="statusSearch" style="width:150px">
							<html:option value="0">Active</html:option>
							<html:option value="1">Resign</html:option>
						</html:select>
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
						<thead>
							<tr>
								<th>Employee ID</th>
								<th>Name</th>
								<th>Gender</th>
								<th>Email</th>
								<th>Division</th>
								<th>Position</th>
								<th>Manager</th>
								<th width="60px">Status</th>
			                    <th width="90px">Actions</th>
			                </tr>
			            </thead>
			              <tbody>
			               <logic:notEmpty name="listReportEmployees">
							<logic:iterate id="iter" name="listReportEmployees">
			                	<tr>
			                		<td><bean:write name="iter" property="employeeId"/> </td>
			                		<td><bean:write name="iter" property="employeeName"/> </td>
			                		<td align="center"><logic:equal name="iter" property="gender" value="0">
				                			Male
				                		</logic:equal>
				                		<logic:equal name="iter" property="gender" value="1">
				                			Female
				                		</logic:equal>
			                		</td>
			                		<td><bean:write name="iter" property="email"/> </td>
			                		<td align="center"><bean:write name="iter" property="divisionName"/> </td>
			                		<td><bean:write name="iter" property="positionName"/> </td>
			                		<td><bean:write name="iter" property="managerName"/> </td>
			                		<td align="center">
				                        <logic:empty name="iter" property="resignDate">
				                        	<span class="label label-success">Active</span>
				                        </logic:empty>
				                        <logic:notEmpty name="iter" property="resignDate">
				                        	<span class="label label-danger">Resign</span>
				                        </logic:notEmpty>
			                        </td>
			                        <td align="center">
			                        	<input type="submit" class="btn btn-primary btn-xs" value='Details' onclick="flyToEmployeeTaskDetail('<%=Constants.Task.REPORT.GOTODETAILEMPLOYEE %>', '<bean:write name="iter" property="employeeId"/>')">
			                        </td>
			                    </tr>
		                    </logic:iterate>
							</logic:notEmpty>
		                   </tbody>
			            </table>
			            </div>
			            <!-- End Of Table List -->
			            
						<!-- Paging -->
				        <jsp:include page="/content/Pagination.jsp">
				   			<jsp:param name="formName" value="ReportUserEmployeesForm" />
				   		</jsp:include>
						<!-- End of Paging -->
		        	</div>
	        	</div>
	      </div>
	</section>
</body>
</html>
