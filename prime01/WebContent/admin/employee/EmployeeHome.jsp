<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<html>
<head> 
	<!-- CSS -->
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false
	    } );
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<html:form action="/EmployeeAdmin">
	<html:hidden name="EmployeeAdminForm" property="task"/>
	<html:hidden name="EmployeeAdminForm" property="tmpId"/>
	</html:form>
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
				<p>
					<span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
		          		<i class="fa fa-edit"></i>Add
		         	</span>
		         </p>
	                
				<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select property="showInPage" name="EmployeeAdminForm">
						<html:optionsCollection name="listShowEntries" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
					<html:select name="EmployeeAdminForm" property="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="EmployeeAdminForm" property="search"/>
					<input type="button" class="btn bg-olive" style="height:32px" onclick="javascript:flyToPage('search')" value='Search'/>
					<input type="button" class="btn bg-olive" style="height:32px" onclick="javascript:flyToPage('search')" value='Show All'/>
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
			               <logic:notEmpty name="listEmployee">
							<logic:iterate id="iter" name="listEmployee">
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
					                        	<html:image src="resources/image/check-true.png" /> 
					                        </logic:empty>
					                        <logic:notEmpty name="iter" property="resignDate">
					                        	<html:image src="resources/image/check-false.png" /> 
					                        </logic:notEmpty>
					                        </td>
					                        <td align="center">
					                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOEDIT%>', '<bean:write name="iter" property="employeeId"/>')" src="resources/image/edit.png" />
					                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTORESIGN%>', '<bean:write name="iter" property="employeeId"/>')" src="resources/image/resign.png" /> 
					                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOVIEW%>', '<bean:write name="iter" property="employeeId"/>')" src="resources/image/viewmore.png" />
					                        </td>
					                    </tr>
				                    </logic:iterate>
									</logic:notEmpty>
									<logic:empty name="listEmployee">
										<tr>
											<td align="center" colspan="11"><bean:message key="label.table.notfound" /></td>
										</tr>
									</logic:empty>
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
							
							<html:text name="EmployeeAdminForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
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