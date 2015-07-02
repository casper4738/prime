package prime.user.report.employees;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;
import prime.user.task.TaskBean;
import prime.user.task.TaskManager;
import prime.user.task.TaskManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class ReportEmployeesAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		//NotificationForm pForm = (NotificationForm) form;
		//NotificationManager tmpManager = new NotificationManagerImpl();
		String tmpMapTarget="";
		ReportEmployeesForm pForm = (ReportEmployeesForm) form;
		ReportEmployeesManager tmpManager = new ReportEmployeesManagerImpl();
		TaskManager 	tmpTaskManager 		= new TaskManagerImpl();
		
		
		if(Constants.Task.REPORT.GOTODETAILEMPLOYEE.equals(pForm.getTask())){
			//##. Get Data
			pForm.setReportEmployeesBean(tmpManager.getEmployeeById(pForm.getEmployeeId()));
			int countRows  = tmpTaskManager.getCountByColumnSubordinate(pForm.getColumnSearch(), pForm.getSearch(), pForm.getEmployeeId());
			
			List<TaskBean> list = tmpTaskManager.getListByColumnSubordinate(pForm.getColumnSearch(), pForm.getSearch(),
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows), 
					pForm.getEmployeeId());
			
			request.setAttribute("listTask", list);
			request.setAttribute("listSearchColumn", Constants.Search.TASK_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());			
			return mapping.findForward("detailEmployee");
		}
		
		else if(Constants.Task.REPORT.GENERATEREPORTEMPLOYEE.equals(pForm.getTask())){
			if("ID".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE EMP.EMPLOYEE_ID LIKE ('%" + pForm.getSearch()+ "%')");				
			} else if ("NAME".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER(EMP.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");	
			} else if ("EMAIL".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER(EMP.EMAIL) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("DIVISION".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (DIV.DIVISION_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("POSITION".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (POS.POSITION_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("MANAGER".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (EMPMGR.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} 
			
			return mapping.findForward("showReportEmployee");
		} else if (Constants.Task.REPORT.GENERATEREPORTEMPLOYEETASK.equals(pForm.getTask())) {
			
			return mapping.findForward("showReportEmployeeTask");
		}

		int countRows = tmpManager.getCountByColumn(pForm.getColumnSearchReal(),
				pForm.getSearch());
		List<ReportEmployeesBean> list = tmpManager.getListByColumn(
				pForm.getColumnSearchReal(), pForm.getSearch(), PrimeUtil
						.getStartRow(pForm.getGoToPage(),
								pForm.getShowInPage(), countRows), PrimeUtil
						.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
								countRows));
		
		// ##1.Attribute for Table Show
		request.setAttribute("listReportEmployees", list);
		request.setAttribute("listSearchColumnEmployeeTask", Constants.Search.TASK_SEARCHCOLUMNS);
		request.setAttribute("listSearchColumn",
				Constants.Search.REPORTEMPLOYEE_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries", Constants.PAGINGROWPAGE);
		setPaging(request, pForm, countRows, pForm.getGoToPage(),
				pForm.getShowInPage());
		
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, ReportEmployeesForm pForm,
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
