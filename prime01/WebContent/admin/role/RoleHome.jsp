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
		
		function flyToDelete(task, value, confirmMessage) {
			$.ajax({ 
		          type	  : "POST",
		          url	  : '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_ROLE]%>',  
		          data	  : 'task=<%=Constants.Task.DOVALIDATE1%>&tmpId=' + value,
		          success : function(msg){
						 param = msg.split('#');
						 
						 if(param[0] == "0"){ //Success
						 	var tmpForm = document.forms[0]; 
							if(confirmMessage != null){
								if(!confirm(confirmMessage))	
									return;
							}
							tmpForm.task.value = task;
							tmpForm.tmpId.value = value;
							menuLoadHandler(tmpForm.action, serialize(tmpForm));
						 } else {			   //Failed
							 alert("This Role can't be deleted")
						 	 $('#btn-save').show();
							 $('#btn-cancel').show();
						 }
		          },
		          
		          error: function(){
						alert("ERROR");
		        	  	//TO DO :: Add Error Handling
		          }
		     });
		}
	</script>
	<!-- End of JS -->
</head>
<body class="skin-blue sidebar-mini">	
	<section class="content-header">
		<h1>Manage Role</h1>
		<ol class="breadcrumb">
			<li><a href="javascript:void(0)" onclick="menuLoadHandler('${homepage}')"> <i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage Role</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Manage Role</h3></div>
				<p><span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
	                   <i class="fa fa-edit"></i>Add
	               </span>
	            <span class="message"><bean:write name="RoleAdminForm" property="message" /></span></p>
	            
	            <!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select name="RoleAdminForm" property="showInPage" onchange="change(this.value)" >
						<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
					<html:form action="/RoleAdmin" >
						<html:hidden name="RoleAdminForm" property="task"/>
						<html:hidden name="RoleAdminForm" property="tmpId"/>
						<html:hidden name="RoleAdminForm" property="goToPage"/>
						<html:hidden name="RoleAdminForm" property="showInPage"/>
						<html:hidden name="RoleAdminForm" property="isShowAll"/>
						<table>
							<tr>
								<td style="padding-left:5px">
									<html:select name="RoleAdminForm" property="columnSearch" styleClass="form-control columnSearch">
										<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
									</html:select>
								</td>
								<td style="padding-left:5px">
									<html:text name="RoleAdminForm" property="search" styleClass="form-control textSearch"/>
								</td>
								<td style="padding-left:5px">
									<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="RoleAdminForm" property="task" />', 'false')" value='Search'/>
									<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="RoleAdminForm" property="task" />', 'true')" value='Show All'/>					
								</td>
							</tr>
						</table>
					</html:form>
				</div>
				<!-- End Of Search Handler -->
			    
			    <!-- Table List -->
				<div class="box-body"><table class="table table-bordered table-striped table-hover" id="table-1">
					<thead><tr>
						<th>Role Name</th>
	                    <th width="60px">Status</th>
	                </tr></thead>
	                <tbody>
	                <logic:notEmpty name="listRole">
						<logic:iterate id="iter" name="listRole">
		                	<tr>
		                		<td><bean:write name="iter" property="roleName"/></td>
		                        <td align="center">
		                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOEDIT%>', '<bean:write name="iter" property="roleId"/>')" src="resources/image/edit.png" />
		                        	<input type="image" onclick="flyToDelete('<%=Constants.Task.DODELETE%>', '<bean:write name="iter" property="roleId"/>', '<%=Constants.Confirmation.DELETE %>')" src="resources/image/remove.png" />
		                        </td>
		                    </tr>
	                    </logic:iterate>
						</logic:notEmpty>
	                  </tbody>
	            </table></div>
	            <!-- End Of Table List -->
	            
				<!-- Paging -->
		        <jsp:include page="/content/Pagination.jsp">
		   			<jsp:param name="formName" value="RoleAdminForm" />
		   		</jsp:include>
				<!-- End of Paging -->
	        </div></div>
        </div>
	</section>

</body>
</html>