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

<html:form action="/ProjectUser">
	<html:hidden name="ProjectUserForm" property="task"/>
	<html:hidden name="ProjectUserForm" property="message"/>
	<html:hidden name="ProjectUserForm" property="projectId"/>
	<html:hidden name="ProjectUserForm" property="employeeId"/>
</html:form>

<logic:equal name="ProjectUserForm" property="task" value="<%=Constants.Task.Project.DOCREATETASK%>">
	<script>flyToForward('<%=Constants.Task.Project.GOTOTASKMEMBER%>', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>

<logic:equal name="ProjectUserForm" property="task" value="<%=Constants.Task.Project.DOCREATEMEMBER%>">
	<script>flyToForward('<%=Constants.Task.Project.GOTOPROJECTDETAIL%>', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>


</body>
</html>