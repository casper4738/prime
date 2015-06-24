<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Activity User
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">Manage Activity</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title">Select Activity</h3></div>
			<p>
				<span class="button-add btn btn-app bg-olive" onclick="flyToPage('back')">
                    <i class="fa fa-edit"></i>Back
                </span>
            </p>
			
			<!-- Search Handler Tag -->
			<div class="show-in-page">
				Show per page
				<html:select name="DashboardUserForm" property="showInPage" onchange="change(this.value)" >
					<html:optionsCollection name="listShowEntries" label="value" value="key"/>
				</html:select>
				<input type="button" class="btn bg-olive" style="height:32px" onclick="flyToPage('<%=Constants.Task.DOSEARCH%>')" value='Refresh'/>
			</div>
			<div class="search-table">
				<html:form action="/DashboardUser">
					<html:hidden name="DashboardUserForm" property="task"/>
					<html:hidden name="DashboardUserForm" property="taskId"/>
					<html:hidden name="DashboardUserForm" property="goToPage"/>
					<html:hidden name="DashboardUserForm" property="showInPage"/>
					<html:select name="DashboardUserForm" property="columnSearch" styleClass="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="DashboardUserForm" property="search" styleClass="textSearch"/>
					<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="flyToPage('search')" value='Search'/>
					<input type="button" class="btn btn-sm bg-olive" style="height:32px" onclick="searchAll('search')" value='Show All'/>
				</html:form>
			</div>
			<!-- End Of Search Handler -->
			
			<div class="box-body">
				<table class="table table-bordered table-striped table-hover">
				<thead><tr>
					<th>Activity Name</th>
					<th>Activity Description</th>
					<th>Task Name</th>
					<th>Assigner</th>
					<th>Status</th>
					<th>Last Update</th>
                    <th width="90px" align="center">Actions</th>
                </tr></thead>
                <tbody>
                <logic:notEmpty name="listActivity">
					<logic:iterate id="iter" name="listActivity">
	                	<tr>
	                		<td><bean:write name="iter" property="activityName"/></td>
	                		<td><bean:write name="iter" property="activityDescription"/></td>
	                		<td><bean:write name="iter" property="taskName"/></td>
	                		<td><bean:write name="iter" property="taskAssigner"/></td>
	                		<td><bean:write name="iter" property="status"/></td>
	                		<td><bean:write name="iter" property="changeDate"/></td>
	                        <td align="center">
	                        	<input type="button" value="select" onclick="flyToEditDelete('addToDoList','<bean:write name="iter" property="activityId"/>')">
	                        </td>	
	                    </tr> 
                    </logic:iterate>
					</logic:notEmpty>
					<logic:empty name="listActivity">
						<tr>
							<td align="center" colspan="7">DATA NOT FOUND</td>
						</tr>
					</logic:empty>
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
					<html:text name="DashboardUserForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
					<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
				</div>
			</ul>
			
			<div class="paginate-2">
				Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
			</div>
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