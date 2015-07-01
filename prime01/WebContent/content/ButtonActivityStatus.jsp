<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<bean:define id="status" value="${param.status}" toScope="request" />
<bean:define id="taskId" value="${param.taskId}" toScope="request" />
<bean:define id="activityId" value="${param.activityId}" toScope="request" />
<bean:define id="taskAssigner" value="${param.taskAssigner}" toScope="request" />
<bean:define id="taskReceiver" value="${param.taskReceiver}" toScope="request" />

<center>${employeeIdActive} |${taskAssigner}  | ${taskReceiver} | ${taskId} 
<br/>
${isAllFinished} | ${isAlreadySubmit} | ${isAlreadyReject}
</center>

<div class="form-action"><table align="center" class="btn-status-activity">
   <tr>	
   
   	<logic:equal name="taskReceiver" value="${employeeIdActive}">
		<logic:equal name="status" value='<%=Constants.Status.CREATE+""%>'>
			<td><input type="button" value="Start" class="btn btn-sm btn-primary" onclick="dosubmit('<%=Constants.Status.PROGRESS%>')"/></td>
			<td><input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doSubmitX('${activityId}', '${taskId}')"/></td>
		</logic:equal>
		<logic:equal name="status" value='<%=Constants.Status.PROGRESS+""%>'>
			<td><input type="button" value="Pause" class="btn btn-sm  btn-warning" onclick="dosubmit('<%=Constants.Status.PAUSE%>')"/></td>
			<td><input type="button" value="Finish" class="btn btn-sm  btn-success" onclick="dosubmit('<%=Constants.Status.FINISH%>')"/></td>
			<td><input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doSubmitX('${activityId}', '${taskId}')"/></td>
		</logic:equal>
		<logic:equal name="status" value='<%=Constants.Status.PAUSE+""%>'>
			<td><input type="button" value="Start" class="btn btn-sm btn-primary" onclick="dosubmit('<%=Constants.Status.PROGRESS%>')"/></td>
			<td><input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doSubmitX('${activityId}', '${taskId}')"/></td>
		</logic:equal>
		<logic:equal name="status" value="">
			<td><input type="button" value="Start" class="btn btn-sm btn-primary" onclick="dosubmit('<%=Constants.Status.PROGRESS%>')"/></td>
			<td><input type="button" value="Finish" class="btn btn-sm  btn-success" onclick="dosubmit('<%=Constants.Status.FINISH%>')"/></td>
			<td><input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doSubmitX('${activityId}', '${taskId}')"/></td>
		</logic:equal>
   	</logic:equal>
   
	</tr>
</table></div>