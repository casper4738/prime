<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<!-- JS -->
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#datepicker').datepicker({
                format: "yyyy-mm-dd"
            });  
        });
		
		function validateForm() {
			document.getElementById('validatorDate').innerHTML = "";
			document.getElementById('validatorDescription').innerHTML = "";
		    var holidayDescription =  document.getElementById('descriptionValidator').value;
		    var holidayDate =  new Date(document.getElementById('datepicker').value);
		    var today = new Date();
		    var validate = true;
		    
		    if (holidayDescription == null || holidayDescription == "") {
		        document.getElementById('validatorDescription').innerHTML="Description must be filled out";
		        validate = false;
		    } 
		    
		    if (holidayDate == null || holidayDate == "") {
		    	document.getElementById('validatorDate').innerHTML="Date must be filled out";
		        validate = false;
		    } 
		    
		    if ( holidayDate < today){
		    	//alert("Invalid value for year: " + regs[3] + " - must be > = " + (new Date()).getFullYear());
		    	document.getElementById('validatorDate').innerHTML="Holiday date is not  valid";
		        validate = false;
		    }
		    
		    if(validate == true) dosubmit();
		}
	</script>
	<!-- End of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Holiday</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')" >Manage Holiday</html:link></li>
			<li class="active">Add Holiday</li>
		</ol>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-xs-12"><div class="box">
				<div class="box-header"><h3 class="box-title">Data Holiday</h3></div>
				<div class="box-body">
                	<html:form action="/HolidayAdmin">
                		<html:hidden name="HolidayAdminForm" property="task" value="<%=Constants.Task.DOADD%>"/>
                		<table class="form-input" align="center">
                			<tr><td width="150px">Date</td>
                				<td>: </td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                				  	<html:text name="HolidayAdminForm" property="holidayBean.holidayDate" styleClass="form-control pull-right" styleId="datepicker"/>
                				  	</div>
                				</td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="validatorDate" style="color: red"></span></td>
                			</tr>
                			<tr><td>Holiday Description</td>
                				<td>: </td>
                				<td><html:text name="HolidayAdminForm" property="holidayBean.holidayDescription" styleClass="form-control" styleId="descriptionValidator" maxlength="100"/></td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span  id="validatorDescription" style="color: red"></span></td>
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
