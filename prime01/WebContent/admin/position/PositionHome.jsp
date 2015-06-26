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
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
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
	    } );
	</script>
	<!-- End of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Position<small>management system</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage Position</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Data Manage Position</h3></div>
			
			<p>
				<span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
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
		     	<input type="button" class="btn bg-olive" style="height:32px" onclick="flyToPage('<%=Constants.Task.DOSEARCH%>')" value='Refresh'/>
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
		     	<input type="button" class="btn bg-olive" style="height:32px" onclick="javascript:flyToPage('<%=Constants.Task.DOSEARCH%>')" value='Search'/>
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
				
				<html:text name="PositionAdminForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
				<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
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