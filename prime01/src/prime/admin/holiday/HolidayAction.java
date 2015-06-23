package prime.admin.holiday;

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

public class HolidayAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HolidayForm pForm = (HolidayForm) form;
		HolidayManager tmpManager = new HolidayManagerImpl();
		
		if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##. Add Data
			pForm.getHolidayBean().setHolidayDate(new java.sql.Date(new java.util.Date().getTime()));
			return mapping.findForward("add");
		} else if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			//##. Edit Data
			pForm.setHolidayBean(tmpManager.getHolidayById(pForm.getTmpId()));
			return mapping.findForward("edit");
		} else if(Constants.Task.DOADD.equals(pForm.getTask())) {
			//##.Insert Data and Go to Forward
			tmpManager.insert(pForm.getHolidayBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOEDIT.equals(pForm.getTask())) {
			//##.Update Data and Go to Forward
			tmpManager.update(pForm.getHolidayBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DODELETE.equals(pForm.getTask())) {
			//##.Delete Data and Back Main
			tmpManager.delete(pForm.getTmpId());
			return mapping.findForward("forward");
		}
		
		int countRows  = tmpManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
		List<HolidayBean> list = tmpManager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
		
		//##1.Attribute for Table Show
		request.setAttribute("listHoliday", list);
		request.setAttribute("listSearchColumn", Constants.Search.HOLIDAY_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
		setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, HolidayForm pForm, int countRows, int page, int view)
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
