package prime.login;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.user.UserBean;
import prime.utility.ActiveDirectoryManager;

public class LoginAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//##0.Temp Variable
		LoginForm tmpForm = (LoginForm) form;
		LoginManager tmpManager = new LoginManagerImpl();
		HttpSession tmpSession = request.getSession(true);
		
		//##1.Check Task
		if("doLogin".equals(tmpForm.getTask())){
			//---.Do Checking Process
			boolean isLoginSuccess = true;
			
			//  a.Register Flag
			UserBean tmpUser = tmpManager.getUser(tmpForm.getUsername());
			
			//  b.Check From DB
			if(tmpUser == null){
				isLoginSuccess = false;
				System.out.println("False Doank Sigh");
			} else {
				//---1.Check Is Active Directory Type or Not
				//---2.If Yes, Crosscheck by using ActiveDirectory Class
				//---3.If No , Crosscheck by using DB-Username and Password
				System.out.println("Check Until here");
				if(tmpUser.getIsActiveDirectory()){
					ActiveDirectoryManager tmpADManager = new ActiveDirectoryManager();
					if(!tmpADManager.checkValidUser(tmpUser.getUserName(), "dedy.suwandi", "Ace2015")){
						isLoginSuccess = false;
					}
				} else {
					if(!tmpForm.getPassword().equals(tmpUser.getPassword())){
						isLoginSuccess = false;
					}
				} 
			}
			
			//  c.Check Final Flag Whether Login Failed or Not
			if(isLoginSuccess){
				//---.Set User Session ID
				
				//---.Check Current User Privilege and Go To Selected Page
				
			} else {
				//---.Returning Fail Login Value
				response.setContentType("text/text;charset=utf-8");
				response.setHeader("cache-control", "no-cache");
				PrintWriter tmpOut = response.getWriter();
				tmpOut.print("loginFail;Username and Password doesn't match !");
				tmpOut.flush();
				return null;
			}
		} else {
			//---.For First Time Loading
			return mapping.findForward("success");
		}	
		
		return null;
	}
}
