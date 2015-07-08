package prime.admin.division;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.user.UserBean;
import prime.constants.Constants;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class DivisionAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		DivisionForm pForm = (DivisionForm) form;
		DivisionManager tmpManager = new DivisionManagerImpl();
		request.setAttribute("homepage", request.getSession().getAttribute(Constants.Session.lastPage));
		if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##. Add Data
			return mapping.findForward("add");
		} else if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			//##. Edit Data
			pForm.setDivisionBean(tmpManager.getDivisionById(pForm.getTmpId()));
			return mapping.findForward("edit");
		} else if(Constants.Task.DOADD.equals(pForm.getTask())) {
			//##.Insert Data and Go to Forward
			pForm.getDivisionBean().setUpdateBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
			pForm.getDivisionBean().setDivisionId(tmpManager.getNewId());
			tmpManager.insert(pForm.getDivisionBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOEDIT.equals(pForm.getTask())) {
			//##.Update Data and Go to Forward
			pForm.getDivisionBean().setUpdateBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
			tmpManager.update(pForm.getDivisionBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DODELETE.equals(pForm.getTask())) {
			//##.Delete Data and Back Main
			tmpManager.delete(pForm.getTmpId());
			return mapping.findForward("forward");
		} 
		
		int countRows  = tmpManager.getCountByColumn(pForm.getColumnSearchReal(), pForm.getSearch());
		List<DivisionBean> list = tmpManager.getListByColumn(pForm.getColumnSearchReal(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
		
		//##1.Attribute for Table Show
		request.setAttribute("listDivision", list);
		request.setAttribute("listSearchColumn", Constants.Search.DIVISION_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
		setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, DivisionForm pForm, int countRows, int page, int view)
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
