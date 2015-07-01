package prime.report;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ReportAction extends Action{
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String tmpMapTarget = "";
		ReportForm pForm = (ReportForm)form;
		
		if(pForm.getTask().equals("success")){
			tmpMapTarget = "success";
		} 
		else if(pForm.getTask().equals("showReportEmployee")){
			//Temp Variable
			HttpSession tmpSession = request.getSession(true);
			
			//Set Param
			if(pForm.getReportType().equals("employeeId")){
				tmpSession.setAttribute("searchQuery", " WHERE EMPLOYEE_ID LIKE ('%" + pForm.getParam1() + "%')");
			}
			else if(pForm.getReportType().equals("employeeName")){
				tmpSession.setAttribute("searchQuery", " WHERE LOWER(EMPLOYEE_NAME) LIKE LOWER('%" + pForm.getParam1() + "%')");
			}
			
			tmpMapTarget = "showReportEmployee";
		}
		
		return mapping.findForward(tmpMapTarget);
	}
}
