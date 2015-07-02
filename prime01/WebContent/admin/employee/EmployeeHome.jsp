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
	    });
		
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
		<h1>Manage Employee</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li class="active">Manage Employees</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Data Manage Employee</h3></div>
			
			<p><span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
		          	<i class="fa fa-edit"></i>Add
		       </span>
			<span class="message"><bean:write name="EmployeeAdminForm" property="message" /></span></p>
	                
			<!-- Search Handler Tag -->
			<div class="show-in-page">
				Show per page
				<html:select property="showInPage" name="EmployeeAdminForm" onchange="change(this.value)">
					<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
				</html:select>
			</div>
			<div class="search-table">
			<html:form action="/EmployeeAdmin">
				<html:hidden name="EmployeeAdminForm" property="task"/>
				<html:hidden name="EmployeeAdminForm" property="tmpId"/>
				<html:hidden name="EmployeeAdminForm" property="goToPage"/>
				<html:hidden name="EmployeeAdminForm" property="showInPage"/>
				<html:hidden name="EmployeeAdminForm" property="isShowAll"/>
			
			<table>
				<tr>
					<td style="padding-left:5px">
						<html:select name="EmployeeAdminForm" property="columnSearch" styleClass="form-control columnSearch">
							<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
						</html:select>
					</td>
					<td style="padding-left:5px"><html:text name="EmployeeAdminForm" property="search" styleId="textSearch" styleClass="form-control textSearch"/></td>
					<td style="padding-left:5px">
						<html:select name="EmployeeAdminForm" property="genderSearch" styleClass="form-control" styleId="genderSearch" style="width:150px">
							<html:option value="0">Male</html:option>
							<html:option value="1">Female</html:option>
						</html:select>
					</td>
					<td style="padding-left:5px">
						<html:select name="EmployeeAdminForm" property="statusSearch" styleClass="form-control" styleId="statusSearch" style="width:150px">
							<html:option value="0">Active</html:option>
							<html:option value="1">Resign</html:option>
						</html:select>
					</td>
					<td style="padding-left:5px">
						<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="EmployeeAdminForm" property="task" />', 'false')" value='Search'/>
						<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="EmployeeAdminForm" property="task" />', 'true')" value='Show All'/>					
					</td>
				</tr>
			</table>
			</html:form>
			</div>
			<!-- End Of Search Handler -->
		
			<!-- Table List -->
			<div class="box-body">
				<table id="table-1" class="table table-bordered table-striped table-hover">
					<thead><tr> <th>Employee ID</th>
								<th>Name</th>
								<th>Gender</th>
								<th>Email</th>
								<th>Division</th>
								<th>Position</th>
								<th>Manager</th>
		                    	<th width="60px">Status</th>
		                    	<th width="90px">Actions</th>
					</tr></thead>
					<tbody>
		               	<logic:notEmpty name="listEmployee">
							<logic:iterate id="iter" name="listEmployee">
			                	<tr><td><bean:write name="iter" property="employeeId"/> </td>
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
			                        	<logic:empty name="iter" property="resignDate">
				                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOEDIT%>', '<bean:write name="iter" property="employeeId"/>')" src="resources/image/edit.png" />
				                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOEDITPOSITION%>', '<bean:write name="iter" property="employeeId"/>')" src="resources/image/editposdiv.png" width="18"/>
				                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTORESIGN%>', '<bean:write name="iter" property="employeeId"/>')" src="resources/image/resign.png" /> 
			                        	</logic:empty>
			                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOVIEW%>', '<bean:write name="iter" property="employeeId"/>')" src="resources/image/viewmore.png" />
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
			   			<jsp:param name="formName" value="EmployeeAdminForm" />
			   		</jsp:include>
					<!-- End of Paging -->
        	</div></div>
		</div>
	</section>
</body>
</html>
