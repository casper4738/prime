<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- JS -->
	<script type="text/javascript">
		$('#table-1').dataTable( {
			   paging    : false,
			   searching : false,
			   info   : false,
			   language  : {
			          "emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>"
			   }
		});
	</script>
	<!-- End of JS -->
</head>
	<body class="skin-blue sidebar-mini">
		<section class="content-header">
			<h1>Manage Division</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li class="active">Manage Division</li>
			</ol>
		</section>
	
		<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Manage Division</h3></div>
				
				<p><span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
	                   	<i class="fa fa-edit"></i>Add
	               </span>
	            <span class="message"><bean:write name="DivisionAdminForm" property="message" /></span></p>
				
				<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select name="DivisionAdminForm" property="showInPage" styleClass="columnSearch"  onchange="change(this.value)">
						<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>							
					</html:select>
				</div>
				<div class="search-table">
					<html:form action="/DivisionAdmin" >
						<html:hidden name="DivisionAdminForm" property="task" />
						<html:hidden name="DivisionAdminForm" property="tmpId"/>
						<html:hidden name="DivisionAdminForm" property="goToPage"/>
						<html:hidden name="DivisionAdminForm" property="showInPage"/>
						
						<html:select name="DivisionAdminForm" property="columnSearch" styleClass="columnSearch">
							<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
						</html:select>
						<html:text name="DivisionAdminForm" property="search" styleClass="textSearch"/>
						<input type="button" class="btn bg-olive" style="height:32px" onclick="javascript:flyToPage('<%=Constants.Task.DOSEARCH%>')" value='Search'/>
						<input type="button" class="btn bg-olive" style="height:32px" onclick="searchAll('<%=Constants.Task.DOSEARCH%>')" value='Show All'/>
					</html:form>
				</div>
				<!-- End Of Search Handler -->
	
				<!-- Table List -->
				<div class="box-body">
					<table class="table table-bordered table-striped table-hover" id="table-1">
					<thead><tr>
						<th>Division Name</th>
	                    <th width="90px">Actions</th>
	                </tr></thead>
	                <tbody>
	                <logic:notEmpty name="listDivision">
						<logic:iterate id="iter" name="listDivision">
		                	<tr>
		                		<td><bean:write name="iter" property="divisionName"/></td>
		                        <td align="center">
		                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOEDIT%>', '<bean:write name="iter" property="divisionId"/>')" src="resources/image/edit.png" />
		                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.DODELETE%>', '<bean:write name="iter" property="divisionId"/>', '<%=Constants.Confirmation.DELETE %>')" src="resources/image/remove.png" />
		                        </td>	
		                    </tr> 
	                    </logic:iterate>
					</logic:notEmpty>
	                  </tbody>
	            </table></div>
	            <!-- End Of Table List -->
		            
	            <!-- Paging -->
		        <jsp:include page="/content/Pagination.jsp">
		   			<jsp:param name="formName" value="DivisionAdminForm" />
		   		</jsp:include>
				<!-- End of Paging -->
	        </div></div>
	        
	        </div>
		</section>
	</body>
</html>
