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
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
	
		<jsp:include page="/content/Header.jsp"></jsp:include>
		<div class="content-wrapper">
			<section class="content-header">
				<h1>Add Activity
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Tasks & Activities</li>
				</ol>
			</section>

			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title-center">Add New Activity</h3></div>
					<div class="box-body">
                  	<html:form action="/TaskUser">
                  		<html:hidden name="TaskUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOADD%>"/>
                  		<html:hidden name="TaskUserForm" property="activityBean.activityId" />
                  		<html:hidden name="TaskUserForm" property="activityBean.taskId" />
                  		<html:hidden name="TaskUserForm" property="activityBean.activityStatus" />
                  		<html:hidden name="TaskUserForm" property="activityBean.activityChangeNote" />
                  		<table class="form-input" align="center" style="width:60%">
                  			<tr>
                  				<td width="150px">Activity Name</td>
                  				<td>: </td>
                  				<td>
                  				<td><html:text name="TaskUserForm" property="activityBean.activityName" styleClass="form-control"/></td>
                  			</tr>
                  			
                  			<tr>
                  				<td>Description</td>
                  				<td>:</td>
                  				<td>
                  				<td><html:textarea name="TaskUserForm" property="activityBean.activityDescription" styleClass="form-control" rows="5"/></td>
                  			</tr>
                  			<tr>
                  				<td colspan="6" align="center">
                  					<html:submit value="Save" styleClass="btn btn-primary"/>
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