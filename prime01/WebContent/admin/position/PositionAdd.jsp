<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- JS -->
	<script type="text/javascript">
		function validateForm() {
			var positionName = checkNull($('#positionName'), $('#err-positionName'), "Position Name");
		    var positionNameChar = checkSpecialChars($('#positionName'), $('#err-positionName'));
		    if (divisionName || positionNameChar) {
		    } else {
		    	dosubmit();
		    }
		    
		}
	</script>
	<!-- End of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Position</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')" >Manage Position</html:link></li>
			<li class="active">Add Position</li>
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
	                		<tr><td>Position Name</td>
	                			<td>:</td>
	                			<td><html:text name="PositionAdminForm" property="positionBean.positionName" styleClass="form-control" styleId="positionName" maxlength="50"/></td>
	                		</tr>
	                		<tr><td></td>
                 				<td></td>
                 				<td><span id="err-positionName" class="error-validator"></span></td>
                 			</tr>
	                		<tr><td>Position Level</td>
	                			<td>:</td>
	                			<td><html:select name="PositionAdminForm" property="positionBean.positionLevel" styleClass="form-control" styleId="levelValidator">
						      			<html:optionsCollection name="listPositionLevel" label="value" value="key"/>
						     		</html:select>
					     		</td>
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