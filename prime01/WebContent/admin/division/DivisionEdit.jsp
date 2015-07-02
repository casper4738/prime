<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
 	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		function validateForm() {
		    var divisionName = checkNull($('#divisionName'), $('#err-divisionName'), "Division Name");
		    var divisionNameChar = checkSpecialChars($('#divisionName'), $('#err-divisionName'));
		    if (divisionName || divisionNameChar) {
		    } else {
		    	dosubmit();
		    }
		}
	</script>
	<!-- End of JS -->
</head>
	<body class="skin-blue sidebar-mini">
		<section class="content-header">
			<h1>Manage Division</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li><html:link href="#" onclick="flyToBack('home')"> Manage Division</html:link></li>
				<li class="active">Edit Division</li>
			</ol>
		</section>
		<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Division</h3></div>
				<div class="box-body">
                 	<html:form action="/DivisionAdmin">
                 		<html:hidden name="DivisionAdminForm" property="task" value="<%=Constants.Task.DOEDIT%>"/>
                 		<html:hidden name="DivisionAdminForm" property="divisionBean.divisionId" />
                 		<table class="form-input" align="center">
                 			<tr><td>Division Name</td>
                 				<td>:</td>
                 				<td><html:text name="DivisionAdminForm" property="divisionBean.divisionName" styleClass="form-control" styleId="divisionName" maxlength="50"/></td>
                 			</tr>
                 			<tr><td></td>
                 				<td></td>
                 				<td><span id="err-divisionName" class="error-validator"></span></td>
                 			</tr>
                 			<tr><td colspan="3" align="center">
                 					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="validateForm()" />
                 					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
                 				</td>
                 			</tr>
                 		</table>
                 	</html:form>
                   </div>
	        	</div></div>
	        </div>
		</section>
	</body>
</html>
