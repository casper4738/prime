package prime.login;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.employee.EmployeeBean;
import prime.admin.employee.EmployeeManager;
import prime.admin.employee.EmployeeManagerImpl;
import prime.admin.user.UserBean;
import prime.admin.user.UserManager;
import prime.admin.user.UserManagerImpl;
import prime.admin.usermenu.UserMenuBean;
import prime.admin.usermenu.UserMenuManager;
import prime.admin.usermenu.UserMenuManagerImpl;
import prime.constants.Constants;
import prime.utility.ActiveDirectoryManager;
import prime.utility.MailUtil;

public class LoginAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//##0.Temp Variable
		LoginForm tmpForm = (LoginForm) form;
		LoginManager tmpManager = new LoginManagerImpl();
		ActionForward tmpAction = null;
		
		//##1.Check Task
		if(Constants.Task.DOLOGIN.equals(tmpForm.getTask())){
			//---.Do Checking Process
			int tmpLoginResultCode = Constants.LoginResponse.FAIL_USERNOTEXISTS;
			String tmpLoginResponse = "";
			String tmpUsername = tmpForm.getUsername();
			String tmpPassword = tmpForm.getPassword();
			
			//---.If Username == Null, Just Return [Request From Tommy]
			if(tmpUsername.length() <= 0)
				return mapping.findForward("success");
			
			//---.User Validation Process
			LoginBean tmpUserDetails = new LoginBean();
			if(tmpManager.isUserExists(tmpUsername)) { //############
				//---Fetch User Details [Differ between AD and Normal DB]
				tmpUserDetails = tmpManager.getUserDetails(tmpUsername);
				if(tmpUserDetails.getActiveDirectory() == 1) {
					ActiveDirectoryManager tmpADManager = new ActiveDirectoryManager();
					if(!tmpADManager.checkValidUser(tmpUsername, 
													Constants.ActiveDirectory.ADMIN_USERNAME, 
													Constants.ActiveDirectory.ADMIN_PASSWORD)){
						tmpLoginResultCode = Constants.LoginResponse.FAIL_IDENTIFICATION; //Fail Login, fail identification
					} else {
						if(tmpUserDetails.getStatusUser() == Constants.UserStatus.LOCKED){
							tmpLoginResultCode = Constants.LoginResponse.FAIL_LOCKED; //Fail Login, because locked
						} else {
							if(tmpADManager.isAuthenticated(tmpUsername, tmpPassword)){
								tmpLoginResultCode = Constants.LoginResponse.SUCCESS; //Success Login	
							} else {
								tmpLoginResultCode = Constants.LoginResponse.FAIL_IDENTIFICATION;
							}
						}
					}
				} else {
					if(!tmpManager.isUserValidated(tmpUsername, tmpPassword)){
						tmpLoginResultCode = Constants.LoginResponse.FAIL_IDENTIFICATION;//Fail Login, fail identification
					} else {
						if(tmpUserDetails.getStatusUser() == Constants.UserStatus.LOCKED){
							tmpLoginResultCode = Constants.LoginResponse.FAIL_LOCKED; //Fail Login, because locked
						} else {
							tmpLoginResultCode = Constants.LoginResponse.SUCCESS; //Success Login
						}
					}
				}
				
				//Check Whether on-waiting for lock status or not
				/*
				if(tmpLoginResultCode == 2){
					if(tmpUserDetails.getActionDate().after(new Date())){
						tmpLoginResultCode = 3;
					}
				}
				*/
			}
			
			switch(tmpLoginResultCode){
				case Constants.LoginResponse.FAIL_USERNOTEXISTS :
					tmpLoginResponse = "0#" + Constants.Response.FAILLOGIN_USERNOTEXISTS;
					break;
				case Constants.LoginResponse.FAIL_IDENTIFICATION :
					tmpLoginResponse = "0#" + Constants.Response.FAILLOGIN_VALIDATIONFAILED;
					break;
				case Constants.LoginResponse.SUCCESS :
					tmpLoginResponse = "1#";
					
					//Set Login Session to DB and Update Last Active Time
					tmpManager.setLoginSession(tmpUsername);
					
					//Refetch Data, Set Session and Menu Lists [Earlier we set it at MenuAction.java, now we move it to here]
					UserManager tmpUserData = new UserManagerImpl();
					UserBean tmpUserBean = tmpUserData.getUserByUsername(tmpUsername);
					
					EmployeeManager tmpEmployeeData = new EmployeeManagerImpl();
					EmployeeBean tmpEmployeeBean = tmpEmployeeData.getEmployeeById(tmpUserBean.getEmployeeId());
					
					//----User and Employee Data
					ArrayList<Integer> tmpMenuLists = new ArrayList<Integer>();
					UserMenuManager tmpUserMenuManager = new UserMenuManagerImpl();
					List<UserMenuBean> listUserMenu = tmpUserMenuManager.getListUserMenuByUserRoleId(LoginData.getUserData().getSysLevel());
					for (UserMenuBean e : listUserMenu) {
						if(e.getIsCheck()){
							tmpMenuLists.add(e.getUserMenuId());
						}
					}
					
					//If Success, Prepare Session
					HttpSession tmpSession = request.getSession(true);
					tmpSession.setAttribute(Constants.Session.Userdata		, tmpUserBean);
					tmpSession.setAttribute(Constants.Session.Employeedata	, tmpEmployeeBean);
					tmpSession.setAttribute(Constants.Session.menuLists 	, tmpMenuLists);
					break;
				case Constants.LoginResponse.FAIL_LOCKED :
					tmpLoginResponse = "0#" + Constants.Response.FAILLOGIN_USERLOCKED;
					break;
				default :
					tmpLoginResponse = "0#" + Constants.Response.FAILLOGIN_SOMEFAILURE;
					break;
			}
			
			//---.Set Returning Value
			response.setContentType("text/text;charset=utf-8");
			response.setHeader("cache-control", "no-cache");
			PrintWriter tmpOut = response.getWriter();
			tmpOut.print(tmpLoginResponse);
			tmpOut.flush();
			tmpAction = null;
		} else if(Constants.Task.DOLOGOUT.equals(tmpForm.getTask())) {
			request.getSession().invalidate();

	    	if("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
			     PrintWriter out = response.getWriter();
			     out.println("<script type=\"text/javascript\">");
			     out.println("window.location.href = '" + Constants.PAGES_LIST[Constants.Page.LOGIN] + "';");
			     out.println("</script>");
		    } else {  
		    	response.sendRedirect(Constants.PAGES_LIST[Constants.Page.LOGIN]);
		    }
		} else {
			//---.For First Time Loading
			tmpAction = mapping.findForward("success");
		}	
		
		return tmpAction;
	}
}
