<%@page import="prime.constants.Constants"%>
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
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
	
<script type="text/javascript">
	function validateForm() {
		document.getElementById('validatorDescription').innerHTML = "";
	    var holidayDescription =  document.getElementById('descriptionValidator').value;
	    var validate = true;
	    
	    if (holidayDescription == null || holidayDescription == "") {
	        document.getElementById('validatorDescription').innerHTML="Description must be filled out";
	        validate = false;
	    }
	    if(validate == true) dosubmit();
	}
	</script>
</head>
<body class="skin-blue sidebar-mini">
			<section class="content-header">
				<h1>Manage Holiday<small>management system</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Manage Holiday</li>
				</ol>
			</section>

			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title">Data Role</h3></div>
					<div class="box-body">
                  	<html:form action="/HolidayAdmin">
                  		<html:hidden name="HolidayAdminForm" property="task" value="<%=Constants.Task.DOEDIT%>"/>
                  		<html:hidden name="HolidayAdminForm" property="holidayBean.holidayDate"/>
                  		<table class="form-input" align="center">
                  			<tr>
                  				<td width="150px">Date</td>
                  				<td>: </td>
                  				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                  				  	<html:text name="HolidayAdminForm" property="holidayBean.holidayDate" styleClass="form-control pull-right" styleId="datepicker" disabled="true"/>
                  				  	</div>
                  				</td>
                  			</tr>
                  			<tr>
                  				<td>Holiday Description</td>
                  				<td>: </td>
                  				<td><html:text name="HolidayAdminForm" property="holidayBean.holidayDescription" styleClass="form-control" styleId="descriptionValidator" maxlength="100"/></td>
                  			</tr>
                  			<tr>
                  			<td colspan="3" align="center"> <span  id="validatorDescription" style="color: red"> </span> </td>
                  			</tr>
                  			<tr>
                  				<td colspan="3" align="center">
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
		</div>
	</div>

	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#datepicker').datepicker({
                format: "yyyy-mm-dd"
            });  
        });
    </script>
</body>
</html>