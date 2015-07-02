<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<html>
<head> 
	<!-- CSS -->
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
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
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Notification Template</h1>
		<ol class="breadcrumb">
			<li><i class="fa fa-dashboard"></i> Home</li>
			<li class="active">Manage Notification Template</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Notification Template</h3></div>
				<p>
					<span class="button-add btn btn-app bg-olive" onclick="flyToPage('<%=Constants.Task.GOTOADD%>')">
		          		<i class="fa fa-edit"></i>Add
		         	</span>
		         	<span class="message"><bean:write name="NotifTemplateForm" property="message" /></span>
		         </p>
	                
				<!-- Search Handler Tag -->
				<div class="show-in-page">
					Show per page
					<html:select property="showInPage" name="NotifTemplateForm" onchange="change(this.value)" styleClass="columnSearch">
						<html:optionsCollection name="listMaxDataPerPage" label="value" value="key"/>
					</html:select>
				</div>
				<div class="search-table">
				<html:form action="/NotifTemplate">
					<html:hidden name="NotifTemplateForm" property="task"/>
					<html:hidden name="NotifTemplateForm" property="tmpId"/>
					<html:hidden name="NotifTemplateForm" property="goToPage"/>
					<html:hidden name="NotifTemplateForm" property="showInPage"/>
				</html:form>
				</div>
				<!-- End Of Search Handler -->
		
				<!-- Table List -->
				<div class="box-body">
					<table id="table-1" class="table table-bordered table-striped table-hover">
						<thead>
							<tr>
								<th width="120px">Notif Template ID</th>
								<th>Notif Name</th>
								<th>Notif Value</th>
								<th>Notif Description</th>
			                    <th width="55px">Actions</th>
			                </tr>
			            </thead>
			              <tbody>
			               <logic:notEmpty name="listNotifTemplate">
							<logic:iterate id="iter" name="listNotifTemplate">
			                	<tr>
			                		<td><bean:write name="iter" property="notifTemplateId"/> </td>
			                		<td><bean:write name="iter" property="notifTemplateName"/> </td>   
			                		<td><bean:write name="iter" property="notifTemplateValue"/> </td>              	
			                		<td><bean:write name="iter" property="notifTemplateDescription"/> </td>
			                        <td align="center">
			                        	
				                        	<input type="image" onclick="flyToEditDelete('<%=Constants.Task.GOTOEDIT%>', '<bean:write name="iter" property="notifTemplateId"/>')" src="resources/image/edit.png" />  
			                  
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
				   			<jsp:param name="formName" value="NotifTemplateForm" />
				   		</jsp:include>
						<!-- End of Paging -->
		        	</div>
	        	</div>
	      </div>
	</section>
</body>
</html>
