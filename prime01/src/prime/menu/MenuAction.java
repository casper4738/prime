package prime.menu;

import java.util.HashMap;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;

public class MenuAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//##0.Hard Code Menu [Will think for better implementation later]
		LinkedHashMap<String, String> tmpObject = new LinkedHashMap<String, String>();
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_DASHBOARD]			, "Dashboard");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_USER]				, "Manage User");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]			, "Manage Employee");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_DIVISION]			, "Manage Division");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_HOLIDAY]			, "Manage Holiday");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_POSITION]			, "Manage Position");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_ROLE]				, "Manage Role");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_LOG]				, "View Log");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_SETTING]			, "General Settings");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_DASHBOARD]			, "Dashboard");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]			, "Manage Task As Head");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_TASK_SUBORDINATE]	, "Manage Task As Subordinate");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_PROJECT]				, "Manage Project");
		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_REPORT]				, "View Report");
		request.setAttribute("listPages", tmpObject);
		
		return mapping.findForward("success");
	}
}
