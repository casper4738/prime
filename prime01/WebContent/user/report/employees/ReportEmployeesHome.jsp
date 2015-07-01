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
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
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
				document.forms[0].target = "_blank";
				document.forms[0].task.value = "<%=Constants.Task.REPORT.GENERATEREPORTEMPLOYEE%>";
				document.forms[0].submit();
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
					<html:select property="showInPage" name="ReportUserEmployeesForm" onchange="change(this.value)" styleClass="columnSearch">
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
			<table>
				<tr>
					<td style="padding-left:5px">
						<html:select name="ReportUserEmployeesForm" property="columnSearch" styleClass="columnSearch">
							<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
						</html:select>
					</td>
					<td style="padding-left:5px"><html:text name="ReportUserEmployeesForm" property="search" styleId="textSearch"/></td>
					<td style="padding-left:5px">
						<html:select name="ReportUserEmployeesForm" property="genderSearch" styleId="genderSearch" style="width:150px">
							<html:option value="0">Male</html:option>
							<html:option value="1">Female</html:option>
						</html:select>
					</td>
					<td style="padding-left:5px">
						<html:select name="ReportUserEmployeesForm" property="statusSearch" styleId="statusSearch" style="width:150px">
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
				                        	<%-- <html:image src="resources/image/check-true.png" />  --%>
				                        </logic:empty>
				                        <logic:notEmpty name="iter" property="resignDate">
				                        	<span class="label label-danger">Resign</span>
				                        	<%-- <html:image src="resources/image/check-false.png" />  --%>
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
							
							<html:text name="ReportUserEmployeesForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
							<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
						</ul>
						<div class="paginate-2">
							Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
						</div>
						<!-- End of Paging -->
		        	</div>
	        	</div>
	      </div>
	</section>
</body>
</html>
