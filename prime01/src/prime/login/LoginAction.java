package prime.login;

import java.io.PrintWriter;
import java.util.Date;

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
			int tmpLoginResultCode = 0;
			String tmpLoginResponse = "";
			String tmpUsername = tmpForm.getUsername();
			String tmpPassword = tmpForm.getPassword();
			
			//---.User Validation Process
			LoginBean tmpUserDetails = null;
			if(tmpManager.isUserExists(tmpUsername)){
				//---Fetch User Details [Differ between AD and Normal DB]
				tmpUserDetails = tmpManager.getUserDetails(tmpUsername);
				
				if(tmpUserDetails.isActiveDirectory()){
					ActiveDirectoryManager tmpADManager = new ActiveDirectoryManager();
					if(!tmpADManager.checkValidUser(tmpUsername, 
													Constants.ActiveDirectory.ADMIN_USERNAME, 
													Constants.ActiveDirectory.ADMIN_PASSWORD)){
						tmpLoginResultCode = 1; //Fail Login, fail identification
					} else {
						if(tmpUserDetails.getStatusUser() == Constants.UserStatus.LOCKED){
							tmpLoginResultCode = 3; //Fail Login, because locked
						} else {
							tmpLoginResultCode = 2; //Success Login
						}
					}
				} else {
					if(!tmpManager.isUserValidated(tmpUsername, tmpPassword)){
						tmpLoginResultCode = 1; //Fail Login, fail identification
					} else {
						if(tmpUserDetails.getStatusUser() == Constants.UserStatus.LOCKED){
							tmpLoginResultCode = 3; //Fail Login, because locked
						} else {
							tmpLoginResultCode = 2; //Success Login
						}
					}
				}
				
				//Check Whether on-waiting for lock status or not
				if(tmpLoginResultCode == 2){
					if(tmpUserDetails.getActionDate().after(new Date())){
						tmpLoginResultCode = 3;
					}
				}
			}
			
			switch(tmpLoginResultCode){
				case 0 :
					tmpLoginResponse = "0#" + Constants.Response.FAILLOGIN_USERNOTEXISTS;
					break;
				case 1 :
					tmpLoginResponse = "0#" + Constants.Response.FAILLOGIN_VALIDATIONFAILED;
					break;
				case 2 :
					tmpLoginResponse = "1#";
					
					//Set Login Session to DB and Update Last Active Time
					tmpManager.setLoginSession(tmpUsername);
					
					//Refetch Data and Set Session
					UserManager tmpUserData = new UserManagerImpl();
					UserBean tmpUserBean = tmpUserData.getUserByUsername(tmpUsername);
					
					EmployeeManager tmpEmployeeData = new EmployeeManagerImpl();
					EmployeeBean tmpEmployeeBean = tmpEmployeeData.getEmployeeById(tmpUserBean.getEmployeeId());

					LoginData.setUserBean(tmpUserBean);
					LoginData.setEmployeeBean(tmpEmployeeBean);
					
					//If Success, Prepare Session
					HttpSession tmpSession = request.getSession(true);
					tmpSession.setAttribute(Constants.Session.ID		, tmpUserBean.getloginSession());
					tmpSession.setAttribute(Constants.Session.Username	, tmpUserBean.getUserName());
					break;
				case 3 :
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
			LoginData.clear();

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
