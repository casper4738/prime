package prime.admin.division;

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

public class DivisionAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		DivisionForm divisionForm = (DivisionForm) form;
		DivisionManager manager = new DivisionManagerImpl();
		
		int countRows  = manager.getCountByColumn(divisionForm.getColumnSearch(), divisionForm.getSearch());
		List<DivisionBean> list = manager.getListByColumn(divisionForm.getColumnSearch(), divisionForm.getSearch(),
				PrimeUtil.getStartRow(divisionForm.getGoToPage(), divisionForm.getShowInPage()),  
				PrimeUtil.getEndRow(divisionForm.getGoToPage(), divisionForm.getShowInPage(), countRows));
		
		request.setAttribute("listDivision", list);

		setPaging(request, countRows, divisionForm.getGoToPage(), divisionForm.getShowInPage());
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
