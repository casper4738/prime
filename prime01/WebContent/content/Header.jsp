<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ page import="prime.user.notification.NotificationManagerImpl" %>
<%@ page import="prime.constants.Constants" %>
<%@ page import="prime.admin.employee.EmployeeBean" %>
<%@ page import="prime.admin.user.UserBean" %>
<%
	NotificationManagerImpl tmpManager = new NotificationManagerImpl();
	UserBean tmpUserData = (UserBean)request.getSession().getAttribute(Constants.Session.Userdata);
	EmployeeBean tmpEmpData = (EmployeeBean)request.getSession().getAttribute(Constants.Session.Employeedata);
%>
<script type="text/javascript">
function openModalHandler(task){
	//##0.Accessing Prime Method For Modal Showing
	modalLoadHandler("task=" + task);
}

function doSignOut(){
	menuLoadHandler('<%=Constants.PAGES_LIST[Constants.Page.LOGIN]%>', "task=<%=Constants.Task.DOLOGOUT%>");
}

function doViewAllNotif(){
	menuLoadHandler('<%=Constants.PAGES_LIST[Constants.Page.USER_VIEWNOTIF]%>');
}
</script>

<header class="main-header">
	<a href="#" class="logo"> <span class="logo-lg"><b>PRIME</b>PROGRAM</span></a>
	<nav class="navbar navbar-static-top" role="navigation">
		<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button"> 
			<span class="sr-only">Toggle navigation</span>
		</a>
		<% 
			int countNotif = tmpManager.getCountListNotifNoRead(tmpEmpData.getEmployeeId());
		%>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<li class="dropdown notifications-menu" id="notif-wrapper">
					
				</li>

				<li class="dropdown user user-menu"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <img
						id="profpic1" class="user-image"
						alt="User Image" /> <span class="hidden-xs"><%=tmpEmpData.getEmployeeName()%></span>
				</a>
					<ul class="dropdown-menu">
						<li class="user-header"><img
							id="profpic2" class="img-circle"
							alt="User Image" />
							<p>
								<%=tmpEmpData.getEmployeeName()%><small><%=tmpUserData.getSysName()%></small>
							</p></li>
						<li class="user-footer">
							<div class="pull-left">
						        <% if(!tmpUserData.getIsActiveDirectory()){%>
						         <input type="button" class="btn btn-block btn-default"  onclick="openModalHandler('changePwd')" value="Change Password"/>
						        <% } %>
							</div>
							<div class="pull-right">
								<input type="button" class="btn btn-block btn-default"  onclick="doSignOut()" value="Sign Out"/>
							</div>
						</li>
					</ul></li>
			</ul>
		</div>
	</nav>
</header>
