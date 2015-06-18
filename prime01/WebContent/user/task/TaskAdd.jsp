<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Prime</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<link href="resources/ionicons-2.0.1/css/ionicons.min.css"
	rel="stylesheet" type="text/css" />
<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet"
	type="text/css" />
<link href="resources/dist/css/skins/_all-skins.min.css"
	rel="stylesheet" type="text/css" />
<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<jsp:include page="/content/Header.jsp"></jsp:include>
		<div class="content-wrapper">
			<section class="content-header">
				<h1>
					Choose Task<small>management system</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Tasks & Activities</li>
				</ol>
			</section>

			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<!-- 					<div class="box-header"><h3 class="box-title">Data Task</h3></div> -->
							<div class="box-body">
								<html:form action="/TaskUser">
									<html:hidden name="TaskUserForm" property="task" value="insert" />
									<html:hidden name="TaskUserForm" property="taskBean.taskId" />
									<table class="form-input" align="center">
										<tr>
											<td align="center"><h3>Task Type</h3></td>
										</tr>
										<tr>
											<td align="center">Choose Task Type:</td>

										</tr>
										<tr>
											<td align="center"><html:radio property="radioChoose"
													value="choose">Self Assign</html:radio></td>

											<td><html:button property="" value="Next" styleClass="btn btn-default"
													onclick="flyToPage('choose')"/></td>
										</tr>
										<tr>
											<td align="center"><html:radio property="radioChoose"
													value="choose">Subbordinate</html:radio></td>
										</tr>
										<tr>
											<div class="box-body">
												<table
													class="table table-bordered table-striped table-hover">
													<tr>
														<td>Employee Id</td>
														<td>Employee Name</td>
														<td>Gender</td>
														<td>Email</td>
														<td>Division</td>
														<td>Position</td>
														<td>Level</td>
														<td>Manager</td>
													</tr>
												</table>
											</div>
										</tr>
										<tr>
											<td><html:button property="" value="Next"
													styleClass="btn btn-default" onclick="flyToPage('choose2')" /></td>
											<td><html:button property="" value="Cancel"
													styleClass="btn btn-default" onclick="flyToPage('success')" /></td>
										</tr>
									</table>
								</html:form>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<!-- /.content-wrapper -->
		<jsp:include page="/content/Footer.jsp"></jsp:include>
	</div>

	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js"
		type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
</body>
</html>