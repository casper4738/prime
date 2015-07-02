package prime.menu;

import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.usermenu.UserMenuBean;
import prime.admin.usermenu.UserMenuManager;
import prime.admin.usermenu.UserMenuManagerImpl;
import prime.admin.userrole.UserRoleManager;
import prime.admin.userrole.UserRoleManagerImpl;
import prime.constants.Constants;
import prime.login.LoginData;
import prime.user.project.ProjectManager;
import prime.user.project.ProjectManagerImpl;

public class MenuAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//##0.Temp Variable
		//HttpSession tmpSession = request.getSession();
		//LoginBean tmpUserData = (LoginBean)tmpSession.getAttribute(Constants.Session.USERDATA);
		LinkedHashMap<String, String> tmpObject = new LinkedHashMap<String, String>();
		ProjectManager tmpProjectManager=new ProjectManagerImpl();
		UserMenuManager tmpUserMenuManager = new UserMenuManagerImpl();
		String[] tmpMenu = {"Menu","Dashboard","Manage User","Manage Employee","Manage Division","Manage Position",
							"Manage Role","Manage Holiday","View User Menu","Manage User Role","Manage Notif Template",
							"View Log","General Settings","Dashboard","Manage Task as Head","Manage Task as Subordinate",
							"Manage Project As Head","Manage Project","View Report Employees","View Report Project",
							"View Notification"};
		
		List<UserMenuBean> listUserMenu = tmpUserMenuManager.getListUserMenuByUserRoleId(LoginData.getUserData().getSysLevel());
		
		for (UserMenuBean e : listUserMenu) {
			System.out.println(e.getUserMenuId()+ " - "+e.getUserMenuName()+"-"+e.getUserMenuAction()+"-"+e.getIsCheck());
		}

		
		for (UserMenuBean e : listUserMenu) {
			if(e.getIsCheck()){
				tmpObject.put(Constants.PAGES_LIST[e.getUserMenuId()], tmpMenu[e.getUserMenuId()]);
			}
		}

		
		//##3.Prepare Request Attribute For JSP Readings
		request.setAttribute("listPages", tmpObject);
		
		MenuForm tmpMenuForm = (MenuForm)form;
		if(("redirect").equals(tmpMenuForm.getTask())){
			request.setAttribute("needRedirect" , true);
			request.setAttribute("redirectPage" , tmpMenuForm.getParam1());
			System.out.println(tmpMenuForm.getParam1());
			request.setAttribute("redirectParam", "task=" 		+ tmpMenuForm.getParam2() + "&" +
												  "taskId=" 	+ tmpMenuForm.getParam3() + "&" + 
												  "employeeId=" + tmpMenuForm.getParam4());
		}
		
		return mapping.findForward("success");
	}
}
