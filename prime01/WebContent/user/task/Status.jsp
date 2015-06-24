<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<% request.setAttribute("status", request.getParameter("status")); %>

<logic:equal name="status" value='<%=Constants.Status.CREATE+""%>'>
	<span class="label label-warning">Receive</span>
</logic:equal>
<logic:equal name="status" value='<%=Constants.Status.SUBMIT+""%>'>
	<span class="label label-primary">Submit</span>
</logic:equal>
<logic:equal name="status" value='<%=Constants.Status.PAUSE+""%>'>
	<span class="label label-warning">Pause</span>
</logic:equal>
<logic:equal name="status" value='<%=Constants.Status.FINISH+""%>'>
	<span class="label label-primary">Finish</span>
</logic:equal>
<logic:equal name="status" value='<%=Constants.Status.ABORT+""%>'>
	<span class="label label-danger">Abort</span>
</logic:equal>
<logic:equal name="status" value='<%=Constants.Status.PROGRESS+""%>'>
	<span class="label label-success">Progress</span>
</logic:equal>
		    