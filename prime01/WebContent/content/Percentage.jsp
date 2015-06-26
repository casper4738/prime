<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<% request.setAttribute("status", request.getParameter("status")); %>

<logic:equal name="status" value='<%=Constants.Status.SUBMIT+""%>'>
	${param.percentage - 1}
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.REJECT+""%>'>
	${param.percentage - 1}
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.ABORT+""%>'>
	${param.percentage - 1}
</logic:equal>

<logic:notEqual name="status" value='<%=Constants.Status.SUBMIT+""%>'>
	<logic:notEqual name="status" value='<%=Constants.Status.REJECT+""%>'>
		<logic:notEqual name="status" value='<%=Constants.Status.ABORT+""%>'>
			${param.percentage}
		</logic:notEqual>
	</logic:notEqual>
</logic:notEqual>
%