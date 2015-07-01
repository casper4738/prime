<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<!-- CSS -->
	<link href="resources/ionicons-2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
	<link href="resources/plugins/datatables/extensions/FixedColumns/css/dataTables.fixedColumns.min.css" rel="stylesheet" type="text/css" />
	<!-- End of CSS -->
	
	<!-- JS -->
    <script src="resources/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src='resources/plugins/fastclick/fastclick.min.js'></script>
    <script src="resources/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="resources/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
    <script src="resources/plugins/datatables/extensions/FixedColumns/js/dataTables.fixedColumns.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		function openModalHandler(tmpTask){
			var tmpTable ="activityList";
			
			//##1.Accessing Prime Method For Modal Showing
			modalLoadHandler("task=" + tmpTask + "&param1=" + tmpTable, $('#result'));
		}
		
		//##.Activity Detail
    	function activityDetail(task,activityId,status){
			document.getElementById('form-todolist').task.value = task;
			document.getElementById('form-todolist').tmpId.value = activityId;
			document.getElementById('form-todolist').tmpValue.value = status;
    		
			var str = $('#form-todolist').serialize();	
			 $.ajax({ 
	   	          type	  : "POST",
	   	          url	  : "<%=Constants.PAGES_LIST[Constants.Page.USER_DASHBOARD]%>",  // Send the login info to this page
	   	          data	  : str,
	   	          success : function(msg){
	   	        	  alert("Success");
	   	        	  loadActivityToDoList();
	   	          },
	   	          
	   	          error: function(){
					  //TO DO :: Do Some Error Handling at Here
	   	        	  alert("<%=Constants.Response.FAIL_DO%>");
	   	          }
	   	     });
    	}
	</script>
    <!-- End Of JS -->
</head>
<body class="skin-blue sidebar-mini">
	<html:form action="/DashboardUser" styleId="form-todolist"> 
		<html:hidden name="DashboardUserForm" property="task"/>
		<html:hidden name="DashboardUserForm" property="tmpId"/>
		<html:hidden name="DashboardUserForm" property="tmpValue"/>
		<html:hidden name="DashboardUserForm" property="goToPage"/>
		
		<div class="box box-primary">
			<div class="box-header">
				<i class="ion ion-clipboard"></i>
				<h3 class="box-title">To Do List Activity</h3>
				<div class="box-tools pull-right">
					<!-- Paging -->
					<ul class="pagination pagination-sm inline">
						<li tabindex="0"><html:link styleClass="paging" href="#" onclick="page(${pageFirst})">First</html:link></li>
						<li tabindex="1"><html:link styleClass="paging" href="#" onclick="page(${pagePrev})"><<</html:link> </li>
						<logic:iterate id="p" name="listPage">
						 	<logic:equal name="p" value="${pageNow}">
								<li><html:link styleClass="active" href="#">${p}</html:link> </li>
							</logic:equal>
							<logic:notEqual name="p" value="${pageNow}">
								<li><html:link styleClass="paging" href="#" onclick="page(${p})">${p}</html:link> </li>
							</logic:notEqual>
						</logic:iterate>
						<li><html:link styleClass="paging" href="#" onclick="page(${pageNext})" >>></html:link> </li>
						<li><html:link styleClass="paging" href="#" onclick="page(${pageLast})" >Last</html:link></li>
					</ul>
					<!-- End of Paging -->
				</div>
			</div>
			<!-- /.box-header -->
			<div class="box-body">
				<ul class="todo-list">
						<!-- todolist -->
						<logic:notEmpty name="listActivity">
							<logic:iterate id="iter" name="listActivity">
								<li>
									<span class="handle"> 
										<i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
									</span>	
		                			<span class="text"><bean:write name="iter" property="activityName"/> | <bean:write name="iter" property="taskName"/> </span>
		                   
				                    <!-- General tools such as play or pause or finish or delete-->
				                    <div class="tools">
										<logic:notEqual name="iter" property="activityStatus" value="1">
											<i class="fa fa-play" onclick="activityDetail('addActivity','<bean:write name="iter" property="activityId"/>','1')"></i>
										</logic:notEqual>
										<logic:equal name="iter" property="activityStatus" value="1">
											<i class="fa fa-pause" onclick="activityDetail('pauseActivity','<bean:write name="iter" property="activityId"/>','2')"></i> 
										</logic:equal>
										<logic:equal name="iter" property="activityStatus" value="1">
											<i class="fa fa-check" onclick="activityDetail('finishActivity','<bean:write name="iter" property="activityId"/>','4')"></i>
										</logic:equal>
										<logic:notEqual name="iter" property="activityStatus" value="1">	
											<i class="fa fa-trash-o" onclick="activityDetail('delete','<bean:write name="iter" property="activityId"/>')"></i>
										</logic:notEqual>
									</div>
								</li>
							 </logic:iterate>
						</logic:notEmpty>
						<logic:empty name="listActivity">
							<span class="handle"> 
								<i class="fa fa-ellipsis-v"></i> <i class="fa fa-ellipsis-v"></i>
							</span>	
							<span class="text">No List Activity</span>
						</logic:empty>
					
				</ul>
			</div>
			<!-- /.box-body -->
			<div class="box-footer clearfix no-border">
				<input type="button" class="btn btn-default pull-right" onClick="openModalHandler('modalTable')" value="Add Item"></input>
			</div>
		</div>
	</html:form>	
</body>
</html>