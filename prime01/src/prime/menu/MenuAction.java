package prime.menu;

import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.usermenu.UserMenuBean;
import prime.admin.usermenu.UserMenuManager;
import prime.admin.usermenu.UserMenuManagerImpl;
import prime.constants.Constants;
import prime.login.LoginData;
import prime.user.notification.NotificationBean;
import prime.user.notification.NotificationManager;
import prime.user.notification.NotificationManagerImpl;
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
		String[] tmpMenu = {"Menu","Dashboard Admin","Manage User","Manage Employee","Manage Division","Manage Position",
							"Manage Role","Manage Holiday","View User Menu","Manage User Role","Manage Notif Template",
							"View Log","General Settings","Dashboard User","Manage Task as Head","Manage Task as Subordinate",
							"Manage Project As Head","Manage Project","View Report Employees","View Report Project",
							"View Notification"};
		
		List<UserMenuBean> listUserMenu = tmpUserMenuManager.getListUserMenuByUserRoleId(LoginData.getUserData().getSysLevel());
		
		for (UserMenuBean e : listUserMenu) {
			System.out.println(e.getUserMenuId()+ " - "+e.getUserMenuName()+"-"+e.getUserMenuAction()+"-"+e.getIsCheck());
		}

		
		for (UserMenuBean e : listUserMenu) {
			if(e.getIsCheck()){
				if(request.getSession().getAttribute(Constants.Session.lastPage) == null){
					request.getSession().setAttribute(Constants.Session.lastPage, Constants.PAGES_LIST[e.getUserMenuId()]);
				}
				tmpObject.put(Constants.PAGES_LIST[e.getUserMenuId()], tmpMenu[e.getUserMenuId()]);
			}
		}

		
		//##3.Prepare Request Attribute For JSP Readings
		request.setAttribute("listPages", tmpObject);
		MenuForm tmpMenuForm = (MenuForm)form;

		if(("redirect").equals(tmpMenuForm.getTask())){
			HttpSession tmpSession = request.getSession();
			
			//Do Redirect if the ID is same :)
			if(tmpMenuForm.getParam4().equals(LoginData.getEmployeeData().getEmployeeId().toString())){
				NotificationManager tmpNotificationManager = new NotificationManagerImpl();
				NotificationBean tmpNotifBean;
				
				//Get Notif Type and Mark as Read
				System.out.println("ID = " + Integer.parseInt(tmpMenuForm.getParam5()));
				tmpNotifBean = tmpNotificationManager.getNotifByID(Integer.parseInt(tmpMenuForm.getParam5()));
				tmpNotificationManager.markAsRead(Integer.parseInt(tmpMenuForm.getParam5()));
				System.out.println("Notif Bean = " + tmpNotifBean);
				System.out.println("Notif Type = " + tmpNotifBean.getNotificationType());
				
				//Set Attribute
				tmpSession.setAttribute(Constants.Session.needRedirect 	, true);
				tmpSession.setAttribute(Constants.Session.redirectPage 	, tmpMenuForm.getParam1());
				
				switch(tmpNotifBean.getNotificationType()){
				case Constants.NotificationType.PROJECT_ABORT :
				case Constants.NotificationType.PROJECT_SUBMITAPPROVALRETURN :
				case Constants.NotificationType.PROJECT_SUBMITAPPROVAL :
				case Constants.NotificationType.PROJECT_REMOVEDFROMROLE :
				case Constants.NotificationType.PROJECT_NEWPMDELEGATED :
				case Constants.NotificationType.PROJECT_CREATEAPPROVALRETURN :
				case Constants.NotificationType.PROJECT_CREATEAPPROVAL :
				case Constants.NotificationType.PROJECT_ASSIGNEDASROLE :
					tmpSession.setAttribute(Constants.Session.redirectParam	, "task=" 			+ tmpMenuForm.getParam2() + "&" +
																			  "projectId=" 		+ tmpMenuForm.getParam3() + "&" + 
								  											  "employeeId=" 	+ tmpMenuForm.getParam4());
					break;
				case Constants.NotificationType.TASK_ABORTBYHEAD :
				case Constants.NotificationType.TASK_SELFASSIGNAPPROVAL :
				case Constants.NotificationType.TASK_SELFASSIGNAPPROVALRETURN :
				case Constants.NotificationType.TASK_SUBMITAPPROVAL :
				case Constants.NotificationType.TASK_SUBMITAPPROVALRETURN :
					tmpSession.setAttribute(Constants.Session.redirectParam	, "task=" 		+ tmpMenuForm.getParam2() + "&" +
		  	 				  												  "taskId=" 		+ tmpMenuForm.getParam3() + "&" + 
		  	 				  												  "employeeId=" 	+ tmpMenuForm.getParam4());
					break;	
					
				}
				
				//Redirect to Avoid Multiple Link
				PrintWriter out = response.getWriter();
			    out.println("<script type=\"text/javascript\">");
			    out.println("window.location.href = '" + Constants.PAGES_LIST[Constants.Page.MENU] + "';");
			    out.println("</script>");
				return null;
			}
		}
		
		return mapping.findForward("success");
	}
}
