package prime.user.task;

import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;
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
import prime.admin.holiday.HolidayBean;
import prime.admin.holiday.HolidayManager;
import prime.admin.holiday.HolidayManagerImpl;
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



public class TaskHeadAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//---.[Dedy] Hardcoded a little bit for Notification Jump
		request.getSession().setAttribute(Constants.Session.needRedirect , false);
		request.getSession().setAttribute(Constants.Session.redirectPage , Constants.PAGES_LIST[Constants.Page.USER_TASK_HEAD]);
		request.getSession().setAttribute(Constants.Session.redirectParam, "");
		
		int employeeId = LoginData.getUserData().getEmployeeId();
		request.setAttribute("employeeIdActive", employeeId);
		
		TaskHeadForm pForm = (TaskHeadForm) form;
		TaskManager manager = new TaskManagerImpl();
		EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
		ActivityManager tmpActivityManager = new ActivityManagerImpl();
		HolidayManager tmpHolidayManager  = new HolidayManagerImpl();
		
		
		if(Constants.Task.DOVALIDATE1.equals(pForm.getTask())){
				response.setContentType("text/text;charset=utf-8");
				response.setHeader("cache-control", "no-cache");
				PrintWriter tmpOut = response.getWriter();
				
				String tmpResponse = "";
				if(PrimeUtil.getCompareTo(pForm.getTaskBean().getTaskStartDate().getTime(), pForm.getTaskBean().getTaskEstimateDate().getTime()) > 0) {
					tmpResponse  = "Estimate Date must be greater than Start Date";
				} else {
					Calendar cal = Calendar.getInstance();
					List<HolidayBean> listHoliday = tmpHolidayManager.getListByYear(cal.get(Calendar.YEAR));
					List<EmployeeBean> listWeekend = tmpEmployeeManager.getListWeekendByEmployeeId(pForm.getTaskBean().getTaskReceiver());
					Integer sumOFHoliday = getSumHoliday(listHoliday, pForm.getTaskBean().getTaskStartDate(), pForm.getTaskBean().getTaskEstimateDate());
					Integer sumOFWeekend = getSumWeekEnd(listWeekend, pForm.getTaskBean().getTaskStartDate(), pForm.getTaskBean().getTaskEstimateDate());
					Integer mainDays = PrimeUtil.getDayBetweenDate(pForm.getTaskBean().getTaskStartDate(), pForm.getTaskBean().getTaskEstimateDate()) - sumOFHoliday - sumOFWeekend;				
					tmpResponse  = "Sum Of Holiday : "+sumOFHoliday+"<br>"
									+"Sum Of Weekend : "+sumOFWeekend+"<br>"
									+"Main Days : "+mainDays;
				}
				tmpOut.print(tmpResponse);
				tmpOut.flush();
				return null;
		 }
		
		if (Constants.Task.TASK.GOTOTASKTYPE.equals(pForm.getTask())) {
			pForm.getTaskBean().setTaskId(manager.getNewId());
			
			int countRows  = tmpEmployeeManager.getCountListByTree(pForm.getColumnSearchReal(), pForm.getSearch(), employeeId);
			List<EmployeeBean> list = tmpEmployeeManager.getListByTree(pForm.getColumnSearchReal(), pForm.getSearch(),
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					employeeId
					);
			
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
			pForm.getTaskBean().setTaskId(manager.getNewId());
			pForm.getTaskBean().setTaskAssigner(tmpTaskAssign.getEmployeeId());
			pForm.getTaskBean().setTaskReceiver(tmpTaskReceive.getEmployeeId());
			pForm.getTaskBean().setTaskAssignerName(tmpTaskAssign.getEmployeeName());
			pForm.getTaskBean().setTaskReceiverName(tmpTaskReceive.getEmployeeName());
			
			return mapping.findForward("add");
		} else if (Constants.Task.TASK.GOTOSUBMIT.equals(pForm.getTask())) {
			//##.Add Data
			TaskBean tmpTaskBean = manager.getTaskById(pForm.getTaskId());
			try {
				if(tmpTaskBean.getProjectMemberId() == 0) {
					EmployeeBean bean = tmpEmployeeManager.getEmployeeById(tmpTaskBean.getTaskReceiver());
					tmpTaskBean.setTaskAssigner(bean.getManagerId());
				}
			} catch (Exception e) { }
			pForm.setTaskBean(tmpTaskBean);
			return mapping.findForward("submit");
		} else if (Constants.Task.GOTOVIEW.equals(pForm.getTask())) {
			//##.View Detail Task
			System.out.println("1. : "+pForm.getTaskId());
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
		} else if (Constants.Task.DOADD.equals(pForm.getTask())) {
			//##. Insert Data
			pForm.getTaskBean().setTaskId(manager.getNewId());
			pForm.getTaskBean().setTaskStatus(Constants.Status.CREATE);
			pForm.getTaskBean().setTaskChangeNote("");
			pForm.getTaskBean().setProjectMemberId(0);
			pForm.getTaskBean().setUpdateBy(LoginData.getUserData().getUserName());
			
			manager.insert(pForm.getTaskBean());
			manager.insertDetail(pForm.getTaskBean());
			
			return mapping.findForward("forward");
		} else if (Constants.Task.TASK.DOSUBMIT.equals(pForm.getTask())) {
			//##.Submit Task
			manager.insertDetail(pForm.getTaskBean());
			return mapping.findForward("forward");
		} else if (Constants.Task.ACTIVITY.DOADD.equals(pForm.getTask())) {
			//##.Insert Data Activity
			pForm.getActivityBean().setUpdateBy(LoginData.getUserData().getUserName());
			pForm.getActivityBean().setActivityId(tmpActivityManager.getNewId());
			
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
			System.out.println("2. : "+pForm.getTaskId());
			if(!manager.isCheckStatusDetail(pForm.getTaskId(), Constants.Status.PROGRESS)) {
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
			manager.insertDetail(pForm.getTaskBean());
			System.out.println("2. : "+pForm.getTaskId()+" - "+pForm.getTaskBean().getTaskId());
			try {
				manager.updateActualEnd(pForm.getTaskBean().getTaskId(), new java.sql.Date(new java.util.Date().getTime()));
				TaskBean e = manager.getTaskById(pForm.getTaskBean().getTaskId());
				int mainDays = PrimeUtil.getDayBetweenDate(e.getActualStart(), e.getActualEnd());
				manager.updateMainDays(pForm.getTaskBean().getTaskId(), mainDays);
			} catch(Exception e) {
				System.out.println("Actual End - Task Id . "+pForm.getTaskId());
				System.out.println("Terjadi kesalahan : "+e.getMessage());					
			}
			
			return mapping.findForward("forward");
		} else if (Constants.Task.TASK.DOREJECT.equals(pForm.getTask())) {
			//##.Reject Task
			pForm.getTaskBean().setTaskStatus(Constants.Status.REJECT);
			pForm.getTaskBean().setTaskChangeNote("");
			
			System.out.println("1."+pForm.getTaskBean().getTaskId());
			System.out.println("2."+pForm.getTaskBean().getTaskChangeDate());
			System.out.println("3."+pForm.getTaskBean().getTaskStatus());
			
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
			
			tmpActivityManager.insertDetailBySelectTask(activityBean);
			manager.insertDetail(pForm.getTaskBean());
			return mapping.findForward("forward");
		} 
		
		String search = "";
		if("STARTDATE".equals(pForm.getColumnSearch()) || "ESTIMATEDATE".equals(pForm.getColumnSearch())) {
			search = pForm.getStartDate()+";"+pForm.getUntilDate();
		} else {
			search = pForm.getSearch();
		}
		
		int countRows  = manager.getCountByColumnHead(pForm.getColumnSearchReal(), search, employeeId);
		List<TaskBean> list = manager.getListByColumnHead(pForm.getColumnSearchReal(), search,
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows), 
				employeeId);
		
		request.setAttribute("listTask", list);
		request.setAttribute("listSearchColumn", Constants.Search.TASK_HEADSEARCHCOLUMNS);
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

	private Integer getSumHoliday(List<HolidayBean> listDate, java.sql.Date date1, java.sql.Date date2) {
		Calendar start = Calendar.getInstance();
		start.setTime(date1);	

		Calendar end = Calendar.getInstance();
		end.setTime(date2);

		int sum = 0;
		while (!start.after(end)) {
			for (int i = 0; i < listDate.size(); i++) {
				HolidayBean e = listDate.get(i);
				
				Calendar c = Calendar.getInstance();
				c.setTime(e.getHolidayDate());
				if(PrimeUtil.getCompareTo(start.getTimeInMillis(), e.getHolidayDate().getTime())== 0) {
					sum ++;
					break;
				}
			}
			start.add(Calendar.DATE, 1);
		}
		return sum;
	}
	

	public static Integer getSumWeekEnd(List<EmployeeBean> listDate, Date date1, Date date2) {
		if(listDate.size() == 0) 
			return 0;
		
		Calendar start = Calendar.getInstance();
		start.setTime(date1);

		Calendar end = Calendar.getInstance();
		end.setTime(date2);

		int sum = 0;
		while (!start.after(end)) {
			boolean isGet = false;
			EmployeeBean week = new EmployeeBean();
			for (EmployeeBean e : listDate) {
				Calendar c = Calendar.getInstance();
				c.setTime(e.getStartFrom());
				if(PrimeUtil.getCompareTo(start.getTimeInMillis(), c.getTimeInMillis())>= 0) {
					week = e;
					isGet = true;
				} else {
					if(!isGet) {
						week = e;
					}
					break;
				}
			}
			
			String[] split = week.getWeekEnd().split(",");
			for (String s : split) {
				if(start.get(Calendar.DAY_OF_WEEK) == PrimeUtil.getDay(s.trim())) {
					sum ++;
				}
			}
			start.add(Calendar.DATE, 1);
		}
		return sum;
	}

	public static java.sql.Date getDate(int y, int m, int d) {
		Calendar c = Calendar.getInstance();
		c.set(y, m, d);
		return new java.sql.Date(c.getTimeInMillis());
	}
	
}
