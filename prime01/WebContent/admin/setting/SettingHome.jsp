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
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
	
		<jsp:include page="/content/Header.jsp"></jsp:include>
		
		<div class="content-wrapper">
			<section class="content-header">
				<h1>Manage General Setting<small>management system</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Manage General Setting</li>
				</ol>
			</section>


			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title">Data General Setting</h3></div>
					<p><span class="message"><bean:write name="SettingAdminForm" property="message" /></span></p>
					<br/>
					<br/>
					
					<div class="box-body">
                  	<html:form action="/SettingAdmin">
                  		<html:hidden name="SettingAdminForm" property="task" value="edit"/>
                  		<table  class="form-input" align="center" border="2px" cellspacing="5px" style="width: 500px;">
                  			<tr>
                  				<td colspan="3">
									<html:submit value="Edit" styleClass="btn btn-primary"/>
								</td>
                  			</tr>
                  			<tr>
                  				<td width="150px">Level</td>
                  				<td align="center">:</td>
                  				<td><html:text name="SettingAdminForm" property="settingBean.level" styleClass="form-control" style="text-align:center" disabled="true"/></td>
                  			</tr>
                  			<tr>
                  				<td>Time Out (minutes)</td>
                  				<td align="center">:</td>
                  				<td><html:text  name="SettingAdminForm" property="settingBean.timeOut" styleClass="form-control" style="text-align:center" disabled="true"/></td>
                  			</tr>
                  			<tr>
                  				<td>Database Parameter</td>
                  				<td align="center">:</td>
                  				<td><html:text  name="SettingAdminForm" property="settingBean.databaseParameter" styleClass="form-control" style="text-align:center" disabled="true"/></td>
                  			</tr>
                  			<tr>
                  				<td>Minimum Level Approval</td>
                  				<td align="center">:</td>
                  				<td><html:text  name="SettingAdminForm" property="settingBean.minLevelApproval" styleClass="form-control" style="text-align:center" disabled="true"/></td>
                  			</tr>
                  		</table>
                  	</html:form>
                    </div>
		        	</div></div>
		        </div>
			</section>
		</div>
		<!-- /.content-wrapper -->
		<jsp:include page="/content/Footer.jsp"></jsp:include>
	</div>

	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
</body>
</html>