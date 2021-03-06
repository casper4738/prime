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
	
	function flyToDelete(task, value, confirmMessage) {
		$.ajax({ 
	          type	  : "POST",
	          url	  : '<%=Constants.PAGES_LIST[Constants.Page.ADMIN_POSITION]%>',  
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
						 alert("This Position can't be deleted")
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
		<h1>Manage Position</h1>
		<ol class="breadcrumb">
			<li><a href="javascript:void(0)" onclick="menuLoadHandler('${homepage}')"> <i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage Position</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Manage Position</h3></div>
				
				<p><span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
	               		<i class="fa fa-edit"></i>Add
	               </span>
	               <span class="message"><bean:write name="PositionAdminForm" property="message" /></span>
	            </p>
				
				<!-- Search Handler Tag -->
			    <div class="show-in-page">
			     	Show per page
			     	<html:select property="showInPage" name="PositionAdminForm" onchange="change(this.value)">
			      		<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
			     	</html:select>
			    </div>
			    
			    <div class="search-table">
			    <html:form action="/PositionAdmin" >
					<html:hidden name="PositionAdminForm" property="task"/>
					<html:hidden name="PositionAdminForm" property="tmpId"/>
					<html:hidden name="PositionAdminForm" property="goToPage"/>
					<html:hidden name="PositionAdminForm" property="showInPage"/>
					<html:hidden name="PositionAdminForm" property="isShowAll"/>
					<table>
						<tr>
							<td style="padding-left:5px">
								<html:select name="PositionAdminForm" property="columnSearch" styleClass="form-control columnSearch">
						      		<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
						     	</html:select>
						     </td>
						     <td style="padding-left:5px">
			     				<html:text name="PositionAdminForm" property="search" styleClass="form-control textSearch"/>
			     			</td>
			     			<td style="padding-left:5px">
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="PositionAdminForm" property="task" />', 'false')" value='Search'/>
								<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="PositionAdminForm" property="task" />', 'true')" value='Show All'/>					
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
							<th>Position Name</th>
							<th width="120px">Position Level</th>
		                    <th width="90px">Actions</th>
		                </tr>
		            </thead>
	                <tbody>
	                <logic:notEmpty name="listPosition">
						<logic:iterate id="iter" name="listPosition">
		                	<tr>
		                		<td><bean:write name="iter" property="positionName"/></td>
		                		<td align="center"><bean:write name="iter" property="positionLevel"/></td>
		                        <td align="center">
		                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOEDIT%>', '<bean:write name="iter" property="positionId"/>')" src="resources/image/edit.png" />
		                        	<input type="image" onclick="flyToDelete('<%=Constants.Task.DODELETE%>', '<bean:write name="iter" property="positionId"/>', '<%=Constants.Confirmation.DELETE %>')" src="resources/image/remove.png" />
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
		   			<jsp:param name="formName" value="PositionAdminForm" />
		   		</jsp:include>
				<!-- End of Paging -->
	        </div></div>
        </div>
	</section>

</body>
</html>