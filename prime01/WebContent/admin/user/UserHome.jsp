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
	   info   : false,
	   language  : {
		   "emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>"
		      }
		     } );

	function page(page) {
		if(page == -1) {
			document.forms[0].goToPage.value = document.getElementById('page').value;
		} else {
			document.forms[0].goToPage.value = page;			
		}
		document.forms[0].submit();
	}
	
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
				<h1>Manage User<small>management system</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
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
						<input type="button" class="btn bg-olive" style="height:32px" onclick="searchAll('<%=Constants.Task.DOSEARCH%>')"  value='Refresh'/>
					</div>
					<div class="search-table">
						<html:form action="/UserAdmin" >
							<html:hidden name="UserAdminForm" property="task"/>
							<html:hidden name="UserAdminForm" property="goToPage"/>
							<html:hidden name="UserAdminForm" property="tmpValue"/>
							<html:hidden name="UserAdminForm" property="showInPage"/>
							<html:select name="UserAdminForm" property="columnSearch" styleClass="columnSearch">
								<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
							</html:select>
							<html:text name="UserAdminForm" property="search" styleClass="textSearch"/>
							<input type="button" class="btn bg-olive" style="height:32px" onclick="javascript:flyToPage('<%=Constants.Task.DOSEARCH%>')" value='Search'/>
							<input type="button" class="btn bg-olive" style="height:32px" onclick="searchAll('<%=Constants.Task.DOSEARCH%>')" value='Show All'/>
						</html:form>
					</div>
					<div class="box-body"><table class="table table-bordered table-striped table-hover" id = "table-1">
						<thead><tr>
							<th>Username</th>
							<th>Sys Level</th>
							<th>Employee Id</th>
							<th>Employee Name</th>
		                    <th>Status</th>
		                    <th>Actions</th>
		                </tr></thead>
		                <tbody>
		                	<logic:notEmpty name="listUser">
							<logic:iterate id="iter" name="listUser">
			                	<tr>
			                		<td><bean:write name="iter" property="userName"/> </td>
			                		<td><bean:write name="iter" property="sysLevel"/> </td>
			                		<td><bean:write name="iter" property="employeeId"/> </td>
			                		<td><bean:write name="iter" property="employeeName"/> </td>
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
			                        	<input type="image" onclick="flyToEdit('<%=Constants.Task.GOTOEDIT%>', '<bean:write name="iter" property="userName"/>')" src="resources/image/edit.png" />
			                        	<input type="image" onclick="flyToEdit('<%=Constants.Task.DOLOCK%>', '<bean:write name="iter" property="userName"/>', '<%=Constants.Confirmation.LOCK %>')" src="resources/image/locked.png" />
			                        </logic:equal>
			                           <logic:equal name="iter" property="statusUser" value="2">
			                        	<input type="image" onclick="flyToEdit('<%=Constants.Task.DOLOCK%>', '<bean:write name="iter" property="userName"/>', '<%=Constants.Confirmation.UNLOCK %>')" src="resources/image/unlocked.png" />
			                        </logic:equal>
			                           <logic:equal name="iter" property="statusUser" value="3">
			                        	<input type="image" onclick="flyToEdit('<%=Constants.Task.DOLOCK%>', '<bean:write name="iter" property="userName"/>', '<%=Constants.Confirmation.UNLOCK %>')" src="resources/image/unlocked.png" />
			                        </logic:equal>
			                    	</td>
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
							<html:text name="UserAdminForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
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
			<script src="resources/prime.js"></script>
			<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
			<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
			<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
			<script src="resources/plugins/fastclick/fastclick.min.js"></script>
			<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
			<script src="resources/dist/js/demo.js" type="text/javascript"></script>
</body>
</html>