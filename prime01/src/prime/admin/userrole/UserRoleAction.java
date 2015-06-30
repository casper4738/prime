package prime.admin.userrole;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.division.DivisionForm;
import prime.admin.employee.EmployeeBean;
import prime.admin.usermenu.UserMenuBean;
import prime.constants.Constants;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class UserRoleAction extends Action{
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserRoleForm pForm = (UserRoleForm) form;
		UserRoleManager tmpManager = new UserRoleManagerImpl();
		
		if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##. Add Data
			pForm.getUserRoleBean().setUserRoleId(tmpManager.getNewId());
			return mapping.findForward("add");
		} else if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			//##. Edit Data
			pForm.setUserRoleBean(tmpManager.getUserRoleById(pForm.getTmpId()));
			return mapping.findForward("edit");
		} else if(Constants.Task.DOADD.equals(pForm.getTask())) {
			//##.Insert Data and Go to Forward
			tmpManager.insert(pForm.getUserRoleBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOEDIT.equals(pForm.getTask())) {
			//##.Update Data and Go to Forward
			tmpManager.update(pForm.getUserRoleBean());
			return mapping.findForward("forward");
		}else if(Constants.Task.GOTOVIEW.equals(pForm.getTask())) {
			pForm.setUserRoleBean(tmpManager.getUserRoleById(pForm.getTmpId()));
			/*List<EmployeeBean> listWeekendByEmployeeId = tmpManager.getListWeekendByEmployeeId(pForm.getTmpId());
			request.setAttribute("listWeekendByEmployeeId", listWeekendByEmployeeId);	*/
			List<UserMenuBean> listUserMenu = tmpManager.getListUserMenuByUserRoleId(pForm.getTmpId());
			request.setAttribute("listUserMenu", listUserMenu);
			return mapping.findForward("view");
		}
		
		int countRows  = tmpManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
		List<UserRoleBean> list = tmpManager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
		
		//##1.Attribute for Table Show
		request.setAttribute("listUserRole", list);
		request.setAttribute("listSearchColumn", Constants.Search.USERROLE_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
		setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, UserRoleForm pForm, int countRows, int page, int view)
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

		pForm.setGoToPage(pageUtil.getPage());
	}

}
