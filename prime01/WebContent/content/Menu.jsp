<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<ul class="sidebar-menu">
	<li class="header">MAIN MENU</li>
	<li><html:link action="DashboardAdmin" ><i class="fa fa-dashboard"></i><span>Dashboard</span></html:link></li>
	<li><html:link action="UserAdmin" ><i class="fa fa-table"></i><span>Manage User</span></html:link></li>
	<li><html:link href="#" ><i class="fa fa-table"></i><span>Manage Employee</span></html:link></li>
	<li><html:link action="DivisionAdmin" ><i class="fa fa-table"></i><span>Manage Division</span></html:link></li>
	<li><html:link href="#" ><i class="fa fa-table"></i><span>Manage Position</span></html:link></li>
	<li><html:link href="#" ><i class="fa fa-table"></i><span>Manage Role</span></html:link></li>
	<li><html:link href="#" ><i class="fa fa-table"></i><span>Manage Holidays</span></html:link></li>
	<li><html:link href="#" ><i class="fa fa-table"></i><span>View Log</span></html:link></li>
	<li><html:link href="#" ><i class="fa fa-table"></i><span>General Setting</span></html:link></li>
</ul>