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
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	
	

	<section class="content-header">
		<h1>View Notifications</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li class="active">View Notifications</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data View Notifications</h3></div>
				<p>
		         	<span class="message"><bean:write name="NotificationForm" property="message" /></span>
		         </p>
	                
				<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select property="showInPage" name="NotificationForm" onchange="change(this.value)">
						<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
					<html:form action="/Notification">
					<html:hidden name="NotificationForm" property="task"/>
					<html:hidden name="NotificationForm" property="tmpId"/>
					<html:hidden name="NotificationForm" property="goToPage"/>
					<html:hidden name="NotificationForm" property="showInPage"/>
					<html:select name="NotificationForm" property="columnSearch" styleClass="columnSearch">
						<html:optionsCollection name="listSearchColumn" label="value" value="key"/>
					</html:select>
					<html:text name="NotificationForm" property="search" styleClass="textSearch"/>
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
								<th>ID</th>
								<th>Description</th>
								<th>Received Date</th>
								<th>Type</th>
								<th>Status</th>
								<th>Sender</th>
			                </tr>
			            </thead>
			              <tbody>
			               <logic:notEmpty name="listNotification">
								<logic:iterate id="iter" name="listNotification">
				                	<tr>
				                		<td><bean:write name="iter" property="notificationId"/> </td>
				                		<td> <a href="#"><bean:write name="iter" property="notificationNote"/></a></td>
				                		<td><bean:write name="iter" property="notificationSendDate" format="dd-MM-yyyy"/> </td>
				                		<td><bean:write name="iter" property="notificationNameType"/> </td>
				                		<td align="center">
				                			<logic:equal  name="iter" property="notificationStatus" value='<%=Constants.NotificationStatus.READ+""%>'>
												<span class="label label-info">READ</span>
											</logic:equal>
											<logic:equal  name="iter" property="notificationStatus" value='<%=Constants.NotificationStatus.RECEIVED+""%>'>
												<span class="label label-warning">RECEIVED</span>
											</logic:equal>
				                		</td>
				                		<td><bean:write name="iter" property="senderName"/> </td>
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
							
							
							<html:text name="NotificationForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
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