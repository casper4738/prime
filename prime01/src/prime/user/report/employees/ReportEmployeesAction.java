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
		
		ReportEmployeesForm pForm = (ReportEmployeesForm) form;
		ReportEmployeesManager tmpManager = new ReportEmployeesManagerImpl();
		
		if(Constants.Task.REPORT.GOTODETAILEMPLOYEE.equals(pForm.getTask())){
			//##. Get Data
			String search = "";
			System.out.println(pForm.getColumnSearch()+"--pForm.getColumnSearch()");
			if("STARTDATE".equals(pForm.getColumnSearch()) || "ESTIMATEDATE".equals(pForm.getColumnSearch())) {
				search = pForm.getStartDate()+";"+pForm.getUntilDate();
			} else {
				search = pForm.getSearch();
			}
			
			System.out.println(search+"--search");
			pForm.setReportEmployeesBean(tmpManager.getEmployeeById(pForm.getEmployeeId()));
			int countRows  = tmpManager.getCountListEmployeeTaskReport(pForm.getColumnSearchReal(), search, pForm.getEmployeeId());
			
			List<TaskBean> list = tmpManager.getListEmployeeTaskReport(pForm.getColumnSearchReal(), search,
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
			if("ID".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE EMP.EMPLOYEE_ID LIKE ('%" + pForm.getSearch()+ "%')");				
			} else if ("NAME".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER(EMP.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");	
				request.getSession(true).setAttribute("searchQuery2", " WHERE LOWER(EMP.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");	
			} else if ("EMAIL".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER(EMP.EMAIL) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("DIVISION".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (DIV.DIVISION_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("POSITION".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (POS.POSITION_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("MANAGER".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (EMPMGR.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("GENDER".equals(pForm.getColumnSearchReal())) {
				System.out.println("ADA");
				System.out.println(pForm.getSearch());
				request.getSession(true).setAttribute("searchQuery", " WHERE GENDER = '"+pForm.getGenderSearch()+"'");
			} else if ("STATUS".equals(pForm.getColumnSearch())) {
				System.out.println("ADA1"+pForm.getStatusSearch());
				request.getSession(true).setAttribute("searchQuery", " WHERE (CASE WHEN NVL(TO_CHAR(RE.RESIGN_DATE, 'yyyy-mm-dd'), '0') = '0' THEN 0 ELSE 1 END) = '"+pForm.getStatusSearch()+"'");
			} 
			
			return mapping.findForward("showReportEmployee");
		} else if (Constants.Task.REPORT.GENERATEREPORTEMPLOYEETASK.equals(pForm.getTask())) {
			
			return mapping.findForward("showReportEmployeeTask");
		}

		String search = "";
		if("GENDER".equals(pForm.getColumnSearchReal())) {
			search = pForm.getGenderSearch();
		} else if("STATUS".equals(pForm.getColumnSearchReal())) {
			search = pForm.getStatusSearch();
		} else {
			search = pForm.getSearch();			
		}
		
		int countRows = tmpManager.getCountByColumn(pForm.getColumnSearchReal(),
				search);
		List<ReportEmployeesBean> list = tmpManager.getListByColumn(
				pForm.getColumnSearchReal(), search, PrimeUtil
						.getStartRow(pForm.getGoToPage(),
								pForm.getShowInPage(), countRows), PrimeUtil
						.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
								countRows));
		
		// ##1.Attribute for Table Show
		request.setAttribute("listReportEmployees", list);
		request.setAttribute("listSearchColumnEmployeeTask", Constants.Search.TASK_SEARCHCOLUMNS);
		request.setAttribute("listSearchColumn",
				Constants.Search.EMPLOYEE_SEARCHCOLUMNS);
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
