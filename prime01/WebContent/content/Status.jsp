<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<bean:define id="status" value="${param.status}" toScope="request" />

<logic:equal name="status" value='<%=Constants.Status.CREATE+""%>'>
	<span class="label label-warning">Create</span>
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.PROGRESS+""%>'>
	<span class="label label-success">Progress</span>
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.PAUSE+""%>'>
	<span class="label label-warning">Pause</span>
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.SUBMIT+""%>'>
	<span class="label label-info">Submit</span>
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.FINISH+""%>'>
	<span class="label label-primary">Finish</span>
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.ABORT+""%>'>
	<span class="label label-danger">Abort</span>
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.REJECT+""%>'>
	<span class="label label-danger">Reject</span>
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.APPROVAL+""%>'>
	<span class="label label-success">Approval</span>
</logic:equal>
		    
