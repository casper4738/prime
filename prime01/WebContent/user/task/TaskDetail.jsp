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
	<script>
	function flyToChangeStatusAct(task, activityId, activityChangeDate) {
		document.forms[0].task.value = task;
		document.forms[0].activityId.value = activityId;
		document.forms[0].activityChangeDate.value = activityChangeDate;
		document.forms[0].submit();
	}
	
	function flyToEditDeleteAct(task, activityId) {
		document.forms[0].task.value = task;
		document.forms[0].activityId.value = activityId;
		document.forms[0].submit();
	}
	
	</script>
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
	
		<jsp:include page="/content/Header.jsp"></jsp:include>
		
		<div class="content-wrapper">
			<section class="content-header">
				<h1>Task Subordinate
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Task & Activities</li>
				</ol>
			</section>

			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title-center">Data Task</h3></div>
					<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
					<tr><td>Task Name : <bean:write name="TaskUserForm" property="taskBean.taskId"/> </td>
						<td>Task Assigner : <bean:write name="TaskUserForm" property="taskBean.taskAssignerName" /> </td>
					</tr>
					<tr><td>Start Date : <bean:write name="TaskUserForm" property="taskBean.taskStartDate" format="dd MMMM yyyy"/> </td>
						<td>Task Receiver : <bean:write name="TaskUserForm" property="taskBean.taskReceiverName"/> </td>
					</tr><tr><td>Estimated Date : <bean:write name="TaskUserForm" property="taskBean.taskEstimateDate" format="dd MMMM yyyy" />
						</td><td>Status : </td>
					</tr>
					<tr><td colspan="2">Description : <bean:write name="TaskUserForm" property="taskBean.taskDescription" /> </td>
					</tr>
					</table>
					
					<p><span class="message"><bean:write name="TaskUserForm" property="message" /></span>
                    </p>
                   
                   	<div class="form-action">
					<table align="center">
	                   <tr>	<td style="padding:5px;">
	                   			<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')"/></td>
	                   		<td><input type="button" value="Submit" class="btn btn-sm  btn-primary" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/></td>
	                   </tr>
	                </table>
	                </div>
					
					<div class="show-in-page">
						Show per page
						<html:select name="TaskUserForm" property="showInPage" onchange="change(this.value)" >
							<html:option value="5">5</html:option>
							<html:option value="10">10</html:option>
							<html:option value="25">25</html:option>
							<html:option value="50">50</html:option>
						</html:select>
					</div>
					
					<div class="search-table">
						<html:form action="/TaskUser" >
							<html:hidden name="TaskUserForm" property="task"/>
							<html:hidden name="TaskUserForm" property="taskBean.taskId"/>
							<html:hidden name="TaskUserForm" property="taskId"/>
							<html:hidden name="TaskUserForm" property="activityId"/>
							<html:hidden name="TaskUserForm" property="activityChangeDate"/>
							<html:hidden name="TaskUserForm" property="goToPage"/>
							<html:hidden name="TaskUserForm" property="showInPage"/>
							<html:select name="TaskUserForm" property="columnSearch" styleClass="columnSearch">
								<html:option value="SHOW_ALL">SHOW ALL</html:option>
								<html:option value="NAME">ACTIVITY NAME</html:option>
							</html:select>
							<html:text name="TaskUserForm" property="search" styleClass="textSearch"/>
							<input type="submit" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOEDIT%>')" class="buttonSearch myButton" value='Search'>
						</html:form>
					</div>
					<div class="box-body">
						<table class="table table-bordered table-striped table-hover">
						<thead><tr>
							<th>Activity Name</th>
							<th>Description</th>
							<th>Activity Change Date</th>
							<th>Status</th>
		                    <th width="90px">Actions</th>
		                </tr></thead>
		                <tbody>
		                <logic:notEmpty name="listActivity">
							<logic:iterate id="iter" name="listActivity">
			                	<tr>
			                		<td width="250px"><bean:write name="iter" property="activityName"/></td>
			                		<td><bean:write name="iter" property="activityDescription"/></td>
			                		<td align="center" width="150px"><bean:write name="iter" property="activityChangeDate" format="dd MMMM yyyy hh:mm:ss"/></td>
			                		<td align="center" width="80px">
				                		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.CREATE+""%>'>
				                			<span class="label label-warning">Create</span>
				                		</logic:equal>
				                		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.SUBMIT+""%>'>
				                			<span class="label label-primary">Submit</span>
				                		</logic:equal>
				                		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.PAUSE+""%>'>
				                			<span class="label label-warning">Pause</span>
				                		</logic:equal>
				                		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.FINISH+""%>'>
				                			<span class="label label-primary">Finish</span>
				                		</logic:equal>
				                		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.ABORT+""%>'>
				                			<span class="label label-danger">Abort</span>
				                		</logic:equal>
				                		<logic:equal name="iter" property="activityStatus" value='<%=Constants.Status.PROGRESS+""%>'>
				                			<span class="label label-success">Progress</span>
				                		</logic:equal>
			                		</td>
			                		<td align="center">
			                        	<input type="image" onclick="flyToEditDeleteAct('<%=Constants.Task.ACTIVITY.GOTOEDIT%>', '<bean:write name="iter" property="activityId"/>')" src="resources/image/edit.png" />
			                        	<input type="image" onclick="flyToEditDeleteAct('<%=Constants.Task.ACTIVITY.DODELETE%>', '<bean:write name="iter" property="activityId"/>')" src="resources/image/remove.png" />
			                        	<input type="image" onclick="flyToChangeStatusAct('<%=Constants.Task.ACTIVITY.GOTOCHANGESTATUS%>', 
			                        	'<bean:write name="iter" property="activityId"/>',
			                        	'<bean:write name="iter" property="activityChangeDate" format="yyyy-MM-dd hh:mm:ss"/>'
			                        	)" src="resources/image/viewmore.png" />
			                        </td>	
			                    </tr> 
		                    </logic:iterate>
							</logic:notEmpty>
							<logic:empty name="listActivity">
								<tr>
									<td align="center" colspan="5">DATA KOSONG</td>
								</tr>
							</logic:empty>
	                   </tbody>
		            </table></div>
					<ul class="pagination">
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
						
						<div class="paginate-3">
							<html:text name="TaskUserForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
							<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
						</div>
					</ul>
					
					<div class="paginate-2">
						Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
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
	</script>
</body>
</html>