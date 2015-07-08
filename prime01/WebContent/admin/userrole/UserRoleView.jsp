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
	
	<!-- JS -->
	<script type="text/javascript">
	function dosubmit() {
		var tmpForm = document.forms[0];
		var tmpVal = "";
		for(var i=0; i < tmpForm.menu.length; i++) {
			tmpVal += tmpForm.menu[i].value+"-"+tmpForm.menu[i].checked+", ";
		}
		tmpVal = tmpVal.substring(0, tmpVal.length - 1);
		//alert(tmpVal);
		tmpForm.checkboxTes.value = tmpVal; 
		menuLoadHandler(tmpForm.action, serialize(tmpForm));
	}

	function docheck() {
		var tmpForm = document.forms[0];
		for(var i=0; i < tmpForm.menu.length; i++) {
			tmpForm.menu[i].checked =  true;
		}
	}
	</script>
	
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
			<section class="content-header">
				<h1>Manage User Role</h1>
				<ol class="breadcrumb">
					<li><a href="javascript:void(0)" onclick="menuLoadHandler('${homepage}')"> <i class="fa fa-dashboard"></i> Home</a></li> 
					<li class="active">Manage User Role</li>
				</ol>
			</section>

			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title">Data User Role</h3></div>
					<div class="box-body">
                  	<html:form action="/UserRole"	>
                  		<html:hidden name="UserRoleForm" property="task" value="<%=Constants.Task.DOCHECK%>"/>
                  		<html:hidden name="UserRoleForm" property="checkboxTes"/>
                  		<html:hidden name="UserRoleForm" property="userRoleBean.userRoleId" />
                  		<html:hidden name="UserRoleForm" property="userRoleBean.userMenuAction" />
                  		<table class="form-input" align="center">
                  			 <thead>
								<tr>
									<th>User Menu Name</th>
		  							<th>Action / <a href="javascript:void(0)" onclick="docheck()"> Check All </a></th>
				                </tr>
				           </thead>
			               <tbody>
			               <logic:notEmpty name="listUserMenu">
							<logic:iterate id="iter" name="listUserMenu">
			                	<tr>
			                        <td><bean:write name="iter" property="userMenuName"/></td>
									<td align="center">
				                        <logic:equal name="iter" property="isCheck" value="true">
				                        	<input type="checkbox" name="menu" value="${iter.userMenuId}"  checked="checked">
				                        </logic:equal>
				                        <logic:equal name="iter" property="isCheck" value="false">
				                        	<input type="checkbox" name="menu" value="${iter.userMenuId}" > 
				                        </logic:equal>
			                        </td>
			                    </tr> 
			                   </logic:iterate>
						</logic:notEmpty>
						</tbody>
                  			<tr>
                  				<td colspan="3" align="center">
                  					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="dosubmit()" />
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