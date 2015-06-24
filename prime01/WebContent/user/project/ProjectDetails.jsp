<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>Prime</title>
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
			info	  : false
	    } );
	</script>
	<!-- End JS -->
	<script>
	function flyToChangeStatusAct(task, projectMemberId, activityChangeDate) {
		document.forms[0].task.value = task;
		document.forms[0].projectMemberId.value = projectMemberId;
		document.forms[0].activityChangeDate.value = activityChangeDate;
		document.forms[0].submit();
	}
	
	function flyToEditDeleteAct(task, projectMemberId) {
		document.forms[0].task.value = task;
		document.forms[0].projectMemberId.value = projectMemberId;
		document.forms[0].submit();
	}
	
	function flyToTaskDetail(task, valueMember) {
		alert(valueMember)
		var tmpForm = document.forms[0]; 
		tmpForm.task.value = task;
		tmpForm.employeeId.value = valueMember;
		
		menuLoadHandler(tmpForm.action, serialize(tmpForm));
		//document.forms[0].submit();
	}
	</script>
</head>
<body class="skin-blue sidebar-mini">
	
		
		
			<section class="content-header">
				<h1>Project User</h1>
				<ol class="breadcrumb">
					<li><i class="fa fa-dashboard"></i> Home</li>
					<li class="active">Project</li>
				</ol>
			</section>

			<section class="content">
			<div class="row">
				<div class="col-xs-12"><div class="box">
					<div class="box-header"><h3 class="box-title-center">Data Project Member</h3></div>
					<table class="table table-bordered table-striped table-hover" style="width:98%" align="center">
					<tr><td>Project Name : <bean:write name="ProjectUserForm" property="projectBean.projectName"/> </td>
						<td>Project Assigner : <bean:write name="ProjectUserForm" property="projectBean.projectAssigner" /> </td>
					</tr>
					<tr><td>Start Date : <bean:write name="ProjectUserForm" property="projectBean.projectStartDate" format="dd MMMM yyyy"/> </td>
						<td>Project Receiver : <bean:write name="ProjectUserForm" property="projectBean.projectReceiver"/> </td>
					</tr><tr><td>Estimated Date : <bean:write name="ProjectUserForm" property="projectBean.projectEstimateDate" format="dd MMMM yyyy" />
						</td><td>Status : <bean:write name="ProjectUserForm" property="projectBean.projectStatus"/> </td>
					</tr>
					<tr><td colspan="2">Description : <bean:write name="ProjectUserForm" property="projectBean.projectDescription" /> </td>
					</tr>
					</table>
					
					<p><span class="message"><bean:write name="ProjectUserForm" property="message" /></span>
                    </p>
                   
                   	<div class="form-action">
					<table align="center">
	                   <tr>	<td style="padding:5px;">
	                   			<input type="button" value="Add New Project Member" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')"/></td>
	                   		<td><input type="button" value="Submit" class="btn btn-sm  btn-primary" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/></td>
	                   </tr>
	                </table>
	                </div>
					
					<div class="show-in-page">
						Show per page
						<html:select name="ProjectUserForm" property="showInPage" onchange="change(this.value)" >
							<html:option value="5">5</html:option>
							<html:option value="10">10</html:option>
							<html:option value="25">25</html:option>
							<html:option value="50">50</html:option>
						</html:select>
					</div>
					
					<div class="search-table">
						<html:form action="/ProjectUser" >
							<html:hidden name="ProjectUserForm" property="task"/>
							<html:hidden name="ProjectUserForm" property="projectBean.projectId"/>
							<html:hidden name="ProjectUserForm" property="projectId"/>
							<html:hidden name="ProjectUserForm" property="projectMemberId"/>
							<html:hidden name="ProjectUserForm" property="roleId"/>
							<html:hidden name="ProjectUserForm" property="employeeId"/>
							<html:hidden name="ProjectUserForm" property="goToPage"/>
							<html:hidden name="ProjectUserForm" property="showInPage"/>
							<html:select name="ProjectUserForm" property="columnSearch" styleClass="columnSearch">
								<html:option value="SHOW_ALL">SHOW ALL</html:option>
								<html:option value="NAME">ACTIVITY NAME</html:option>
							</html:select>
							<html:text name="ProjectUserForm" property="search" styleClass="textSearch"/>
							<input type="submit" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOEDIT%>')" class="buttonSearch myButton" value='Search'>
						</html:form>
					</div>
					<div class="box-body">
						<table class="table table-bordered table-striped table-hover">
						<thead><tr>
							<th>Employee Name</th>
							<th>Role</th>
							<th>Division</th>
							<th>Email</th>
							<th>Phone Number</th>
		                    <th width="90px">Actions</th>
		                </tr></thead>
		                <tbody>
		                <logic:notEmpty name="listProjectMember">
							<logic:iterate id="iter" name="listProjectMember">
			                	<tr>
			                		<td width="250px"><bean:write name="iter" property="employeeName"/></td>
			                		<td><bean:write name="iter" property="roleName"/></td>
			                		<td align="center" width="150px"><bean:write name="iter" property="divisionName" /></td>
			                		
			                		<td><bean:write name="iter" property="email"/></td>
			                		<td><bean:write name="iter" property="contactNumber"/></td>
			                		<td align="center">
			                        	<input type="image" onclick="flyToEditDeleteAct('<%=Constants.Task.ACTIVITY.GOTOEDIT%>', '<bean:write name="iter" property="projectMemberId"/>')" src="resources/image/edit.png" />
			                        	<input type="image" onclick="flyToEditDeleteAct('<%=Constants.Task.ACTIVITY.DODELETE%>', '<bean:write name="iter" property="projectMemberId"/>')" src="resources/image/remove.png" />
                       	        		<input type="image" onclick="flyToChangeStatusAct()" src="resources/image/viewmore.png" />
                       	        		<input type="submit" class="btn btn-primary btn-xs" value='Details' onclick="flyToTaskDetail('memberDetails', '<bean:write name="iter" property="employeeId"/>')">
			                        </td>	
			                    </tr> 
		                    </logic:iterate>
							</logic:notEmpty>
							<logic:empty name="listProjectMember">
								<tr>
									<td align="center" colspan="6">DATA KOSONG</td>
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
							<html:text name="ProjectUserForm" property="goToPage" size="5" styleId="page" styleClass="go-to-page"/>
							<html:button property="" onclick="page(-1)" value="GO" styleClass="btn btn-default btn-sm btn-go-page"/>
						</div>
					</ul>
					
					<div class="paginate-2">
						Total Record Data <bean:write name="totalData" />, Page <bean:write name="pageNow" /> of <bean:write name="pageLast" />
					</div>
		        </div>
			</section>
	
		<!-- /.content-wrapper -->
	
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