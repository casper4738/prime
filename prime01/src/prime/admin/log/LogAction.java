package prime.admin.log;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class LogAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LogForm pForm 			 = (LogForm) form;
		LogManager tmpLogManager = new LogManagerImpl();
		
		String search = "";
		if("DATE".equals(pForm.getColumnSearch())) {
			search = pForm.getStartHoliday()+";"+pForm.getUntilHoliday();
		} else if("TABLE".equals(pForm.getColumnSearch())) {
			search = pForm.getSearchTableLog();
		} else {
			search = pForm.getSearch();
		}
		
		System.out.println(pForm.getColumnSearch()+" | "+search);

		int countRows = tmpLogManager.getCountByColumn(pForm.getColumnSearchReal(), search);
		List<LogBean> list = tmpLogManager.getListByColumn(pForm.getColumnSearchReal(), search, 
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows), 
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
		
		// ##1.Attribute for Table Show
		request.setAttribute("listLog", list);
		request.setAttribute("listSearchColumn", Constants.Search.LOG_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries", Constants.PAGINGROWPAGE);
		request.setAttribute("listTableLog", Constants.Search.TABLELOG_SEARCHCOLUMNS);
		setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		
		return mapping.findForward("success");
	}

	private void setPaging(HttpServletRequest request, LogForm pForm,
			int countRows, int page, int view) throws SQLException {
		// ##2.Paging Handling
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
