package prime.user.report.employees;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.employee.EmployeeManager;
import prime.admin.employee.EmployeeManagerImpl;
import prime.constants.Constants;
import prime.user.project.ProjectBean;
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
		
		ReportEmployeesForm pForm = (ReportEmployeesForm) form;
		ReportEmployeesManager tmpManager = new ReportEmployeesManagerImpl();
		EmployeeManager tmpEmployeeManager 	= new EmployeeManagerImpl();
		TaskManager 	tmpTaskManager 		= new TaskManagerImpl();
		
		if(Constants.Task.REPORT.GOTOTDETAILEMPLOYEE.equals(pForm.getTask())){
			//##. Get Data
			pForm.setEmployeeBean(tmpEmployeeManager.getEmployeeById(pForm.getEmployeeId()));
			pForm.setProjectBean(tmpProjectManager.getProjectById(pForm.getProjectId()));
			pForm.setTaskBean(tmpTaskManager.getTaskById());
			pForm.getProjectBean().setEmployeeId(pForm.getEmployeeBean().getEmployeeId());
			pForm.getProjectBean().setEmployeeName(pForm.getEmployeeBean().getEmployeeName());
			
			int countRows = tmpProjectManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<ProjectBean> list =tmpProjectManager.getListProjectMemberDetails(pForm.getColumnSearch(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getEmployeeId());
			
			//##. Set Attribute
			request.setAttribute("listProjectMemberDetails", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			request.setAttribute("isAddTaskActive" , tmpRoleManager.getRolesByEmployeeIdAndProjectId(pForm.getProjectBean().getEmployeeId(),  pForm.getProjectBean().getProjectId()).size());
			
			
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());			
			
			return mapping.findForward("detailMember");
		}

		int countRows = tmpManager.getCountByColumn(pForm.getColumnSearch(),
				pForm.getSearch());
		List<ReportEmployeesBean> list = tmpManager.getListByColumn(
				pForm.getColumnSearch(), pForm.getSearch(), PrimeUtil
						.getStartRow(pForm.getGoToPage(),
								pForm.getShowInPage(), countRows), PrimeUtil
						.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
								countRows));
		
		// ##1.Attribute for Table Show
		request.setAttribute("listReportEmployees", list);
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
