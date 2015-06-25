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
	<!-- End of CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	function validateForm() {
	    var holidayDescription =  document.getElementById('nameValidator').value;
	    var holidayDate =  document.getElementById('levelValidator').value;
	    if (holidayDescription == null || holidayDescription == "") {
	        document.getElementById('validator').innerHTML="Name must be filled out";
	        return false;
	    }
	    else if (holidayDate == null || holidayDate == "") {
	    	document.getElementById('validator').innerHTML="Level must be filled out";
	        return false;
	    }
	    else dosubmit();
	}
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
					<div class="box-header"><h3 class="box-title">Data Position</h3></div>
					<div class="box-body">
                  	<html:form action="/PositionAdmin">
                  		<html:hidden name="PositionAdminForm" property="task" value="<%=Constants.Task.DOADD%>"/>
                  		<html:hidden name="PositionAdminForm" property="positionBean.positionId" />
                  		<table class="form-input" align="center">
                  			<tr>
                  				<td>Position Name</td>
                  				<td>:</td>
                  				<td><html:text name="PositionAdminForm" property="positionBean.positionName" styleClass="form-control" styleId="nameValidator"/></td>
                  			</tr>
                  			<tr>
                  				<td>Position Level</td>
                  				<td>:</td>
                  				<td><html:select name="PositionAdminForm" property="positionBean.positionLevel" styleClass="form-control" styleId="levelValidator">
							      		<html:optionsCollection name="listPositionLevel" label="value" value="key"/>
							     	</html:select>
						     	</td>
                  			</tr>
                  			<tr>
                  				<td colspan="3" align="center">
                  					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="validateForm()" />
                  					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="flyToPage('success')"/>
                  				</td>
                  			</tr>
                  			<tr>
                  				<td colspan="3" align="center"> <span  id="validator" style="color: red"> </span> </td>
                  			</tr>
                  		</table>
                  	</html:form>
                    </div>
		        	</div></div>
		        </div>
			</section>
</body>
</html>