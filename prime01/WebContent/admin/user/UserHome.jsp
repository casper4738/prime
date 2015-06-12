<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>Prime</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<jsp:include page="/content/Header.jsp"></jsp:include>
		
		<div class="content-wrapper">
			<section class="content-header">
				<h1>Manage User<small>management system</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Manage Users</li>
				</ol>
			</section>

			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title">Data Manage User</h3></div>
					
					<p><span class="button-add btn btn-app bg-navy" onclick="javascript:alert('Add New Data')">
	                    <i class="fa fa-edit"></i>Add
                    </span></p>
					
					<div class="show-in-page">
						Show per page
						<html:select property="showInPage" name="UserAdminForm" styleId="view_data">
							<html:option value="5">5</html:option>
							<html:option value="10">10</html:option>
							<html:option value="25">25</html:option>
							<html:option value="50">50</html:option>
						</html:select>
					</div>
					<div class="search-table">
						Search : <html:text name="UserAdminForm" property="search"/>
					</div>
					<div class="box-body"><table class="table table-bordered table-striped table-hover">
						<thead><tr>
							<th>Username</th>
							<th>Sys Level</th>
							<th>Employee Name</th>
		                    <th>Status</th>
		                    <th>Actions</th>
		                </tr></thead>
		                <tbody>
		                	<tr><td>alexander</td>
		                        <td>Admin</td>
		                        <td>Alexander</td>
		                        <td align="center"><html:image src="resources/image/unlocked.png" /></td>
		                        <td align="center">
		                        	<html:image src="resources/image/edit.png" />
		                        	<html:image src="resources/image/remove.png" />
		                        </td>
		                    </tr>
		                    <tr><td>alexander</td>
		                        <td>Operator</td>
		                        <td>Alexander</td>
		                        <td align="center"><html:image src="resources/image/locked.png" /></td>
		                        <td align="center">
		                        	<html:image src="resources/image/edit.png" />
		                        	<html:image src="resources/image/remove.png" />
		                        </td>
		                    </tr>
	                   </tbody>
		            </table></div>
					<ul class="pagination">
						<li tabindex="0"><html:link styleClass="paging" href="#">First</html:link></li>
						<li tabindex="1"><html:link styleClass="paging" href="#"><<</html:link> </li>
						<li tabindex="2"><html:link styleClass="active" href="#">1</html:link></li>
						<li tabindex="3"><html:link styleClass="paging_active" href="#">2</html:link></li>
						<li tabindex="4"><html:link styleClass="paging_active" href="#">3</html:link></li>
						<li tabindex="5"><html:link styleClass="paging_active" href="#">4</html:link></li>
						<li tabindex="6"><html:link styleClass="paging_active" href="#">5</html:link></li>
						<li tabindex="7"><html:link styleClass="paging" href="#">>></html:link> </li>
						<li tabindex="8"><html:link styleClass="paging" href="#">Last</html:link></li>
					</ul>
					<div class="paginate-2">
						Record Data 10, Page 1 of 10
					</div>
		        </div></div>
		        
		        </div>
			</section>
		</div>
		<!-- /.content-wrapper -->
		<jsp:include page="/content/Footer.jsp"></jsp:include>
	</div>

	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<!-- 
	<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js" type="text/javascript"></script>
	 -->
	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- 
	<script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	 -->
	<script src="resources/plugins/morris/morris.min.js" type="text/javascript"></script>
	<script src="resources/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
	<script src="resources/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
	<script src="resources/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
	<script src="resources/plugins/knob/jquery.knob.js" type="text/javascript"></script>
	<!-- 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js" type="text/javascript"></script>
	 -->
	<script src="resources/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/pages/dashboard.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
</body>
</html>