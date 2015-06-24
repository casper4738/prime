package prime.user.task;

import java.sql.Date;
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

public class TaskHeadAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int employeeId = 100;
		
		TaskHeadForm pForm = (TaskHeadForm) form;
		TaskManager manager = new TaskManagerImpl();
		EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
		ActivityManager tmpActivityManager = new ActivityManagerImpl();

		if (Constants.Task.TASK.GOTOTASKTYPE.equals(pForm.getTask())) {
			pForm.getTaskBean().setTaskId(manager.getNewId());
			
			int countRows  = tmpEmployeeManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<EmployeeBean> list = tmpEmployeeManager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
			
			//##Attribute for Table Show
			request.setAttribute("listEmployee",list);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			request.setAttribute("listSearchColumn", Constants.Search.EMPLOYEE_SEARCHCOLUMNS);
			setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("chooseType");
		} else if (Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##.Get Data
			EmployeeBean tmpTaskAssign 	= tmpEmployeeManager.getEmployeeById(employeeId);
			EmployeeBean tmpTaskReceive = tmpEmployeeManager.getEmployeeById(pForm.getTaskReceiver());

			//##.Add Data
			pForm.getTaskBean().setTaskAssigner(tmpTaskAssign.getEmployeeId());
			pForm.getTaskBean().setTaskReceiver(tmpTaskReceive.getEmployeeId());
			pForm.getTaskBean().setTaskAssignerName(tmpTaskAssign.getEmployeeName());
			pForm.getTaskBean().setTaskReceiverName(tmpTaskReceive.getEmployeeName());
			
			return mapping.findForward("add");
		} else if (Constants.Task.TASK.GOTOSUBMIT.equals(pForm.getTask())) {
			//##.Add Data
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
			request.setAttribute("isAllFinished", tmpActivityManager.isAllFinished(pForm.getTaskId()));
			request.setAttribute("isAlreadySubmit", manager.isCheckStatus(pForm.getTaskId(), Constants.Status.SUBMIT));
			request.setAttribute("isAlreadyReject", manager.isCheckStatus(pForm.getTaskId(), Constants.Status.REJECT));
			setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
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
			pForm.setActivityBean(tmpActivityManager.getActivityDetailById(pForm.getActivityId(), pForm.getActivityChangeDate()));
			
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
		} else if (Constants.Task.DOADD.equals(pForm.getTask())) {
			//##. Insert Data
			pForm.getTaskBean().setTaskId(manager.getNewId());
			pForm.getTaskBean().setTaskStatus(Constants.Status.CREATE);
			pForm.getTaskBean().setTaskChangeNote("");
			pForm.getTaskBean().setProjectMemberId(0);
			manager.insert(pForm.getTaskBean());
			manager.insertDetail(pForm.getTaskBean());
			return mapping.findForward("forward");
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
			System.out.println("id-----------------");
			System.out.println("id:"+pForm.getActivityBean().getActivityId());
			System.out.println("id:"+pForm.getActivityBean().getActivityName());
			System.out.println("id:"+pForm.getActivityBean().getActivityDescription());
			System.out.println("id:"+pForm.getActivityBean().getTaskId());
			tmpActivityManager.update(pForm.getActivityBean());
			return mapping.findForward("forward");
		} else if (Constants.Task.ACTIVITY.DOCHANGESTATUS.equals(pForm.getTask())) {
			//##.Insert Task Data Detail
			if(pForm.getActivityStatus() == Constants.Status.PROGRESS) {
				TaskBean bean = new TaskBean();
				bean.setTaskId(pForm.getTaskId());
				bean.setTaskStatus(Constants.Status.PROGRESS);
				bean.setTaskChangeNote("");
				manager.insertDetail(bean);
			}
			//##.Insert Activity Data Detail
			pForm.getActivityBean().setActivityStatus(pForm.getActivityStatus());
			tmpActivityManager.insertDetail(pForm.getActivityBean());
			return mapping.findForward("forward");
		} else if (Constants.Task.TASK.DOAPPROVAL.equals(pForm.getTask())) {
			//##.Approval Task
			pForm.getTaskBean().setTaskStatus(Constants.Status.APPROVAL);
			pForm.getTaskBean().setTaskChangeNote("");
			manager.insertDetail(pForm.getTaskBean());
			return mapping.findForward("forward");
		} else if (Constants.Task.TASK.DOABORT.equals(pForm.getTask())) {
			//##.Abort Task
			manager.insertDetail(pForm.getTaskBean());
			return mapping.findForward("forward");
		} 
		
		int countRows  = manager.getCountByColumnHead(pForm.getColumnSearch(), pForm.getSearch(), employeeId);
		List<TaskBean> list = manager.getListByColumnHead(pForm.getColumnSearch(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows), 
				employeeId);
		
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
