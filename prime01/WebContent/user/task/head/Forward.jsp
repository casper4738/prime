<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
</head>
<body>

<html:form action="/TaskHeadUser">
	<html:hidden name="TaskHeadUserForm" property="task"/>
	<html:hidden name="TaskHeadUserForm" property="message"/>
	<html:hidden name="TaskHeadUserForm" property="taskId"/>
</html:form>

<logic:equal name="TaskHeadUserForm" property="task" value="<%=Constants.Task.DOADD%>">
	<script>flyToForward('success', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>

<logic:equal name="TaskHeadUserForm" property="task" value="<%=Constants.Task.DOEDIT%>">
	<script>flyToForward('success', '<bean:message key="label.message.update"/>')</script>
</logic:equal>

<logic:equal name="TaskHeadUserForm" property="task" value="<%=Constants.Task.DODELETE%>">
	<script>flyToForward('success', '<bean:message key="label.message.delete"/>')</script>
</logic:equal>

<logic:equal name="TaskHeadUserForm" property="task" value="<%=Constants.Task.TASK.DOSUBMIT%>">
	<script>flyToForward('success', '<bean:message key="label.message.update"/>')</script>
</logic:equal>

<logic:equal name="TaskHeadUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOADD%>">
	<script>flyToForward('<%=Constants.Task.GOTOVIEW%>', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>

<logic:equal name="TaskHeadUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOEDIT%>">
	<script>flyToForward('<%=Constants.Task.GOTOVIEW%>', '<bean:message key="label.message.update"/>')</script>
</logic:equal>

<logic:equal name="TaskHeadUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DODELETE%>">
	<script>flyToForward('<%=Constants.Task.GOTOVIEW%>', '<bean:message key="label.message.delete"/>')</script>
</logic:equal>

<logic:equal name="TaskHeadUserForm" property="task" value="<%=Constants.Task.ACTIVITY.DOCHANGESTATUS%>">
	<script>flyToForward('<%=Constants.Task.GOTOVIEW%>', '<bean:message key="label.message.update"/>')</script>
</logic:equal>


</body>
</html>