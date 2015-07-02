<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html> 
<head> 
	<link href="resources/plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
	<script src="resources/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function () {
            $('#startDate').datepicker({
                format: "yyyy-mm-dd"
            });  
            $('#estimateDate').datepicker({
                format: "yyyy-mm-dd"
            });
        });
		
		function doback() {
			var tmpForm = document.forms[0];
			tmpForm.task.value = "<%=Constants.Task.TASK.GOTOTASKTYPE%>";
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function docancel() {
			var tmpForm = document.forms[0];
			tmpForm.task.value = "success";
			menuLoadHandler(tmpForm.action, serialize(tmpForm));
		}
		
		function checkDays(){
		 	$('#mainDays').html("<i class=\"fa fa-refresh fa-spin\"></i> Checking ");
		  	$('#mainDays').show();
			$.ajax({ 
		          type	  : "POST",
		          url	  : '<%=Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]%>',  
		          data	  : 'task=<%=Constants.Task.DOVALIDATE1%>&taskBean.taskReceiver='+$('#taskReceiver').val()+'&taskBean.taskStartDate='+ $('#startDate').val()+'&taskBean.taskEstimateDate='+ $('#estimateDate').val(),
		          success : function(msg){
	        		  $('#mainDays').html(msg);
		          },
		          
		          error: function(){
		        	  //TO DO :: Add Error Handling
		          }
		       });
		}
		
		function validateForm() {
			var taskName 		= checkNull($('#taskName'), $('#err-taskName'), "Task Name");
			var taskAssigner 	= checkNull($('#taskAssigner'), $('#err-taskAssigner'), "Task Assigner");
			var taskReceiver	= checkNull($('#taskReceiver'), $('#err-taskReceiver'), "Task Receiver");
			var startDate = checkNull($('#startDate'), $('#err-startDate'), "Project Start Date");
			var estimateDate = checkNull($('#estimateDate'), $('#err-estimateDate'), "Project Estimate Date");
			var checkDate = checkForDate($('#startDate'), $('#estimateDate'), $('#err-startDate'), $('#err-estimateDate'), "Project Start Date", "Project Estimate Date");
			
			if(taskName || taskAssigner || taskReceiver || startDate || estimateDate || checkDate) {
				//alert("error lho");
			} else {
				dosubmit();
			}
			
		}
    </script>
</head>
<body class="skin-blue sidebar-mini">
	<section class="content-header">
		<h1>Manage Tasks<small> As Head</small></h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><html:link href="#" onclick="flyToBack('home')">Tasks & Activities</html:link></li>
			<li class="active">Add Task</li>
		</ol>
	</section>

	<section class="content">
	<div class="row">
		<div class="col-xs-12"><div class="box">
			<div class="box-header"><h3 class="box-title-center">Add New Task</h3></div>
			<div class="box-body">
                	<html:form action="/TaskHeadUser">
                		<html:hidden name="TaskHeadUserForm" property="task" value="<%=Constants.Task.DOADD%>"/>
                		<html:hidden name="TaskHeadUserForm" property="taskBean.taskAssigner" />
                		<html:hidden name="TaskHeadUserForm" property="taskBean.taskReceiver" />
                		<table class="form-input" align="center" style="width:60%">
                			<tr>
                				<td width="150px">Task Name ${TaskHeadUserForm.taskBean.taskAssigner} | ${TaskHeadUserForm.taskBean.taskReceiver}</td>
                				<td>:</td>
                				<td><html:text name="TaskHeadUserForm" property="taskBean.taskName" styleClass="form-control" styleId="taskName"/></td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-taskName" class="error-validator"></span></td>
                			</tr>
                			<tr>
                				<td>Task Assigner</td>
                				<td>:</td>
                				<td><html:text name="TaskHeadUserForm"  property="taskBean.taskAssignerName" styleClass="form-control" styleId="taskAssigner" disabled="true"/></td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-taskAssigner" class="error-validator"></span></td>
                			</tr>
               				<tr>
                				<td>Task Receiver</td>
                				<td>:</td>
                				<td><html:text name="TaskHeadUserForm" property="taskBean.taskReceiverName" styleClass="form-control" styleId="taskReceiver" disabled="true" /></td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-taskReceiver" class="error-validator"></span></td>
                			</tr>
               				<tr>
                				<td>Start Date</td>
                				<td>:</td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                				  	<html:text name="TaskHeadUserForm" property="taskBean.taskStartDate" styleClass="form-control pull-right" styleId="startDate" onchange="checkDays()"/>
                				  	</div>
                				</td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-startDate" class="error-validator"></span></td>
                			</tr>
                			<tr>
                				<td>Estimate Date</td>
                				<td>:</td>
                				<td><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                				  	<html:text name="TaskHeadUserForm" property="taskBean.taskEstimateDate" styleClass="form-control pull-right" styleId="estimateDate" onchange="checkDays()"/>
                				  	</div>
                				</td>
                			</tr>
                			<tr><td></td>
                				<td></td>
                				<td><span id="err-estimateDate" class="error-validator"></span></td>
                			</tr>
                			<tr>
                				<td></td>
                				<td></td>
                				<td><span id="mainDays" style="color: blue;font-size: 8;font-style: normal;"></span></td>
                			</tr>
                			<tr>
                				<td>Description</td>
                				<td>:</td>
                				<td><html:textarea name="TaskHeadUserForm" property="taskBean.taskDescription" styleClass="form-control" rows="5"/></td>
                			</tr>
                			<tr>
                				<td colspan="3" align="center">
                					<html:button property="" value="Save" styleClass="btn btn-primary" onclick="validateForm()"/>
                					<html:button property="" value="Cancel" styleClass="btn btn-default" onclick="docancel()"/>
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