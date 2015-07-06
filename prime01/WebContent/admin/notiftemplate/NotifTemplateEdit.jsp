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
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script type="text/javascript">

	function validateForm() {
		$('#nameValidator').html('');
		$('#valueValidator').html('');
		$('#descValidator').html('');
		
		var specialChars = "/*!@#$%^&*()\"{}_[]|\\?/<>,"; 
	    var notifTemplateName =  $('#notifTemplateName').val();
		var notifTemplateValue =  $('#notifTemplateValue').val();
		var notifTemplateDesc = $('#notifTemplateDesc').val();
	    var tmpValidated = true;
	    
	    if (notifTemplateName == null || notifTemplateName == "") {
	        $('#nameValidator').html('Notif template name must be filled out');
	        tmpValidated = false;
	    }
	    else {
	    	if (notifTemplateName.length > 300){
	    		 $('#nameValidator').html('Maximum character allowed is 300');
	    		 tmpValidated = false;
	    	}
	    	else{
		    	for (var i = 0; i < notifTemplateName.length; i++) {
		    	    if (specialChars.indexOf(notifTemplateName.charAt(i)) != -1) { 
		    			$('#nameValidator').html('Characters are not allowed');
		    			tmpValidated = false; 
		    		}
		    	}
	    	}
	    }
	    
	    if (notifTemplateValue == null || notifTemplateValue == "") {
	        $('#valueValidator').html('Notif template value must be filled out');
	        tmpValidated = false;
	    }
	    else {
	    	if (notifTemplateValue.length > 500){
	    		 $('#valueValidator').html('Maximum character allowed is 500');
	    		 tmpValidated = false; 
	    	}
	    }
	    
	    if (notifTemplateDesc == null || notifTemplateDesc == "") {
	        $('#descValidator').html('Notif template desc must be filled out');
	        tmpValidated = false;
	    }
	    else {
	    	if (notifTemplateDesc.length > 500){
	    		 $('#descValidator').html('Maximum character allowed is 500!');
	    		 tmpValidated = false;
	    	}
	    }
	    
	    if (tmpValidated){
	    	dosubmit();
	    }
	}  
	
	/* function showNotifPreview() {
		$('#notif-preview').html($('#valueValidator'));
	} */
	</script>
	
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
			<section class="content-header">
				<h1>Manage Notification Template
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Manage Notification Template</li>
				</ol>
			</section>

			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title">Data Notification Template</h3></div>
					<div class="box-body">
                  	<html:form action="/NotifTemplate"	>
                  		<html:hidden name="NotifTemplateForm" property="task" value="<%=Constants.Task.DOEDIT%>"/>
                  		<html:hidden name="NotifTemplateForm" property="notifTemplateBean.notifTemplateId" />
                  		<table class="form-input" align="center">
                  			<tr>
                  				<td width="200px">Notif Template Name</td>
                  				<td>:</td>
                  				<td><html:text name="NotifTemplateForm" property="notifTemplateBean.notifTemplateName" styleClass="form-control" styleId="notifTemplateName" maxlength="300"/></td>
                  			</tr>
                  			<tr>
                  				<td></td>
                  				<td></td>
                  				<td><i><span  id="nameValidator" style="color: red"></span></i></td>
                  			</tr>
                  			<tr>
	                  			<td width="200px">Notif Template Value</td>
	                  			<td>:</td>
                  			<td> <html:textarea name="NotifTemplateForm" property="notifTemplateBean.notifTemplateValue" styleClass="form-control" styleId="notifTemplateValue" rows="5"/> </td>
                  			</tr>
                  			<tr>
                  				<td></td>
                  				<td></td>
                  				<td><i><span  id="valueValidator" style="color: red"></span></i></td>
                  			</tr>
                  			<!-- <tr>
	                  			<td width="200px">Notif Template Preview</td>
	                  			<td>:</td>
                  			<td><input type="button" class="btn bg-olive" style="height:32px" onclick="showNotifPreview()" value='Refresh'/><div id="notif-preview"></div></td>
                  			</tr> -->
                  			<tr>
	                  			<td width="200px">Notif Template Description</td>
	                  			<td>:</td>
	                  			<td><html:textarea name="NotifTemplateForm" property="notifTemplateBean.notifTemplateDescription" styleClass="form-control" styleId="notifTemplateDesc" rows="5"/></td>
                  			</tr>
                  			<tr>
                  				<td></td>
                  				<td></td>
                  				<td><i><span  id="descValidator" style="color: red"></span></i></td>
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