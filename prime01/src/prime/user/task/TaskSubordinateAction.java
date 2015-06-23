package prime.user.task;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.employee.EmployeeBean;
import prime.admin.employee.EmployeeManager;
import prime.admin.employee.EmployeeManagerImpl;
import prime.constants.Constants;
import prime.user.activity.ActivityBean;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class TaskSubordinateAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		TaskSubordinateForm pForm = (TaskSubordinateForm) form;
		TaskManager manager = new TaskManagerImpl();
		EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
		ActivityManager tmpActivityManager = new ActivityManagerImpl();

		if (Constants.Task.TASK.GOTOSUBMIT.equals(pForm.getTask())) {
			//##.Submit Data
			pForm.setTaskBean(manager.getTaskById(pForm.getTaskId()));
			return mapping.findForward("submit");
		} else if (Constants.Task.GOTOVIEW.equals(pForm.getTask())) {
			//##.View Detail Task
			pForm.setTaskBean(manager.getTaskById(pForm.getTaskId()));
			int countRows = tmpActivityManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch(), pForm.getTaskId());
			List<ActivityBean> list = tmpActivityManager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getTaskId());
			request.setAttribute("listActivity", list);
			request.setAttribute("listSearchColumn", Constants.Search.ACTIVITY_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			
			System.out.println("cek:"+tmpActivityManager.isAllFinished(pForm.getTaskId())+"||"+pForm.getTaskId());
			request.setAttribute("isSubmit", tmpActivityManager.isAllFinished(pForm.getTaskId()));
			return mapping.findForward("taskDetail");
		} else if (Constants.Task.ACTIVITY.GOTOADD.equals(pForm.getTask())) {
			//##.Add Data
			pForm.getActivityBean().setActivityId(tmpActivityManager.getNewId());
			pForm.getActivityBean().setTaskId(pForm.getTaskBean().getTaskId());
			pForm.getActivityBean().setActivityStatus(Constants.Status.CREATE);
			return mapping.findForward("addActivity");
		} else if (Constants.Task.ACTIVITY.GOTOEDIT.equals(pForm.getTask())) {
			//##.Add Data
			pForm.setActivityBean(tmpActivityManager.getActivityById(pForm.getActivityId()));
			return mapping.findForward("editActivity");
		} else if (Constants.Task.ACTIVITY.GOTOCHANGESTATUS.equals(pForm.getTask())) {
			//##.Change Data
			request.setAttribute("listStatus", Constants.Status.LIST_STATUSACTIVITY);
			pForm.setActivityBean(tmpActivityManager.getActivityDetailById(pForm.getActivityId(), pForm.getActivityChangeDate()));
			pForm.getActivityBean().setActivityChangeNote(null);
			
			int countRows = tmpActivityManager.getCountActivityDetail(pForm.getColumnSearch(), pForm.getSearch(), pForm.getActivityId());
			List<ActivityBean> list = tmpActivityManager.getListActivityDetail(pForm.getColumnSearch(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getActivityId());
			request.setAttribute("listActivity", list);
			request.setAttribute("listSearchColumn", Constants.Search.ACTIVITY_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("changeStatusActivity");
		} else if (Constants.Task.TASK.DOSUBMIT.equals(pForm.getTask())) {
			//##.Submit Task
			manager.insertDetail(pForm.getTaskBean());
			return mapping.findForward("forward");
		} else if (Constants.Task.ACTIVITY.DOADD.equals(pForm.getTask())) {
			//##.Insert Data Activity
			tmpActivityManager.insert(pForm.getActivityBean());
			tmpActivityManager.insertDetail(pForm.getActivityBean());
			pForm.setTaskId(pForm.getActivityBean().getTaskId());
			return mapping.findForward("forward");
		} else if (Constants.Task.ACTIVITY.DOEDIT.equals(pForm.getTask())) {
			//##.Update Data Activity
			tmpActivityManager.update(pForm.getActivityBean());
			pForm.setTaskId(pForm.getActivityBean().getTaskId());
			return mapping.findForward("forward");
		} else if (Constants.Task.ACTIVITY.DOCHANGESTATUS.equals(pForm.getTask())) {
			//##.Insert Data Detail
			pForm.getActivityBean().setActivityStatus(pForm.getActivityStatus());
			tmpActivityManager.insertDetail(pForm.getActivityBean());
			return mapping.findForward("forward");
		} 
		
		int countRows  = manager.getCountByColumnSubordinate(pForm.getColumnSearch(), pForm.getSearch(), 100);
		List<TaskBean> list = manager.getListByColumnSubordinate(pForm.getColumnSearch(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows), 
				100);
		
		request.setAttribute("listTask", list);
		request.setAttribute("listSearchColumn", Constants.Search.TASK_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
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
