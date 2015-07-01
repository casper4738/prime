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
		
		//##1.Preparing Menu
		//---Hard Code Menu [Will think for better implementation later]
		//switch(tmpUserData.getSystemLevel()){
		//	case Constants.SystemLevel.ADMIN :
				/*tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_DASHBOARD]			, "Dashboard");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_USER]				, "Manage User");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_EMPLOYEE]			, "Manage Employee");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_DIVISION]			, "Manage Division");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_HOLIDAY]			, "Manage Holiday");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_POSITION]			, "Manage Position");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_ROLE]				, "Manage Role");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_LOG]				, "View Log");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_SETTING]			, "General Settings");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_NOTIFTEMPLATE]		, "Manage Notif Template");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_USERMENU]			, "View User Menu");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.ADMIN_USERROLE]			, "Manage User Role");
		//		break;
		//	case Constants.SystemLevel.OPERATOR:
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_DASHBOARD]			, "Dashboard");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]			, "Manage Task As Head");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_TASK_SUBORDINATE]	, "Manage Task As Subordinate");
				//checkingEmployeeAsPM
				System.out.println("jumlah "+tmpProjectManager.getCountProjectMember(LoginData.getEmployeeData().getEmployeeId()));
				System.out.println("jumlah Assigener "+tmpProjectManager.getCountProjectAssigner(LoginData.getEmployeeData().getEmployeeId()));
				System.out.println("jumlah Receiver"+tmpProjectManager.getCountProjectReceiver(LoginData.getEmployeeData().getEmployeeId()));
				if(tmpProjectManager.getCountProjectReceiver(LoginData.getEmployeeData().getEmployeeId())>0 ||
						tmpProjectManager.getCountProjectMember(LoginData.getEmployeeData().getEmployeeId())>0)
				{
					System.out.println("masuk");
					tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_PROJECT]				, "Manage Project");
				}
				//checkingEmployeeAsHead
				if(tmpProjectManager.getCountProjectAssigner(LoginData.getEmployeeData().getEmployeeId())>0)
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_PROJECT_HEAD]		, "Manage Project As Head");
				
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_REPORT_EMPLOYEES]	, "View Report Employees");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_REPORT_PROJECT]		, "View Report Project");
				tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_VIEWNOTIF]			, "View Notification");*/
		//		break;
		//	case Constants.SystemLevel.OPERATOR_MONITOR :
		//		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_DASHBOARD]			, "Dashboard");
		//		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]			, "Manage Task As Head");
		//		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_TASK_SUBORDINATE]	, "Manage Task As Subordinate");
		//		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_PROJECT]				, "Manage Project");
		//		tmpObject.put(Constants.PAGES_LIST[Constants.Page.USER_REPORT]				, "View Report");
		//		break;
			
		//}
		
		//##3.Prepare Request Attribute For JSP Readings
		request.setAttribute("listPages", tmpObject);
		
		return mapping.findForward("success");
	}
}
