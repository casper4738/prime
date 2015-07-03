<%@page import="prime.admin.employee.EmployeeBean"%>
<%@page import="prime.admin.employee.EmployeeManagerImpl"%>
<%@page import="prime.admin.employee.EmployeeManager"%>
<%@page import="prime.constants.Constants"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<bean:define id="taskId" value="${param.taskId}" toScope="request" />
<bean:define id="taskAssigner" value="${param.taskAssigner}" toScope="request" />
<bean:define id="taskReceiver" value="${param.taskReceiver}" toScope="request" />
<bean:define id="projectMemberId" value="${param.projectMemberId}" toScope="request" />
<%-- 
<center>${employeeIdActive} |${taskAssigner}  | ${taskReceiver} | ${taskId} | ${projectMemberId } - 
<br/>
${isAllFinished} | ${isAlreadySubmit} | ${isAlreadyReject} | ${isAlreadyApprove} 
</center>
<br/>
 --%>
<div class="form-action"><table align="center">
   <tr> <td style="padding:5px;">
		<logic:equal name="taskReceiver" value="${employeeIdActive}">
			<!-- submit != true -->
			<logic:notEqual name="isAlreadySubmit" value="true">
				<!-- finish == true -->
				<logic:equal name="isAllFinished" value="true">
						<!-- approve != true -->
						<logic:notEqual name="isAlreadyApprove" value="true">
			     			<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
							<%
							EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
							EmployeeBean e = tmpEmployeeManager.getEmployeeById(Integer.parseInt(request.getAttribute("employeeIdActive").toString()));
							if(e.getManagerId() == null || e.getManagerId() == 0) {
							%>
								<input type="button" value="Finish" class="btn btn-sm  btn-success" onclick="doTaskApp('<%=Constants.Task.TASK.DOAPPROVAL%>', '${taskId}', '${employeeIdActive}', '${taskReceiver}', 'self')"/>
			     			<% } else { %>
				     			<input type="button" value="Submit" class="btn btn-sm  btn-primary" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/>
			     			<% } %>
						</logic:notEqual>
						<!-- end approve != true -->
	    		</logic:equal>
				<!-- end finish == true -->
	    		
				<!-- finish != true -->
	    		<logic:notEqual name="isAllFinished" value="true">
	     			<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
	    		</logic:notEqual>
				<!-- end finish != true -->
	    		
    		</logic:notEqual>
			<!-- end submit != true -->
    		
			<!-- reject == true -->
    		<logic:equal name="isAlreadyReject" value="true">
				<!-- assigner != true -->
    			<logic:notEqual name="taskAssigner" value="${employeeIdActive}">
	     			<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
	     			<input type="button" value="Submit" class="btn btn-sm  btn-primary" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/>
	    		</logic:notEqual>
				<!-- end assigner != true -->
    		</logic:equal>
			<!-- end reject == true -->
		</logic:equal>
		
		<logic:equal name="taskAssigner" value="${employeeIdActive}">
			<logic:notEqual name="taskReceiver" value="${employeeIdActive}">
				<!-- submit != true -->
				<logic:equal name="isAlreadySubmit" value="true">
	     			<input type="button" value="Approve" class="btn btn-sm  btn-success" onclick="doTaskApp('<%=Constants.Task.TASK.DOAPPROVAL%>', '${taskId}', '${employeeIdActive}', '${taskReceiver}')"/>
	    			<input type="button" value="Reject" class="btn btn-sm  btn-primary" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOREJECT%>', '${employeeIdActive}', '${taskReceiver}')"/>
	    		</logic:equal>
				<!-- end submit != true -->

				<!-- reject != true -->
	    		<logic:equal name="isAlreadyReject" value="true">
	     			<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', , '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/>
	    		</logic:equal>
				<!-- end reject != true -->
			</logic:notEqual>
		</logic:equal>
		
		<logic:notEqual name="taskReceiver" value="${employeeIdActive}">
			<logic:notEqual name="taskAssigner" value="${employeeIdActive}">
				<!-- submit != true -->
				<logic:equal name="isAlreadySubmit" value="true">
					
					<!-- projectMemberId != null -->
					<logic:empty name="projectMemberId">
						<input type="button" value="Approve" class="btn btn-sm  btn-success" onclick="doTaskApp('<%=Constants.Task.TASK.DOAPPROVAL%>', '${taskId}', '${employeeIdActive}', '${taskReceiver}')"/>
			     		<input type="button" value="Reject" class="btn btn-sm  btn-primary" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOREJECT%>', '${employeeIdActive}', '${taskReceiver}')"/>
					</logic:empty>
					<!-- end projectMemberId != null -->
				
	     			<%-- <input type="button" value="Approve" class="btn btn-sm  btn-success" onclick="doTaskApp('<%=Constants.Task.TASK.DOAPPROVAL%>', '${taskId}', '${employeeIdActive}', '${taskReceiver}')"/>
		     		<input type="button" value="Reject" class="btn btn-sm  btn-primary" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOREJECT%>', '${employeeIdActive}', '${taskReceiver}')"/> --%>
	    		</logic:equal>
				<!-- end submit != true -->
				
				<!-- reject != true -->
	    		<logic:equal name="isAlreadyReject" value="true">
	     			<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/>
	    		</logic:equal>
				<!-- end reject != true -->
			</logic:notEqual>
		</logic:notEqual>
			
		
  	</td>
   </tr>
</table></div>