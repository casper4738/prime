<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<html>
<head> 
	<!-- CSS -->
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false
	    } );
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	
	

	<section class="content-header">
		<h1>Manage Log</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li class="active">Manage Logs</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Manage Log</h3></div>
				<p>
		         	<span class="message"><bean:write name="LogAdminForm" property="message" /></span>
		         </p>
	                
				<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select property="showInPage" name="LogAdminForm" onchange="change(this.value)">
						<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
					<html:form action="/LogAdmin">
					<html:hidden name="LogAdminForm" property="task"/>
					<html:hidden name="LogAdminForm" property="tmpId"/>
					<html:hidden name="LogAdminForm" property="goToPage"/>
					<html:hidden name="LogAdminForm" property="showInPage"/>
					<html:select name="LogAdminForm" property="columnSearch" styleClass="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="LogAdminForm" property="search" styleClass="textSearch"/>
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
								<th>Log ID</th>
								<th>Username</th>
								<th>Table</th>
								<th>Activity Time</th>
								<th>Activity Description</th>
			                </tr>
			            </thead>
			              <tbody>
			               <logic:notEmpty name="listLog">
								<logic:iterate id="iter" name="listLog">
				                	<tr>
				                		<td align="center"><bean:write name="iter" property="auditTrailId"/> </td>
				                		<td align="center"><bean:write name="iter" property="username"/> </td>
				                		<td>
				                		<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.EMPLOYEES+""%>'>
												EMPLOYEES
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.USERS+""%>'>
												USERS
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.DIVISIONS+""%>'>
												DIVISIONS
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.POSITIONS+""%>'>
												POSITIONS
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.ROLES+""%>'>
												ROLES
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.RESIGN_EMPLOYEES+""%>'>
												RESIGN_EMPLOYEES
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.DAY_OFFS+""%>'>
												DAY_OFFS
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.NATIONAL_HOLIDAYS+""%>'>
												NATIONAL_HOLIDAYS
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.WEEKEND_HOLIDAYS+""%>'>
												WEEKEND_HOLIDAYS
											</logic:equal>
				                			<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.ACTIVITIES+""%>'>
												ACTIVITIES
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.TASKS+""%>'>
												TASKS
											</logic:equal>	
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.PROJECTS+""%>'>
												PROJECTS
											</logic:equal>
											<logic:equal  name="iter" property="auditTrailTable" value='<%=Constants.LogTable.NOTIFICATIONS+""%>'>
												NOTIFICATIONS
											</logic:equal>				                			
				                		 </td>
				                		<td><bean:write name="iter" property="auditTrailTime" format="dd-MM-yyyy HH:mm:SS"/> </td>
						                <td>
						                	<logic:equal name="iter" property="auditTrailAction" value='<%=Constants.LogAction.INSERT+""%>'>
												INSERT
											</logic:equal>
											<logic:equal name="iter" property="auditTrailAction" value='<%=Constants.LogAction.AFTER+""%>'>
												UPDATE AFTER 
											</logic:equal>
											<logic:equal name="iter" property="auditTrailAction" value='<%=Constants.LogAction.BEFORE+""%>'>
												UPDATE BEFORE 
											</logic:equal>
											<logic:equal name="iter" property="auditTrailAction" value='<%=Constants.LogAction.DELETE+""%>'>
												DELETE
											</logic:equal>
						                 </td>
						             </tr>
					             </logic:iterate>
							 </logic:notEmpty>
								 <logic:empty name="listLog">
								   <tr>
										<td align="center" colspan="11"><bean:message key="label.table.notfound" /></td>
								   </tr>
								 </logic:empty>
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
							
							
							<html:text name="LogAdminForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
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