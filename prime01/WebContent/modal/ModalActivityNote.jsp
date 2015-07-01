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
			language  : {
		       "emptyTable":  "<center><%=Constants.Response.TABLE_EMPTY %></center>"
		    }
	    } );
		
		/* Method Specified For Modal Handling */
		
		function modalFlyToPage(task) {
			var tmpForm = document.forms[0];
			tmpForm.task.value = task;
			modalLoadHandler(serialize(tmpForm));
		}
		
		function modalPage(page) {
			var tmpForm = document.forms[0]; 
			if(page == -1) {
				tmpForm.goToPage.value = document.getElementById('page').value;
			} else {
				tmpForm.goToPage.value = page;			
			}
			modalLoadHandler(serialize(tmpForm));
		}
		
		function modalSelectHandler(retValue,retForm){
			modalSubmitReturnValue(retValue,retForm);
		}
		
		function submitHandler(){
			var tmpForm = document.getElementById("currentForm");
			var tmpRetData = serialize(tmpForm);
			var tmpRetAction = tmpForm.action;
			
			document.forms[0].task.value = "<%=Constants.Task.GOTOVIEW%>";
			var tmpTargetData = serialize(document.forms[0]);
			var tmpTargetAction = "<%=Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]%>";
		
			modalSubmitRefreshPageWithoutReturn(tmpRetData, tmpRetAction, tmpTargetData, tmpTargetAction);
			
<%-- 			modalSubmitRefreshPageAndWithoutReturn("task=<%=Constants.Task.ACTIVITY.DOCHANGESTATUS%>&activityBean.activityStatus=<%=Constants.Status.ABORT%>&activityBean.activityChangeNote=" + tmpNote + "&activityBean.activityId=" + id, "<%=Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]%>"); --%>
		}
	</script>
	<!-- End JS -->
</head>
<body class="skin-blue sidebar-mini">
	<section class="content">
       	<html:form action="/TaskHeadUser" styleId="currentForm">
       		<html:hidden name="TaskHeadUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOCHANGESTATUS%>"/>
       		<html:hidden name="TaskHeadUserForm" property="activityBean.activityId" value="${activityId}"/>
       		<html:hidden name="TaskHeadUserForm" property="activityStatus" value='<%=Constants.Status.ABORT+""%>'/>
       		<html:hidden name="TaskHeadUserForm" property="taskId" value='${taskId}'/>
       		<table class="form-input" align="center" style="width:60%">
       			<tr><td>Note</td></tr>
       			<tr><td><html:textarea name="TaskHeadUserForm" property="activityBean.activityChangeNote" styleClass="form-control" rows="8"/></td></tr>
       		</table>
       		
       		<center>
	           <input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="submitHandler()"/>
       		</center>
        </html:form>  	
	</section>
</body>
</html>