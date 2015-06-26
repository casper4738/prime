<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<html>
<head> 
	<!-- CSS -->
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
    <link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<!-- End CSS -->
	
	<!-- JS -->
	<script src="resources/prime.js"></script>
	<script src="resources/plugins/jQuery/jQuery-2.1.3.min.js"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		$('#table-1').dataTable( {
			paging    : false,
			searching : false,
			info	  : false,
	    } );
		
		<!-- Method Specified For Modal Handling-->
		
		function submitHandler(){
			
			/* 
			var tmpForm = document.forms[0];
			var tmpRetData = serialize(tmpForm);
			var tmpRetAction = tmpForm.action;
			modalSubmitRefreshPageWithoutReturn(tmpRetData, tmpRetAction);
			 */
			var tmpNewPwd = document.getElementById('newPwd');
			var tmpConfirmPwd = document.getElementById('confirmPwd');
			
			if(tmpNewPwd.value == tmpConfirmPwd.value){
				alert("Sama");
				var tmpForm = document.getElementById("userForm");
				var tmpRetData = serialize(tmpForm);
				var tmpRetAction = tmpForm.action;

				tmpForm.task.value = "changePassword";
				var tmpTargetData = serialize(tmpForm);
				var tmpTargetAction = "<%=Constants.PAGES_LIST[Constants.Page.ADMIN_USER]%>";
			
				modalSubmitRefreshPageWithoutReturn(tmpRetData, tmpRetAction, tmpTargetData, tmpTargetAction);
			}
			else{
				alert("New Pwd dan Confirm Pwd tidak sama!");
			} 	
		}
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content">
		<div class="row">
		    <!-- Temporary Form -->
		    <html:form action="/UserAdmin" styleId="userForm">
		      <html:hidden name="UserAdminForm" property="task"/>
		    
		    <!-- End Of Temporary Form -->
		    
			<div class="col-xs-12"><div class="box" align="center">
				<div class="box-header"><h1 class="box-title"><b>Change Password</b></h1><br/><br/></div>
				<table class="form-input" style="width: 500px;">
					<tr>
						<td>Old Password</td>
						<td> : </td>
						<td><html:text styleId="password" name="UserAdminForm" property="userBean.password" styleClass="form-control"/></td>
					</tr>
					<tr>
						<td>New Password</td>
						<td> : </td>
						<td><html:text name="UserAdminForm" property="userBean.newPassword" styleClass="form-control" styleId="newPwd"/></td>
					</tr>
					<tr>
						<td>Confirm New Password</td>
						<td> : </td>
						<td><html:text name="UserAdminForm" property="userBean.confirmPassword" styleClass="form-control" styleId="confirmPwd"/></td>
					</tr>
				</table>
        	</div>
        	<center>
	           <input type="button" value="Submit" class="btn btn-sm  btn-danger" onclick="submitHandler()"/>
       		</center>
       	</div>
       	</html:form>
	      </div>
	</section>
</body>
</html>