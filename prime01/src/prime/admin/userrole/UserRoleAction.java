package prime.admin.userrole;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import prime.admin.user.UserBean;
import prime.admin.usermenu.UserMenuBean;
import prime.admin.usermenu.UserMenuManager;
import prime.admin.usermenu.UserMenuManagerImpl;
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
		UserMenuManager tmpMenuManager = new UserMenuManagerImpl();

		request.setAttribute("homepage", request.getSession().getAttribute(Constants.Session.lastPage));
		
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
			pForm.getUserRoleBean().setUpdateBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
			tmpManager.insert(pForm.getUserRoleBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOEDIT.equals(pForm.getTask())) {
			//##.Update Data and Go to Forward
			pForm.getUserRoleBean().setUpdateBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
			tmpManager.update(pForm.getUserRoleBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOCHECK.equals(pForm.getTask())) {
			//##.Update Data and Go to Forward
			tmpManager.delete(pForm.getUserRoleBean().getUserRoleId());
			String[] split = pForm.getCheckboxTes().split(",");
			for (String string : split) {
				pForm.getUserRoleBean().setUserMenuId(Integer.parseInt(string.split("-")[0].trim()));
				if(Boolean.parseBoolean(string.split("-")[1].trim())) {
					pForm.getUserRoleBean().setUserMenuAction("V");					
				} else {
					pForm.getUserRoleBean().setUserMenuAction("");										
				}
				UserRoleBean bean = new UserRoleBean();
				bean.setUserRoleId(pForm.getUserRoleBean().getUserRoleId());
				bean.setUserMenuAction(pForm.getUserRoleBean().getUserMenuAction());
				bean.setUserMenuId(pForm.getUserRoleBean().getUserMenuId());
				bean.setUpdateBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
				tmpManager.insertUserRoleMenu(bean);				
			}
			return mapping.findForward("forward");
		} else if(Constants.Task.GOTOVIEW.equals(pForm.getTask())) {
			pForm.setUserRoleBean(tmpManager.getUserRoleById(pForm.getTmpId()));
			List<UserMenuBean> listUserMenu = tmpMenuManager.getListUserMenuByUserRoleId(pForm.getTmpId());
			request.setAttribute("listUserMenu", listUserMenu);
			return mapping.findForward("view");
		}
		
		int countRows  = tmpManager.getCountByColumn(pForm.getColumnSearchReal(), pForm.getSearch());
		List<UserRoleBean> list = tmpManager.getListByColumn(pForm.getColumnSearchReal(), pForm.getSearch(),
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
