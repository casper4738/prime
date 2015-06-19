package prime.user.task;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;




import prime.user.activity.ActivityBean;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class TaskAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TaskForm pForm = (TaskForm) form;
		TaskManager manager = new TaskManagerImpl();

		if ("add".equals(pForm.getTask())) {
			pForm.getTaskBean().setTaskId(manager.getNewId());
		
			return mapping.findForward("add");
		} else if ("insert".equals(pForm.getTask())) {
			manager.insert(pForm.getTaskBean());
			return mapping.findForward("forward");
		}else if ("choose".equals(pForm.getTask())) {
			return mapping.findForward("selfAssign");
		}else if ("choose2".equals(pForm.getTask())) {
			return mapping.findForward("subordinate");
		} else if ("goToTaskDetails".equals(pForm.getTask())) {
			pForm.setTaskBean(manager.getTaskById(pForm.getTaskId()));
			int countRows = manager.getCountByColumn(pForm.getColumnSearch(),
					pForm.getSearch());
			
			ActivityManager tmpActivityManager = new ActivityManagerImpl();
			List<ActivityBean> list = tmpActivityManager.getListByColumn(pForm
					.getColumnSearch(), pForm.getSearch(), PrimeUtil.getStartRow(
					pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),
							pForm.getShowInPage(), countRows));
			request.setAttribute("listActivity", list);
			setPaging(request, pForm, countRows, pForm.getGoToPage(),
					pForm.getShowInPage());
			return mapping.findForward("taskDetails");
		}  else if ("submitTask".equals(pForm.getTask())) {
			pForm.getTaskBean().setTaskDescription(null);
			pForm.setTaskBean(manager.getTaskById(pForm.getTaskId()));
			return mapping.findForward("submit");
		} 
		
		int countRows  = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
		List<TaskBean> list = manager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
		
		request.setAttribute("listTask", list);
		setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		return mapping.findForward("success");
	}

	private void setPaging(HttpServletRequest request, TaskForm pForm,
			int countRows, int page, int view) throws SQLException {
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

		pForm.setGoToPage(pageUtil.getPage());
	}
}
