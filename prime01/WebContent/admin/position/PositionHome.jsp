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
	</script>
	<!-- End of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Position</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
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
					<html:select name="PositionAdminForm" property="columnSearch">
			      		<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
			     	</html:select>
			     	<html:text name="PositionAdminForm" property="search"/>
			     	<input type="button" class="btn bg-olive" style="height:32px" onclick="flyToPage('<%=Constants.Task.DOSEARCH%>')" value='Search'/>
					<input type="button" class="btn bg-olive" style="height:32px" onclick="searchAll('<%=Constants.Task.DOSEARCH%>')" value='Show All'/>
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
		                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.DODELETE%>', '<bean:write name="iter" property="positionId"/>', '<%=Constants.Confirmation.DELETE %>')" src="resources/image/remove.png" />
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