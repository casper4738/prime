package prime.admin.role;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class RoleAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RoleForm pForm = (RoleForm) form;
		RoleManager manager = new RoleManagerImpl();
		
		if("add".equals(pForm.getTask())) {
			pForm.getPositionBean().setRoleId(manager.getNewId());
			pForm.getPositionBean().setRoleStatus(1);
			return mapping.findForward("add");
		} else if("edit".equals(pForm.getTask())) {
			pForm.setPositionBean(manager.getRoleById(pForm.getPositionId()));
			return mapping.findForward("edit");
		} else if("insert".equals(pForm.getTask())) {
			manager.insert(pForm.getPositionBean());
			return mapping.findForward("forward");
		} else if("update".equals(pForm.getTask())) {
			manager.update(pForm.getPositionBean());
			return mapping.findForward("forward");
		} else if("delete".equals(pForm.getTask())) {
			manager.delete(pForm.getPositionId());
			return mapping.findForward("forward");
		}
		
		int countRows  = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
		List<RoleBean> list = manager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage()),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
		
		request.setAttribute("listDivision", list);

		setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, int countRows, int page, int view)
			throws SQLException {
		PaginationUtility pageUtil = new PaginationUtility();
		pageUtil.setCountRows(countRows);
		pageUtil.setView(view);

		request.setAttribute("totalData", countRows);
		request.setAttribute("listPage", pageUtil.getListPaging(page));
		request.setAttribute("pageNow", page);
		request.setAttribute("pageFirst", 1);
		request.setAttribute("pageLast", pageUtil.getSumOfPage());
		request.setAttribute("pagePrev", pageUtil.getPagePrev());
		request.setAttribute("pageNext", pageUtil.getPageNext());
	}

}
