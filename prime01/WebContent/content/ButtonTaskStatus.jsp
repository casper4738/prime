<%@page import="prime.admin.setting.GeneralSettingManagerImpl"%>
<%@page import="prime.admin.setting.GeneralSettingManager"%>
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

<%-- <center>${employeeIdActive} |${taskAssigner}  | ${taskReceiver} | ${taskId} | ${projectMemberId } - 
<br/>
${isAllFinished} | ${isAlreadySubmit} | ${isAlreadyReject} | ${isAlreadyApprove} | ${isAlreadyAgree} |  ${isNeedApproval} | ${isAlreadyAbort } | ${isAlreadyApprove} - 
</center>
<br/> --%>

<div class="form-action"><table align="center">
   <tr> <td style="padding:5px;">
   <input type="button" value="Submit" class="btn btn-sm  btn-primary" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/> | 
   		<logic:notEqual name="isAlreadyAbort" value="true">
   		<logic:notEqual name="isAlreadyApprove" value="true">
   			<logic:equal name="taskReceiver" value="${employeeIdActive}">
					<!-- finish == true -->
					<logic:equal name="isAllFinished" value="true">
						<!-- submit != true -->
						<logic:notEqual name="isAlreadySubmit" value="true">
							<%
							EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
							EmployeeBean e = tmpEmployeeManager.getEmployeeById(Integer.parseInt(request.getAttribute("employeeIdActive").toString()));
							if(e.getManagerId() == null || e.getManagerId() == 0) {
							%>	
								<input type="button" value="Finish" class="btn btn-sm  btn-success" onclick="doTaskApp('<%=Constants.Task.TASK.DOAPPROVAL%>', '${taskId}', '${employeeIdActive}', '${taskReceiver}', 'self')"/>
			     			<% } else { %>
				     			<!-- approve != true -->
								<logic:notEqual name="isAlreadyApprove" value="true">
									<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
									
									<logic:equal name="isNeedApproval" value="true">
										<input type="button" value="Submit" class="btn btn-sm  btn-primary" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/>
									</logic:equal>
									<logic:notEqual name="isNeedApproval" value="true">
										<input type="button" value="Finish" class="btn btn-sm  btn-success" onclick="doTaskApp('<%=Constants.Task.TASK.DOAPPROVAL%>', '${taskId}', '${employeeIdActive}', '${taskReceiver}', 'self')"/>
									</logic:notEqual>
									
									<%-- <input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/> --%>
								</logic:notEqual>
								<!-- end approve != true -->
			     			<% } %>
						</logic:notEqual>
						<!-- end submit != true -->
						
						<!-- submit != true -->
						<logic:equal name="isAlreadySubmit" value="true">
							<!-- projectMemberId != null -->
							<logic:notEmpty name="projectMemberId">
							<input type="button" value="Approve" class="btn btn-sm  btn-success" onclick="doTaskApp('<%=Constants.Task.TASK.DOAPPROVAL%>', '${taskId}', '${employeeIdActive}', '${taskReceiver}')"/>
					     		<input type="button" value="Reject" class="btn btn-sm  btn-primary" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOREJECT%>', '${employeeIdActive}', '${taskReceiver}')"/>
					     		<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/>
							</logic:notEmpty>
							<!-- end projectMemberId != null -->
			    		</logic:equal>
						<!-- end submit != true -->
						
		    		</logic:equal>
					<!-- end finish != true -->
					
					<!-- finish != true -->
		    		<logic:notEqual name="isAllFinished" value="true">
						<!-- submit != true -->
						<logic:notEqual name="isAlreadySubmit" value="true">
							<!-- approve != true -->
							<logic:notEqual name="isAlreadyApprove" value="true">
								
								<logic:equal name="isNeedApproval" value="true">
									<!-- aggree != true -->
									<logic:equal name="isAlreadyAgree" value="true">
										<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
										<%-- <input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/> --%>
										<bean:define id="isOk" value="true" toScope="request" />
							    	</logic:equal>
							    	<!-- end of aggree == true -->
								</logic:equal>
								<logic:notEqual name="isNeedApproval" value="true">
									<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
				    				<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/>
								</logic:notEqual>
								<logic:equal name="taskAssigner" value="${employeeIdActive}">
									<!-- aggree == true -->
									<logic:equal name="isAlreadyAgree" value="true">
										<logic:notEqual name="isOk" value="true">
						    				<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
										</logic:notEqual>
							    	</logic:equal>
									<!-- end of aggree == true -->
									<%-- 
									<%
									EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
									EmployeeBean e = tmpEmployeeManager.getEmployeeById(Integer.parseInt(request.getAttribute("employeeIdActive").toString()));
									if(e.getManagerId() == null || e.getManagerId() == 0) {
									%>	
										<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
										<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/>
					     			<% } else { %>
					     			<% } %>
									 --%>
									
								</logic:equal>
								
								<logic:notEqual name="taskAssigner" value="${employeeIdActive}">
									<!-- aggree != true -->
									<logic:notEqual name="isAlreadyAgree" value="true">
						    			<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
							    	</logic:notEqual>
									<!-- end of aggree != true -->
								</logic:notEqual>
								
							</logic:notEqual>
							<!-- end approve != true -->
						</logic:notEqual>
						<!-- end submit != true -->
		    		</logic:notEqual>
					<!-- end finish != true -->
		    		
					<!-- reject == true -->
		    		<logic:equal name="isAlreadyReject" value="true">
						<!-- assigner != true -->
		    			<logic:equal name="taskAssigner" value="${employeeIdActive}">
			     			<input type="button" value="Create New Activity" class="btn btn-sm btn-primary" onclick="flyToPage('<%=Constants.Task.ACTIVITY.GOTOADD%>')" />
			     			<input type="button" value="Submit" class="btn btn-sm  btn-primary" onclick="flyToPage('<%=Constants.Task.TASK.GOTOSUBMIT%>')"/>
			    		</logic:equal>
						<!-- end assigner != true -->
		    		</logic:equal>
					<!-- end reject == true -->
				
			</logic:equal>
			
			
			<logic:equal name="taskAssigner" value="${employeeIdActive}">
				<logic:notEqual name="taskReceiver" value="${employeeIdActive}">
					<!-- submit == true -->
					<logic:equal name="isAlreadySubmit" value="true">
		     			<input type="button" value="Approve" class="btn btn-sm  btn-success" onclick="doTaskApp('<%=Constants.Task.TASK.DOAPPROVAL%>', '${taskId}', '${employeeIdActive}', '${taskReceiver}')"/>
		    			<input type="button" value="Reject" class="btn btn-sm  btn-primary" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOREJECT%>', '${employeeIdActive}', '${taskReceiver}')"/>
		    			<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/>
		    		</logic:equal>
					<!-- end submit == true -->
		
					<!-- reject == true -->
		    		<logic:equal name="isAlreadyReject" value="true">
		     			<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/>
		    		</logic:equal>
					<!-- end reject == true -->
				</logic:notEqual>
			</logic:equal>
			
			<logic:notEqual name="taskReceiver" value="${employeeIdActive}">
				<logic:notEqual name="taskAssigner" value="${employeeIdActive}">
				
					<logic:equal name="taskReceiver" value="${taskAssigner}">
						<%
							EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
							EmployeeBean e = tmpEmployeeManager.getEmployeeById(Integer.parseInt(request.getAttribute("taskReceiver").toString()));
							request.setAttribute("headId", e.getManagerId());	
							
							GeneralSettingManager tmpManager = new GeneralSettingManagerImpl();
							boolean bool = (e.getPositionLevel() <= tmpManager.getGeneralSetting().getMinLevelApproval()) ? false : true;
							request.setAttribute("isNeedApprovalx",bool);	
						%>
						
						<logic:equal name="headId" value="${employeeIdActive}">
							
							<!-- submit == true -->
							<logic:equal name="isAlreadySubmit" value="true">
								<!-- reject != true -->
								<logic:notEqual name="isAlreadyReject" value="true">
					     			<input type="button" value="Approve" class="btn btn-sm  btn-success" onclick="doTaskApp('<%=Constants.Task.TASK.DOAPPROVAL%>', '${taskId}', '${employeeIdActive}', '${taskReceiver}')"/>
					    			<input type="button" value="Reject" class="btn btn-sm  btn-primary" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOREJECT%>', '${employeeIdActive}', '${taskReceiver}')"/>
					    			<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/>
								</logic:notEqual>
								<!-- end reject != true -->
								
								<!-- reject == true -->
					    		<logic:equal name="isAlreadyReject" value="true">
					     			<input type="button" value="Abort" class="btn btn-sm  btn-danger" onclick="doTaskAct('${taskId}', '<%=Constants.Task.TASK.DOABORT%>', '${employeeIdActive}', '${taskReceiver}')"/>
					    		</logic:equal>
								<!-- end reject == true -->
				    		</logic:equal>
							<!-- end submit == true -->
					
							<logic:equal name="isNeedApprovalx" value="true">
			   					<!-- aggree != true -->
								<logic:notEqual name="isAlreadyAgree" value="true">
									<input type="button" value="Aggree" class="btn btn-sm  btn-success" onclick="flyToPage('<%=Constants.Task.TASK.DOAGREE%>')"/>
								</logic:notEqual>
								<!-- end of aggree != true -->
							</logic:equal>
							
						</logic:equal>
					</logic:equal>
					
				</logic:notEqual>
			</logic:notEqual>
   		</logic:notEqual>
   		</logic:notEqual>
  	</td>
   </tr>
</table></div>
