package prime.admin.user;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import prime.admin.employee.EmployeeManager;
import prime.admin.employee.EmployeeManagerImpl;
import prime.constants.Constants;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
import prime.user.task.TaskBean;
import prime.user.task.TaskHeadForm;
import prime.user.task.TaskManager;
import prime.user.task.TaskManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class UserAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		UserManager tmpManager = new UserManagerImpl();
		UserForm userForm = (UserForm) form;
		
		if(Constants.Task.GOTOADD.equals(userForm.getTask())){
			return mapping.findForward("add");
		} else if(Constants.Task.GOTOEDIT.equals(userForm.getTask())) {
			//##. Edit Data
			userForm.setUserBean(tmpManager.getUserByUsername(userForm.getTmpValue()));
			return mapping.findForward("edit");
		} else if(Constants.Task.DOEDIT.equals(userForm.getTask())) {
			//##.Update Data and Go to Forward
			System.out.println("coba lagi");
			tmpManager.update(userForm.getUserBean());
			return mapping.findForward("forward");
		}
		int countRows  = tmpManager.getCountByColumn(userForm.getColumnSearch(), userForm.getSearch());
		
		List<UserBean> list = tmpManager.getListByColumn(userForm.getColumnSearch(), userForm.getSearch(),
				PrimeUtil.getStartRow(userForm.getGoToPage(), userForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(userForm.getGoToPage(), userForm.getShowInPage(), countRows));

		//##1.Attribute for Table Show
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
