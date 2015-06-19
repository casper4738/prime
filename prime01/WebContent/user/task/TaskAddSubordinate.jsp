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
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
	
		<jsp:include page="/content/Header.jsp"></jsp:include>
		<div class="content-wrapper">
			<section class="content-header">
				<h1>Add Task<small>subordinate</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Tasks & Activities</li>
				</ol>
			</section>

			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title">Add New Task</h3></div>
					<div class="box-body">
                  	<html:form action="/TaskUser">
                  		<html:hidden name="TaskUserForm" property="task" value="insert"/>
                  		<html:hidden name="TaskUserForm" property="taskBean.taskId" />
                  		<table class="form-input" align="center">
                  			<tr>
                  				<td>Task Name</td>
                  				<td>:</td>
                  				<td>
                  				<td><html:text name="TaskUserForm" property="taskBean.taskName" styleClass="form-control"/></td>
                  			</td>
                  			</tr>
                  			<tr>
                  				<td>Task Assigner</td>
                  				<td>:</td>
                  				<td>
                  				<td><html:text name="TaskUserForm" property="taskBean.taskAssigner" styleClass="form-control"/></td>
								</td>
                  			</tr>
                  				<tr>
                  				<td>Task Receiver</td>
                  				<td>:</td>
                  				<td>
                  				<td><html:text name="TaskUserForm" property="taskBean.taskReceiver" styleClass="form-control"/></td>
								</td>
                  			</tr>
                  				<tr>
                  				<td>Start Date</td>
                  				<td>:</td>
                  				<td>
                  				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                  				  	<html:text name="TaskUserForm" property="taskBean.taskStartDate" styleClass="form-control pull-right" styleId="datepicker"/>
                  				  	</div>
                  				</td>
								</td>
								
                  			</tr>
                  			<tr>
                  				<td>Estimate Date</td>
                  				<td>:</td>
                  				<td>
                  				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                  				  	<html:text name="TaskUserForm" property="taskBean.taskEstimateDate" styleClass="form-control pull-right" styleId="datepicker2"/>
                  				  	</div>
                  				</td>
							
								
                  			</tr>
                  			<tr>
                  				<td>Description</td>
                  				<td>:</td>
                  				<td>
                  				<td><html:text name="TaskUserForm" property="taskBean.taskDescription" styleClass="form-control"/></td>
								</td>
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
 	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="resources/plugins/fastclick/fastclick.min.js"></script>
	<script src="resources/dist/js/app.min.js" type="text/javascript"></script>
	<script src="resources/dist/js/demo.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#datepicker').datepicker({
                format: "yyyy-mm-dd"
            });  
            $('#datepicker2').datepicker({
                format: "yyyy-mm-dd"
            });
        });
    </script>
</body>
</html>