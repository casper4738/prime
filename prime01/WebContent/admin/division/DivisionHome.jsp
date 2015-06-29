<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<script type="text/javascript">
		$('#table-1').dataTable( {
			   paging    : false,
			   searching : false,
			   info   : false,
			   language  : {
			          "emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>"
			      }
			     } );
	</script>
</head>
	<body class="skin-blue sidebar-mini">
		<section class="content-header">
			<h1>Manage Division<small>management system</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li class="active">Manage Division</li>
			</ol>
		</section>
	
		<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Manage Division</h3></div>
				
				<p><span class="button-add btn btn-app bg-olive" onclick="menuLoadHandler('<%=Constants.PAGES_LIST[Constants.Page.ADMIN_DIVISION]%>', 'task=<%=Constants.Task.GOTOADD%>')">
	                   <i class="fa fa-edit"></i>Add
	                  </span>
	                 <span class="message"><bean:write name="DivisionAdminForm" property="message" /></span></p>
				
				<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select name="DivisionAdminForm" property="showInPage" styleClass="columnSearch"  onchange="change(this.value)">
						<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>							
					</html:select>
					<input type="button" class="btn bg-olive" style="height:32px" onclick="searchAll('<%=Constants.Task.DOSEARCH%>')"  value='Refresh'/>
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
						<html:text name="DivisionAdminForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
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
	</body>
</html>