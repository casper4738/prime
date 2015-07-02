package prime.user.report.project;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;
import prime.login.LoginData;
import prime.user.project.ProjectBean;
import prime.user.project.ProjectManager;
import prime.user.project.ProjectManagerImpl;
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

		Integer tmpEmployeeId = Integer.valueOf(LoginData.getEmployeeData().getEmployeeId());
		TaskManager tmpTaskManager = new TaskManagerImpl();

		ReportProjectForm pForm = (ReportProjectForm) form;
		// ReportProjectManager tmpManager = new ReportProjectManagerImpl();

		ProjectManager tmpManager = new ProjectManagerImpl();
		System.out.println(pForm.getTask());

		if (Constants.Task.REPORT.GOTODETAILPROJECT.equals(pForm.getTask())) {
			// ##. Get Data
			String search = "";
			if ("STARTDATE".equals(pForm.getColumnSearch())
					|| "ESTIMATEDATE".equals(pForm.getColumnSearch())) {
				search = pForm.getStartDate() + ";" + pForm.getUntilDate();
			} else {
				search = pForm.getSearch();
			}

			//pForm.setReportProjectBean(tmpManager.getProjectById(pForm.getProjectId()));
			//pForm.setProjectBean(tmpManager.getProjectById(pForm.getProjectId()));
			int countRows = tmpTaskManager.getCountListByProjectId(
					pForm.getColumnSearchReal(), search, pForm.getProjectId());
			List<TaskBean> list = tmpTaskManager.getListByProjectId(
					pForm.getColumnSearchReal(),
					search,
					PrimeUtil.getStartRow(pForm.getGoToPage(),
							pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),
							pForm.getShowInPage(), countRows),
					pForm.getProjectId());

			request.setAttribute("listTask", list);
			request.setAttribute("listSearchColumn",
					Constants.Search.TASK_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries", Constants.PAGINGROWPAGE);
			setPaging(request, pForm, countRows, pForm.getGoToPage(),
					pForm.getShowInPage());
			return mapping.findForward("detailProject");
		} else if (Constants.Task.REPORT.GENERATEREPORTPROJECT.equals(pForm
				.getTask())) {
			System.out.println(pForm.getColumnSearchReal());
			if ("NAME".equals(pForm.getColumnSearchReal())) {
				System.out.println(pForm.getColumnSearchReal());
				request.getSession(true).setAttribute(
						"searchQuery",
						" WHERE LOWER (PROJECT_NAME) LIKE LOWER ('%"
								+ pForm.getSearch() + "%')");
			} else if ("DESCRIPTION".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute(
						"searchQuery",
						" WHERE LOWER (PROJECT_DESCRIPTION) LIKE LOWER ('%"
								+ pForm.getSearch() + "%')");
			} else if ("PROPOSED".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute(
						"searchQuery",
						" WHERE LOWER (EMPAPRO.EMPLOYEE_NAME) LIKE LOWER ('%"
								+ pForm.getSearch() + "%')");
			} else if ("PM".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute(
						"searchQuery",
						" WHERE LOWER (EMPRPRO.EMPLOYEE_NAME) LIKE LOWER ('%"
								+ pForm.getSearch() + "%')");
			} else if ("STARTDATE".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute(
						"searchQuery",
						" WHERE PROJ.PROJECT_START_DATE BETWEEN TO_DATE("+ pForm.getSearch() +", 'yyyy-mm-dd') AND TO_DATE("+pForm.getSearch()+", 'yyyy-mm-dd')");
			} else if ("ESTIMATEDATE".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute(
						"searchQuery",
						" WHERE LOWER (EMPRPRO.EMPLOYEE_NAME) LIKE LOWER ('%"
								+ pForm.getSearch() + "%')");
			}
			return mapping.findForward("showReportProject");
		} else if (Constants.Task.REPORT.GENERATEREPORTPROJECTTASK.equals(pForm
				.getTask())) {

			return mapping.findForward("showReportProjectTask");
		}

		String search = "";
		if ("STARTDATE".equals(pForm.getColumnSearch())
				|| "ESTIMATEDATE".equals(pForm.getColumnSearch())) {
			search = pForm.getStartDate() + ";" + pForm.getUntilDate();
		} else {
			search = pForm.getSearch();
		}		
	
		//pForm.getProjectBean().setIsAssigner(tmpManager.getCountProjectAssigner(tmpEmployeeId));
		
		List<ProjectBean> list = new ArrayList<ProjectBean>();
		System.out.println("colom "+pForm.getColumnSearchReal());
		System.out.println("search "+search);
		int countRows  = tmpManager.getCountListByColAsHead(pForm.getColumnSearchReal(), search, tmpEmployeeId);
		list = tmpManager.getListByColumnAsHead(pForm.getColumnSearchReal(), search,
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows), tmpEmployeeId);
		
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
