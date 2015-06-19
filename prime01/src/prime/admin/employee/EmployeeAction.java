package prime.admin.employee;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.division.DivisionBean;
import prime.admin.division.DivisionManager;
import prime.admin.division.DivisionManagerImpl;
import prime.admin.position.PositionManager;
import prime.admin.position.PositionManagerImpl;
import prime.constants.Constants;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class EmployeeAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		EmployeeForm pForm = (EmployeeForm) form;
		EmployeeManager manager = new EmployeeManagerImpl();
		DivisionManager tmpDivisionManager = new DivisionManagerImpl();
		PositionManager tmpPositionManager = new PositionManagerImpl();
		
		if(Constants.Task.GOTOMANAGER.equals(pForm.getTask())) {
			//##. Choose Manager or Head
			request.setAttribute("listDivision", tmpDivisionManager.getListAll());
			int countRows  = manager.getCountByColumnAndDivision(pForm.getColumnSearch(), pForm.getSearch(), pForm.getEmployeeBean().getDivisionId());
			
			List<EmployeeBean> list = manager.getListByColumnAndDivision(pForm.getColumnSearch(), pForm.getSearch(), pForm.getEmployeeBean().getDivisionId(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
			
			//##Attribute table 
			request.setAttribute("listEmployee", list);
			request.setAttribute("listSearchColumn", Constants.Search.POSITION_SEARCHCOLUMNS);
			setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("choose_manager");
		} else if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##. Get Data
			DivisionBean tmpDivision = tmpDivisionManager.getDivisionById(pForm.getEmployeeBean().getDivisionId());
			EmployeeBean tmpManager = manager.getEmployeeById(pForm.getManagerId());

			pForm.getEmployeeBean().setEmployeeId(manager.getNewId());
			pForm.getEmployeeBean().setDivisionId(tmpDivision.getDivisionId());
			pForm.getEmployeeBean().setDivisionName(tmpDivision.getDivisionName());

			pForm.getEmployeeBean().setManagerId(tmpManager.getEmployeeId());
			pForm.getEmployeeBean().setManagerName(tmpManager.getEmployeeName());
			
			request.setAttribute("listPosition", tmpPositionManager.getListAll());
			
			//##. Add Data
			return mapping.findForward("add");
		} else if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			return mapping.findForward("add");
		} else if(Constants.Task.DOADD.equals(pForm.getTask())) {
			manager.insert(pForm.getEmployeeBean());
			return mapping.findForward("forward");
		}
		
		int countRows  = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
		List<EmployeeBean> list = manager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));

		//##1.Attribute for Table Show
		request.setAttribute("listEmployee", list);
		request.setAttribute("listSearchColumn", Constants.Search.POSITION_SEARCHCOLUMNS);

		setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, int countRows, int page, int view)
			throws SQLException {
		//##2.Paging Handling
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
		request.setAttribute("listMaxDataPerPage", Constants.PAGINGROWPAGE);
	}

}
