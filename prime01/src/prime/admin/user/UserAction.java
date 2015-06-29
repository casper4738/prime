package prime.admin.user;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;
import prime.login.LoginManager;
import prime.login.LoginManagerImpl;
import prime.utility.ActiveDirectoryManager;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class UserAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		UserManager tmpManager = new UserManagerImpl();
		UserForm userForm = (UserForm) form;
		
		Date curnTime;
		Date compTime;
		curnTime = new Date();
		curnTime = PrimeUtil.parseDateStringToDate(PrimeUtil.setDateToDateString(curnTime));
		
		if(Constants.Task.GOTOADD.equals(userForm.getTask())){
			userForm.getUserBean().setEmployeeId(tmpManager.getNewId());
			return mapping.findForward("add");
		} else if(Constants.Task.GOTOEDIT.equals(userForm.getTask())) {
			//##. Edit Data
			userForm.setUserBean(tmpManager.getUserByUsername(userForm.getTmpValue()));
			return mapping.findForward("edit");
		} else if (Constants.Task.DOADD.equals(userForm.getTask())) {
			userForm.getUserBean().setEmployeeId(userForm.getEmployeeId());
			userForm.getUserBean().setUpdateBy("dedy");

			System.out.println("password    = " + userForm.getUserBean().getPassword());
			System.out.println("empName     = " + userForm.getUserBean().getEmployeeName());
			System.out.println("empID       = " + userForm.getUserBean().getEmployeeId());
			System.out.println("empStatus   = " + userForm.getUserBean().getEmployeeStatus());
			System.out.println("empUpdateBy = " + userForm.getUserBean().getEmployeeStatus());
			
			//tmpManager.insert(userForm.getUserBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOLOCK.equals(userForm.getTask())) {
			//##. Lock User and Go to Forward
			userForm.setUserBean(tmpManager.getUserByUsername(userForm.getTmpValue()));
			compTime = userForm.getUserBean().getChangeDate();
			compTime = PrimeUtil.parseDateStringToDate(PrimeUtil.setDateToDateString(compTime));
			if (userForm.getUserBean().getStatusUser() == Constants.UserStatus.OK){
				if (compTime.after(curnTime)){    
					//Change Status to Wait Locked
					tmpManager.lockUser(userForm.getUserBean());
				} else {
					//Change Status to Locked
					tmpManager.changeActionDate(userForm.getUserBean());
					tmpManager.lockUser(userForm.getUserBean());
				}
			} 
			else if(userForm.getUserBean().getStatusUser() == Constants.UserStatus.LOCKED) {
				if (compTime.after(curnTime)){
					//Change Status to Wait Abort
					tmpManager.unlockUser(userForm.getUserBean());
				} else {
					//Change Status to Unlocked
					tmpManager.changeActionDate(userForm.getUserBean());
					tmpManager.unlockUser(userForm.getUserBean());
				}
			}
			return mapping.findForward("forward");
		} else if(Constants.Task.DORESET.equals(userForm.getTask())) {
			//##. Reset Password and Go to Forward
			tmpManager.resetPassword(userForm.getUserBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOEDIT.equals(userForm.getTask())) {
			//##.Update Data and Go to Forward
			tmpManager.update(userForm.getUserBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOVALIDATE.equals(userForm.getTask())){
			response.setContentType("text/text;charset=utf-8");
			response.setHeader("cache-control", "no-cache");
			PrintWriter tmpOut = response.getWriter();
			String tmpResponse = "";
			
			//Check Username to Database
			LoginManager tmpLoginManager = new LoginManagerImpl();
			int tmpResponseCode = 0;
			//0 : Exists Database ; 1 : Empty Active Directory ; 2 : Empty Database
			if(!tmpLoginManager.isUserExists(userForm.getUserBean().getUserName())){
				ActiveDirectoryManager tmpADManager = new ActiveDirectoryManager();
				if(tmpADManager.checkValidUser(userForm.getUserBean().getUserName(), 
												Constants.ActiveDirectory.ADMIN_USERNAME, 
												Constants.ActiveDirectory.ADMIN_PASSWORD)){
					tmpResponseCode = 2; //Username Exists in Active Directory
				} else {
					tmpResponseCode = 1; //User Doesn't Exists in Active Directory
				}
			} else {
				tmpResponseCode = 0;
			}

			switch(tmpResponseCode){
				case 0 :
					tmpResponse = "0#<div id=\"message\" style=\"color:red;font-size:8\">Username already exists</div>";
					break;
				case 1 :
					tmpResponse = "1#<div id=\"message\" style=\"color:green;font-size:8\">Username can be used</div>";
					break;
				case 2 :
					tmpResponse = "2#<div id=\"message\" style=\"color:blue;font-size:8\">Username can be used [Active Directory]</div>";
					break;
			}
			
			tmpOut.print(tmpResponse);
			tmpOut.flush();
			return null;
		}
		
		int countRows  = tmpManager.getCountByColumn(userForm.getColumnSearch(), userForm.getSearch());
		
		List<UserBean> list = tmpManager.getListByColumn(userForm.getColumnSearch(), userForm.getSearch(),
				PrimeUtil.getStartRow(userForm.getGoToPage(), userForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(userForm.getGoToPage(), userForm.getShowInPage(), countRows));

		//##1.Attribute for Table Show
		for(int tmpI = 0 ; tmpI < list.size() ; tmpI++){
			compTime = list.get(tmpI).getChangeDate();
			compTime = PrimeUtil.parseDateStringToDate(PrimeUtil.setDateToDateString(compTime));
			switch(list.get(tmpI).getStatusUser()){
				case Constants.UserStatus.OK   :
					if (list.get(tmpI).getChangeDate().after(curnTime)){
						//Status Wait Abort
						list.get(tmpI).setStatusUser(3);
					} else {
						//Status Ok
						list.get(tmpI).setStatusUser(1);
					}
					break;
				case Constants.UserStatus.LOCKED :
					if (list.get(tmpI).getChangeDate().after(curnTime)){
						//Status Wait Locked
						list.get(tmpI).setStatusUser(2);
					} else {
						//Status Locked
						list.get(tmpI).setStatusUser(0);
					}
					break;
			}
		}
		
		request.setAttribute("listUser", list);
		request.setAttribute("listSearchColumn", Constants.Search.USER_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
		
		setPaging(request, userForm, countRows, userForm.getGoToPage(), userForm.getShowInPage());
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, UserForm userForm, int countRows, int page, int view)
			throws SQLException {
		//##2.Paging Handling
		PaginationUtility pageUtil = new PaginationUtility();
		pageUtil.setCountRows(countRows);
		pageUtil.setView(view);

		request.setAttribute("totalData", countRows);
		request.setAttribute("listPage", pageUtil.getListPaging(page));
		request.setAttribute("pageNow", pageUtil.getPage());
		request.setAttribute("pageFirst", 1);
		request.setAttribute("pageLast", pageUtil.getSumOfPage());
		request.setAttribute("pagePrev", pageUtil.getPagePrev());
		request.setAttribute("pageNext", pageUtil.getPageNext());
		request.setAttribute("listMaxDataPerPage", Constants.PAGINGROWPAGE);

		userForm.setGoToPage(pageUtil.getPage());
	}

}
