<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<bean:define id="status" value="${param.status}" toScope="request" />

<logic:equal name="status" value='<%=Constants.Status.SUBMIT+""%>'>
	${param.percentage - 1}
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.REJECT+""%>'>
	${param.percentage - 1}
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.ABORT+""%>'>
	${param.percentage}
</logic:equal>

<logic:equal name="status" value='<%=Constants.Status.APPROVAL+""%>'>
	${param.percentage}
</logic:equal>

<logic:notEqual name="status" value='<%=Constants.Status.SUBMIT+""%>'>
	<logic:notEqual name="status" value='<%=Constants.Status.REJECT+""%>'>
		<logic:notEqual name="status" value='<%=Constants.Status.APPROVAL+""%>'>
			<logic:notEqual name="status" value='<%=Constants.Status.ABORT+""%>'>
				<bean:define id="percentage" value="${param.percentage}" toScope="request" />
				<logic:equal name="percentage" value="0">
					${percentage}
				</logic:equal>
				<logic:notEqual name="percentage" value="0">
					 <logic:equal name="percentage" value="100">
				     	 ${percentage - 1}
				     </logic:equal>
				     <logic:notEqual name="percentage" value="100">
				     	 ${percentage}
				     </logic:notEqual>
				</logic:notEqual>
			</logic:notEqual>
		</logic:notEqual>
	</logic:notEqual>
</logic:notEqual>
%