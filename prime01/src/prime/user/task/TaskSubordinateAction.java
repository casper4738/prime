package prime.user.task;

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
import prime.login.LoginData;
import prime.user.activity.ActivityBean;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
import prime.user.project.ProjectBean;
import prime.user.project.ProjectManager;
import prime.user.project.ProjectManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class TaskSubordinateAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//---.[Dedy] Hardcoded a little bit for Notification Jump
		request.getSession().setAttribute(Constants.Session.needRedirect, false);
				
		int employeeId = LoginData.getUserData().getEmployeeId();
		request.setAttribute("employeeIdActive", employeeId);
		
		TaskSubordinateForm pForm = (TaskSubordinateForm) form;
		TaskManager manager = new TaskManagerImpl();
		EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
		ActivityManager tmpActivityManager = new ActivityManagerImpl();
		
		
		System.out.println("task:"+pForm.getTask());

		if (Constants.Task.TASK.GOTOSUBMIT.equals(pForm.getTask())) {
			//##.Submit Data
			pForm.setTaskBean(manager.getTaskById(pForm.getTaskId()));
			return mapping.findForward("submit");
		} else if (Constants.Task.GOTOVIEW.equals(pForm.getTask())) {
			//##.View Detail Task
			pForm.setTaskBean(manager.getTaskById(pForm.getTaskId()));
			int countRows = tmpActivityManager.getCountByColumn(pForm.getColumnSearchReal(), pForm.getSearch(), pForm.getTaskId());
			List<ActivityBean> list = tmpActivityManager.getListByColumn(pForm.getColumnSearchReal(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getTaskId());
			request.setAttribute("listActivity", list);
			request.setAttribute("listSearchColumn", Constants.Search.ACTIVITY_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			System.out.println("cek:"+pForm.getTaskId()+" - "+ tmpActivityManager.isAllFinished(pForm.getTaskId()));
			request.setAttribute("isAllFinished", tmpActivityManager.isAllFinished(pForm.getTaskId()));
			request.setAttribute("isAlreadySubmit", manager.isCheckStatus(pForm.getTaskId(), Constants.Status.SUBMIT));
			request.setAttribute("isAlreadyReject", manager.isCheckStatus(pForm.getTaskId(), Constants.Status.REJECT));
			request.setAttribute("isAlreadyApprove", manager.isCheckStatus(pForm.getTaskId(), Constants.Status.APPROVAL));
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
			
			System.out.println("1. "+pForm.getActivityId());
			System.out.println("2. "+pForm.getActivityChangeDate());
			
			pForm.setActivityBean(tmpActivityManager.getActivityDetailById(pForm.getActivityId(), pForm.getActivityChangeDate()));
			pForm.getActivityBean().setActivityChangeNote("");
			
			int countRows = tmpActivityManager.getCountActivityDetail(pForm.getColumnSearchReal(), pForm.getSearch(), pForm.getActivityId());
			List<ActivityBean> list = tmpActivityManager.getListActivityDetail(pForm.getColumnSearchReal(), pForm.getSearch(), 
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
			pForm.getTaskBean().setTaskStatus(Constants.Status.SUBMIT);
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
			//##.Insert Task Data Detail
			if(!manager.isCheckStatusDetail(pForm.getTaskId(), Constants.Status.PROGRESS)) {
				System.out.println("1. ");
				System.out.println("2. ");
				TaskBean bean = new TaskBean();
				bean.setTaskId(pForm.getTaskId());
				bean.setTaskStatus(Constants.Status.PROGRESS);
				bean.setTaskChangeNote("");
				manager.insertDetail(bean);
				manager.updateActualStart(pForm.getTaskId(), new java.sql.Date(new java.util.Date().getTime()));
				try {
					ProjectManager tmpProjectManager = new ProjectManagerImpl();
					ProjectBean e = tmpProjectManager.getProjectByTaskId(pForm.getTaskId());
					tmpProjectManager.updateActualStart(e.getProjectId(), new java.sql.Date(new java.util.Date().getTime()));
				} catch(Exception e) {
					System.out.println("Actual Start - Task Id . "+pForm.getTaskId());
					System.out.println("Terjadi kesalahan : "+e.getMessage());					
				}
			}
			//##.Insert Activity Data Detail
			pForm.getActivityBean().setActivityStatus(pForm.getActivityStatus());
			tmpActivityManager.insertDetail(pForm.getActivityBean());
			return mapping.findForward("forward");
		} else if (Constants.Task.TASK.DOAPPROVAL.equals(pForm.getTask())) {
			//##.Approval Task
			pForm.getTaskBean().setTaskStatus(Constants.Status.APPROVAL);
			pForm.getTaskBean().setTaskChangeNote("");
			
			try {
				manager.updateActualEnd(pForm.getTaskBean().getTaskId(), new java.sql.Date(new java.util.Date().getTime()));
				TaskBean e = manager.getTaskById(pForm.getTaskBean().getTaskId());
				int mainDays = PrimeUtil.getDayBetweenDate(e.getActualStart(), e.getActualEnd());
				manager.updateMainDays(pForm.getTaskBean().getTaskId(), mainDays);
			} catch(Exception e) {
				System.out.println("Actual End - Task Id . "+pForm.getTaskId());
				System.out.println("Terjadi kesalahan : "+e.getMessage());					
			}
			
			manager.insertDetail(pForm.getTaskBean());
			return mapping.findForward("forward");
		} else if (Constants.Task.TASK.DOABORT.equals(pForm.getTask())) {
			//##.Abort Task
			ActivityBean activityBean = new ActivityBean();
			activityBean.setActivityChangeNote("Activity aborted by role in task abort");
			activityBean.setTaskStatus(Constants.Status.ABORT);
			activityBean.setTaskId(pForm.getTaskBean().getTaskId());
			
			try {
				manager.updateActualEnd(pForm.getTaskBean().getTaskId(), new java.sql.Date(new java.util.Date().getTime()));
				TaskBean e = manager.getTaskById(pForm.getTaskBean().getTaskId());
				int mainDays = PrimeUtil.getDayBetweenDate(e.getActualStart(), e.getActualEnd());
				manager.updateMainDays(pForm.getTaskBean().getTaskId(), mainDays);
			} catch(Exception e) {
				System.out.println("Actual End - Task Id . "+pForm.getTaskId());
				System.out.println("Terjadi kesalahan : "+e.getMessage());					
			}
			
			manager.insertDetail(pForm.getTaskBean());
			return mapping.findForward("forward");
		} 
		
		String search = "";
		if("STARTDATE".equals(pForm.getColumnSearch()) || "ESTIMATEDATE".equals(pForm.getColumnSearch())) {
			search = pForm.getStartDate()+";"+pForm.getUntilDate();
		} else {
			search = pForm.getSearch();
		}
		int countRows  = manager.getCountByColumnSubordinate(pForm.getColumnSearchReal(), search, employeeId);
		List<TaskBean> list = manager.getListByColumnSubordinate(pForm.getColumnSearchReal(), search,
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
