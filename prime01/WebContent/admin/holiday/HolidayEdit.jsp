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
	
	<!-- CSS -->
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<!-- JS -->
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#datepicker').datepicker({
                format: "yyyy-mm-dd"
            });  
        });
		
		function validateForm() {
			var holidayDescription = checkNull($('#holidayDescription'), $('#err-holidayDescription'), "Holiday Description");
			if(holidayDescription) {
			} else {
				dosubmit();
			}
		}
	</script>
	<!-- End of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Holiday</h1>
		<ol class="breadcrumb">
			<li><a href="javascript:void(0)" onclick="menuLoadHandler('${homepage}')"> <i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')" >Manage Holiday</html:link></li>
			<li class="active">Edit Holiday</li>
		</ol>
	</section>
<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Holiday</h3></div>
				<div class="box-body">
                	<html:form action="/HolidayAdmin">
                		<html:hidden name="HolidayAdminForm" property="task" value="<%=Constants.Task.DOEDIT%>"/>
                		<html:hidden name="HolidayAdminForm" property="holidayBean.holidayDate"/>
                		
                		<table class="form-input" align="center">
                			<tr><td width="150px">Date</td>
                				<td>: </td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                				  		<html:text name="HolidayAdminForm" property="holidayBean.holidayDate" styleClass="form-control pull-right" disabled="true" styleId="datepicker"/>
                				  	</div>
                				</td>
                			</tr>
                			<tr><td>Holiday Description</td>
                				<td>: </td>
                				<td><html:text name="HolidayAdminForm" property="holidayBean.holidayDescription" styleClass="form-control" styleId="holidayDescription" maxlength="100"/></td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-holidayDescription" class="error-validator"></span></span></td>
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
</body>
</html>