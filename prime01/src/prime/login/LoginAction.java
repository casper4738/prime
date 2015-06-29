package prime.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;
import prime.utility.ActiveDirectoryManager;

public class LoginAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//##0.Temp Variable
		LoginForm tmpForm = (LoginForm) form;
		LoginManager tmpManager = new LoginManagerImpl();
		HttpSession tmpSession = request.getSession(true);
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
					
					//If Success, Prepare Session
					request.getSession(true).setAttribute(Constants.Session.USERDATA, tmpUserDetails);
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
		} else {
			//---.For First Time Loading
			tmpAction = mapping.findForward("success");
		}	
		
		return tmpAction;
	}
}
