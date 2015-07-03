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

<html:form action="/ProjectUserAsHead">
	<html:hidden name="ProjectUserFormAsHead" property="task"/>
	<html:hidden name="ProjectUserFormAsHead" property="message"/>
	<html:hidden name="ProjectUserFormAsHead" property="projectId"/>
	<html:hidden name="ProjectUserFormAsHead" property="employeeId"/>
</html:form>

<logic:equal name="ProjectUserFormAsHead" property="task" value="<%=Constants.Task.PROJECT.DOCREATETASK%>">
	<script>flyToForward('<%=Constants.Task.PROJECT.GOTOTASKMEMBER%>', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>

<logic:equal name="ProjectUserFormAsHead" property="task" value="<%=Constants.Task.PROJECT.DOCREATEMEMBER%>">
	<script>flyToForward('<%=Constants.Task.PROJECT.GOTOPROJECTDETAIL%>', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>


<logic:equal name="ProjectUserFormAsHead" property="task" value="<%=Constants.Task.PROJECT.DOEDITMEMBER%>">
	<script>flyToForward('<%=Constants.Task.PROJECT.GOTOPROJECTDETAIL%>', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>
<logic:equal name="ProjectUserFormAsHead" property="task" value="<%=Constants.Task.DOADD%>">
	<script>flyToForward('<%=Constants.PAGES_LIST[Constants.Page.USER_PROJECT_HEAD]%>', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>


</body>
</html>