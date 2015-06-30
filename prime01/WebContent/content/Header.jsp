<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ page import="prime.user.notification.NotificationManagerImpl" %>
<%@ page import="prime.constants.Constants" %>
<<<<<<< HEAD
<%@ page import="prime.login.LoginData" %>
=======
>>>>>>> branch 'master' of https://github.com/casper4738/prime.git
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
			NotificationManagerImpl tmpManager = new NotificationManagerImpl();
			int countNotif = tmpManager.getCountListNotifNoRead(LoginData.getEmployeeData().getEmployeeId());
		%>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<li class="dropdown notifications-menu"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <i
						class="fa fa-bell-o"></i> <span class="label label-warning"><%=countNotif%></span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have <%=countNotif%> notifications</li>
						<li>
							<!-- inner menu: contains the actual data -->
							<ul class="menu">
								<%
									for(int i=0;i<tmpManager.getListNotifNoRead(LoginData.getEmployeeData().getEmployeeId()).size();i++){
								%>
										<li><a href="#"> <i class="fa fa-warning text-yellow"></i>
											<%=tmpManager.getListNotifNoRead(LoginData.getEmployeeData().getEmployeeId()).get(i).getNotificationNote()%>
										</a></li>
								<%		
									}
								%>
								<!-- <li><a href="#"> <i class="fa fa-users text-aqua"></i>
										5 new members joined today
								</a></li>
								<li><a href="#"> <i class="fa fa-warning text-yellow"></i>
										Very long description here that may not fit into the page and
										may cause design problems
								</a></li>
								<li><a href="#"> <i class="fa fa-users text-red"></i> 5
										new members joined
								</a></li>

								<li><a href="#"> <i
										class="fa fa-shopping-cart text-green"></i> 25 sales made
								</a></li>
								<li><a href="#"> <i class="fa fa-user text-red"></i>
										You changed your username
								</a></li> -->
							</ul>
						</li>
						<li class="footer"><html:link styleClass="paging" href="#" onclick="doViewAllNotif()">View all</html:link></li>
					</ul></li>

				<li class="dropdown user user-menu"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <img
						id="profpic1" class="user-image"
						alt="User Image" /> <span class="hidden-xs"><%=LoginData.getEmployeeData().getEmployeeName()%></span>
				</a>
					<ul class="dropdown-menu">
						<li class="user-header"><img
							id="profpic2" class="img-circle"
							alt="User Image" />
							<p>
								<%=LoginData.getEmployeeData().getEmployeeName()%><small><%=LoginData.getUserData().getSysLevel()%></small>
							</p></li>
						<li class="user-footer">
							<div class="pull-left">
								<input type="button" class="btn btn-block btn-default"  onclick="openModalHandler('changePwd')" value="Change Password"/>
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
