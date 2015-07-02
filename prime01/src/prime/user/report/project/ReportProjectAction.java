package prime.user.report.project;
 
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

public class ReportProjectAction extends Action { 
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
//		ReportEmployeesForm pForm = (ReportEmployeesForm) form;
//		ReportEmployeesManager tmpManager = new ReportEmployeesManagerImpl();
		TaskManager 	tmpTaskManager 		= new TaskManagerImpl();
		
		ReportProjectForm pForm = (ReportProjectForm) form;
		ReportProjectManager tmpManager = new ReportProjectManagerImpl();
		System.out.println(pForm.getTask());
		
		if(Constants.Task.REPORT.GOTODETAILPROJECT.equals(pForm.getTask())){
			//##. Get Data
			pForm.setReportProjectBean(tmpManager.getProjectById(pForm.getProjectId()));
			int countRows  = tmpTaskManager.getCountByColumnSubordinate(pForm.getColumnSearch(), pForm.getSearch(), pForm.getProjectId());
			List<TaskBean> list = tmpTaskManager.getListByColumnSubordinate(pForm.getColumnSearch(), pForm.getSearch(),
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows), 
					pForm.getProjectId());
			
			request.setAttribute("listTask", list);
			request.setAttribute("listSearchColumn", Constants.Search.TASK_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());			
			return mapping.findForward("detailProject");
		} else if (Constants.Task.REPORT.GENERATEREPORTPROJECT.equals(pForm.getTask())) {
			System.out.println(pForm.getColumnSearch());
			if ("NAME".equals(pForm.getColumnSearch())) {
				System.out.println(pForm.getSearch());
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (PROJECT_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			}
			else if ("DESCRIPTION".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (PROJECT_DESCRIPTION) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			}
			else if ("PROPOSED".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (EMPAPRO.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			}
			else if ("PM".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (EMPRPRO.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			}
			return mapping.findForward("showReportProject");
		} else if (Constants.Task.REPORT.GENERATEREPORTPROJECTTASK.equals(pForm.getTask())) {
			
			return mapping.findForward("showReportProjectTask");
		}

		int countRows = tmpManager.getCountByColumn(pForm.getColumnSearch(),
				pForm.getSearch());
		List<ReportProjectBean> list = tmpManager.getListByColumn(
				pForm.getColumnSearch(), pForm.getSearch(), PrimeUtil
						.getStartRow(pForm.getGoToPage(),
								pForm.getShowInPage(), countRows), PrimeUtil
						.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
								countRows));
		
		// ##1.Attribute for Table Show
		request.setAttribute("listReportProject", list);
		request.setAttribute("listSearchColumn",
				Constants.Search.REPORTPROJECT_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries", Constants.PAGINGROWPAGE);
		setPaging(request, pForm, countRows, pForm.getGoToPage(),
				pForm.getShowInPage());
		
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, ReportProjectForm pForm,
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
