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
		   info   	 : false,
		   language  : { "emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>" }
		});

		function flyToEdit(task, value, confirmMessage) {
			var tmpForm = document.forms[0];
			if(confirmMessage != null){
				if(!confirm(confirmMessage))	
					return;
			}
			tmpForm.task.value = task;
			tmpForm.tmpValue.value = value;
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
	
	</script>
	<!-- End of JS -->
	
	
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage User</h1>
		<ol class="breadcrumb">
			<li><a href="javascript:void(0)" onclick="menuLoadHandler('${homepage}')"> <i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage Users</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h1 class="box-title">Data Manage User</h1></div>
			<p><span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
                   <i class="fa fa-edit"></i>Add
				</span>
			<span class="message"><bean:write name="UserAdminForm" property="message" /></span></p>
			
			<!-- Search Handler Tag -->
			<div class="show-in-page">
				Show per page
				<html:select name="UserAdminForm" property="showInPage" styleClass="columnSearch"  onchange="change(this.value)">
					<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>	
				</html:select>
			</div>
			<div class="search-table">
				<html:form action="/UserAdmin" >
					<html:hidden name="UserAdminForm" property="task"/>
					<html:hidden name="UserAdminForm" property="goToPage"/>
					<html:hidden name="UserAdminForm" property="tmpValue"/>
					<html:hidden name="UserAdminForm" property="showInPage"/>
					<html:hidden name="UserAdminForm" property="isShowAll"/>
					<table>
						<tr>
							<td style="padding-left:5px">
								<html:select name="UserAdminForm" property="columnSearch" styleClass="form-control columnSearch">
									<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
								</html:select>
							</td>
							<td style="padding-left:5px">
								<html:text name="UserAdminForm" property="search" styleClass="form-control textSearch" />
							</td>
							<td style="padding-left:5px">
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="UserAdminForm" property="task" />', 'false')" value='Search'/>
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="UserAdminForm" property="task" />', 'true')" value='Show All'/>					
							</td>
						</tr>
					</table>
				</html:form>
			</div>
			<div class="box-body"><table class="table table-bordered table-striped table-hover" id = "table-1">
				<thead><tr>
					<th width="180px">Username</th>
					<th>Employee Name</th>
					<th width="80px">Employee Id</th>
					<th>System Level</th>
                    <th width="30px">Active Dir.</th>
                    <th width="30px">Status</th>
                    <th width="50px">Actions</th>
                </tr></thead>
                <tbody>
                	<logic:notEmpty name="listUser">
					<logic:iterate id="iter" name="listUser">
	                	<tr>
	                		<td><bean:write name="iter" property="userName"/> </td>
	                		<td><bean:write name="iter" property="employeeName"/> </td>
	                		<td align="center"><bean:write name="iter" property="employeeId"/> </td>
	                		<td align="left"><bean:write name="iter" property="sysName"/> </td>
	                        <td align="center">
	                        	<logic:equal name="iter" property="isActiveDirectory" value="false">
	                        	<span class="label label-danger">No</span>
	                        	</logic:equal>
	                        	<logic:equal name="iter" property="isActiveDirectory" value="true">
	                        	<span class="label label-success">Yes</span>
	                        	</logic:equal>
	                        </td>
	                        <td align="center">
	                        <logic:equal name="iter" property="statusUser" value="0">
	                        	<span class="label label-danger">Locked</span>
	                        </logic:equal>
	                         <logic:equal name="iter" property="statusUser" value="1">
	                        	<span class="label label-success">Active</span>
	                        </logic:equal>
	                        <logic:equal name="iter" property="statusUser" value="2">
	                        	<span class="label label-warning">Locked</span>
	                        </logic:equal>
	                        <logic:equal name="iter" property="statusUser" value="3">
	                        	<span class="label label-warning">Active</span>
	                        </logic:equal>
	                        </td>
	                        <td align="center">
	                         <logic:equal name="iter" property="statusUser" value="1">
	                        	<input type="image" title="Edit User" onclick="flyToEdit('<%=Constants.Task.GOTOEDIT%>', '<bean:write name="iter" property="userName"/>')" src="resources/image/edit.png" />
	                        	<input type="image" title="Lock User" onclick="flyToEdit('<%=Constants.Task.DOLOCK%>', '<bean:write name="iter" property="userName"/>', '<%=Constants.Confirmation.LOCK %>')" src="resources/image/locked.png" />
	                        </logic:equal>
	                           <logic:equal name="iter" property="statusUser" value="2">
	                        	<input type="image" title="Lock User" onclick="flyToEdit('<%=Constants.Task.DOLOCK%>', '<bean:write name="iter" property="userName"/>', '<%=Constants.Confirmation.UNLOCK %>')" src="resources/image/unlocked.png" />
	                        </logic:equal>
	                           <logic:equal name="iter" property="statusUser" value="3">
	                        	<input type="image" title="Lock User" onclick="flyToEdit('<%=Constants.Task.DOLOCK%>', '<bean:write name="iter" property="userName"/>', '<%=Constants.Confirmation.UNLOCK %>')" src="resources/image/unlocked.png" />
	                        </logic:equal>
	                    	</td>
	                    </tr>
                    </logic:iterate>
				</logic:notEmpty>
				</tbody>
			</table></div>
   	        <!-- End Of Table List -->
    	       
			<!-- Paging -->
	        <jsp:include page="/content/Pagination.jsp">
	   			<jsp:param name="formName" value="UserAdminForm" />
	   		</jsp:include>
			<!-- End of Paging -->
        </div></div>
        
        </div>
	</section>
</body>
</html>
