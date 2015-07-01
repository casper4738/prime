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
		   info   	 : false,
		   language  : {
		          			"emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>"
		      		   }
	});
	</script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage User Menu<small>management system</small></h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage User Menu</li>
		</ol>
	</section>

	<section class="content">
	<div class="row"><div class="col-xs-12"><div class="box">
		<div class="box-header"><h3 class="box-title">Data User Menu</h3></div>
		
		<!-- Search Handler Tag -->
		<div class="show-in-page">
			Show per page
			<html:select name="UserMenuForm" property="showInPage" styleClass="columnSearch"  onchange="change(this.value)">
				<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>							
			</html:select>
		</div>
		<div class="search-table">
			<html:form action="/UserMenu" >
				<html:hidden name="UserMenuForm" property="task" />
				<html:hidden name="UserMenuForm" property="tmpId"/>
				<html:hidden name="UserMenuForm" property="goToPage"/>
				<html:hidden name="UserMenuForm" property="showInPage"/>
				<html:hidden name="UserMenuForm" property="isShowAll"/>
				<html:select name="UserMenuForm" property="columnSearch" styleClass="columnSearch">
					<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
				</html:select>
				<html:text name="UserMenuForm" property="search" styleClass="textSearch"/>
				<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="UserMenuForm" property="task" />', 'false')" value='Search'/>
				<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchBy('<bean:write name="UserMenuForm" property="task" />', 'true')" value='Show All'/>
			</html:form>
			
		</div>
		<!-- End Of Search Handler -->

		<!-- Table List -->
		<div class="box-body"><table class="table table-bordered table-striped table-hover" id="table-1">
			   <thead>
					<tr>
						<th width="90px">User Menu ID</th>
						<th>User Menu Name</th>
						<th width="105px">User Menu Action</th>   
	                </tr>
	           </thead>
               <tbody>
               <logic:notEmpty name="listUserMenu">
				<logic:iterate id="iter" name="listUserMenu">
                	<tr>
                		<td><bean:write name="iter" property="userMenuId"/></td>
                        <td><bean:write name="iter" property="userMenuName"/></td>
                        <td><bean:write name="iter" property="userMenuAction"/></td>
                    </tr> 
                   </logic:iterate>
			</logic:notEmpty>
			</tbody>
		</table></div>
           <!-- End Of Table List -->
            
			<!-- Paging -->
	        <jsp:include page="/content/Pagination.jsp">
	   			<jsp:param name="formName" value="UserMenuForm" />
	   		</jsp:include>
			<!-- End of Paging -->
        </div></div></div>
	</section>
</body>
</html>
