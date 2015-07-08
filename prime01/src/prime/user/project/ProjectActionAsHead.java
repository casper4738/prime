package prime.user.project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import prime.admin.role.RoleManager;
import prime.admin.role.RoleManagerImpl;
import prime.admin.user.UserBean;
import prime.constants.Constants;
import prime.user.activity.ActivityBean;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
import prime.user.task.TaskBean;
import prime.user.task.TaskManager;
import prime.user.task.TaskManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class ProjectActionAsHead extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//---.[Dedy] Hardcoded a little bit for Notification Jump
		request.getSession().setAttribute(Constants.Session.needRedirect , false);
		request.getSession().setAttribute(Constants.Session.redirectPage , Constants.PAGES_LIST[Constants.Page.USER_PROJECT]);
		request.getSession().setAttribute(Constants.Session.redirectParam, "");		
				
		
		Integer tmpEmployeeId = ((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId();
		
		ProjectFormAsHead 	pForm 				= (ProjectFormAsHead) form;
		ProjectManager 	tmpProjectManager 	= new ProjectManagerImpl();
		EmployeeManager tmpEmployeeManager 	= new EmployeeManagerImpl();
		TaskManager 	tmpTaskManager 		= new TaskManagerImpl();
		ActivityManager tmpActivityManager	= new ActivityManagerImpl();
		RoleManager 	tmpRoleManager 		= new RoleManagerImpl();
		
		System.out.println("masuk detail head action asdnsalk");
		if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##.Get Data
			//EmployeeBean tmpTaskAssign 	= tmpEmployeeManager.getEmployeeById(100);
		//	EmployeeBean tmpTaskReceive = tmpEmployeeManager.getEmployeeById(pForm.getProjectReceiver());
			
			//##.Add Data
			
			//pForm.getProjectBean().setProjectId(manager.getNewId());
			//pForm.getProjectBean().setProjectAssigner(101);
			//pForm.getProjectBean().setProjectAssigner(tmpTaskAssign.getEmployeeId());
			//pForm.getProjectBean().setProjectReceiver(tmpTaskAssign.getEmployeeId());
			System.out.println("add as head = " + tmpEmployeeId);
			
			//pForm.setCountUnderLevel(countUnderLevel);
			pForm.setEmployeeBean(tmpEmployeeManager.getEmployeeById(tmpEmployeeId));
			System.out.println("div "+pForm.getEmployeeBean().getDivisionId());
			pForm.setDivisionId(pForm.getEmployeeBean().getDivisionId());
			pForm.setPositionId(pForm.getEmployeeBean().getPositionId());
			return mapping.findForward("add");
		}  
		else if (Constants.Task.DOADD.equals(pForm.getTask())){
			//##.Insert Data Task
			System.out.println("create as head");
			pForm.getProjectBean().setProjectId(tmpProjectManager.getNewId());
			pForm.getProjectBean().setProjectAssigner(tmpEmployeeId);
			pForm.getProjectBean().setProjectLastStatus(1);
			pForm.getProjectBean().setProjectStatus(0);
			pForm.getProjectBean().setProjectReceiver(pForm.getEmployeeId());
			pForm.getProjectBean().setProjectChangeNote("First Time");
			pForm.getProjectBean().setUpdatedBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
			tmpProjectManager.insert(pForm.getProjectBean());
			tmpProjectManager.insertDetail(pForm.getProjectBean());
			pForm.getProjectBean().setProjectMemberId(tmpProjectManager.getNewMemberId());
			pForm.getProjectBean().getRoleBean().setRoleId(1);
			pForm.getProjectBean().setEmployeeId(pForm.getEmployeeId());
			pForm.getProjectBean().setProjectMemberStatus(1);
			tmpProjectManager.insertMember(pForm.getProjectBean());

			
			String search = "";
			if("STARTDATE".equals(pForm.getColumnSearchReal()) || "ESTIMATEDATE".equals(pForm.getColumnSearchReal())) {
				search = pForm.getStartDate()+";"+pForm.getUntilDate();
			} else {
				search = pForm.getSearch();
			}
			System.out.println("colom "+pForm.getColumnSearchReal());
			int countRows  = tmpProjectManager.getCountListByColAsHead(pForm.getColumnSearchReal(), search, tmpEmployeeId);
			List<ProjectBean> list = tmpProjectManager.getListByColumnAsMember(pForm.getColumnSearchReal(), pForm.getSearch(),
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),tmpEmployeeId);
			request.setAttribute("listProject", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("forward");
		} 
		else if ("detailsAsHead".equals(pForm.getTask())){
			System.out.println("masuk detail head action");
			//##.View Detail Project
			pForm.setProjectBean(tmpProjectManager.getProjectById(pForm.getProjectId()));
			int countRows = tmpProjectManager.getCountListMember(pForm.getProjectId());
			List<ProjectBean> list = tmpProjectManager.getListProjectMember(pForm.getColumnSearchReal(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getProjectId());
			request.setAttribute("listProjectMember", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request,pForm, countRows, (int)pForm.getGoToPage(), pForm.getShowInPage());
			
			//---.For Calendar
			SimpleDateFormat tmpConvert = new SimpleDateFormat("dd/MM/yyyy");
			request.setAttribute("progressStartDate", tmpConvert.format(pForm.getProjectBean().getProjectStartDate()));
			request.setAttribute("progressEndDate", tmpConvert.format(pForm.getProjectBean().getProjectEstimateDate()));
			
			return mapping.findForward("detailsAsHead");
		
		
		}
		else if ("approve".equals(pForm.getTask())){
			System.out.println("approve");
			return mapping.findForward("approve");
		}
		else if ("reject".equals(pForm.getTask())){
			System.out.println("reject");
			return mapping.findForward("reject");
		}
		else if ("changePM".equals(pForm.getTask())){
			System.out.println("changePM "+pForm.getProjectBean().getEmployeeIdReceiver());
			
			return mapping.findForward("changePM");
		}
		else if ("abort".equals(pForm.getTask())){
			pForm.getProjectBean().setProjectStatus(Constants.Status.ABORT);
			System.out.println("PROJECT ID "+pForm.getProjectBean().getProjectId());
			System.out.println("PROJECT RECEIVER "+pForm.getProjectBean().getProjectReceiver());
			System.out.println("PROJECT ASSIGNER "+pForm.getProjectBean().getProjectAssigner());
			pForm.getProjectBean().setProjectChangeNote("abort project");
			tmpProjectManager.insertDetail(pForm.getProjectBean());
		}
		
		else if(Constants.Task.PROJECT.GOTOTASKMEMBER.equals(pForm.getTask())){
			//##. Get Data
			pForm.setEmployeeBean(tmpEmployeeManager.getEmployeeById(pForm.getEmployeeId()));
			pForm.setProjectBean(tmpProjectManager.getProjectById(pForm.getProjectId()));
			pForm.getProjectBean().setEmployeeId(pForm.getEmployeeBean().getEmployeeId());
			pForm.getProjectBean().setEmployeeName(pForm.getEmployeeBean().getEmployeeName());
			System.out.println("PID "+pForm.getProjectId());
			
			int countRows = tmpProjectManager.getCountListTaskMember(pForm.getEmployeeId(), pForm.getProjectId());
			List<ProjectBean> list =tmpProjectManager.getListProjectMemberDetails(pForm.getColumnSearchReal(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getEmployeeId(), pForm.getProjectId());
			
			//##. Set Attribute
			request.setAttribute("listProjectMemberDetails", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			request.setAttribute("isAddTaskActive" , tmpRoleManager.getRolesByEmployeeIdAndProjectId(pForm.getProjectBean().getEmployeeId(),  pForm.getProjectBean().getProjectId()).size());
			
			
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());			
			
			return mapping.findForward("detailMember");
		} else if(Constants.Task.PROJECT.GOTOCREATETASK.equals(pForm.getTask())){
			request.setAttribute("listRoles", tmpRoleManager.getRolesByEmployeeIdAndProjectId(pForm.getProjectBean().getEmployeeId(),  pForm.getProjectBean().getProjectId()));
			System.out.println("detail member "+ pForm.getProjectBean().getEmployeeId());
			String setEmployee=pForm.getProjectBean().getEmployeeId()+" - "+ pForm.getProjectBean().getEmployeeName();
			pForm.getProjectBean().setEmployeeName(setEmployee);
			return mapping.findForward("createTask");
		} else if(Constants.Task.PROJECT.DOCREATETASK.equals(pForm.getTask())){
			System.out.println("masu do create task");
			pForm.getProjectBean().getTaskBean().setTaskId(tmpTaskManager.getNewId());
			pForm.getProjectBean().getTaskBean().setTaskAssigner(tmpEmployeeId);
			pForm.getProjectBean().getTaskBean().setTaskReceiver(pForm.getProjectBean().getEmployeeId());
			pForm.getProjectBean().getTaskBean().setProjectMemberId(tmpProjectManager.getProjectMemberIdByAll(pForm.getProjectBean()));
			
			tmpTaskManager.insert(pForm.getProjectBean().getTaskBean());
			tmpTaskManager.insertDetail(pForm.getProjectBean().getTaskBean());

			pForm.setEmployeeId(pForm.getProjectBean().getEmployeeId());
			pForm.setProjectId(pForm.getProjectBean().getProjectId());
			return mapping.findForward("forward");
		} else if(Constants.Task.TASK.GOTODETAIL.equals(pForm.getTask())){
			//##.View Detail Task
			pForm.setTaskBean(tmpTaskManager.getTaskById(pForm.getTaskId()));
			int countRows = tmpActivityManager.getCountByColumn(pForm.getColumnSearchReal(), pForm.getSearch(), pForm.getTaskId());
			List<ActivityBean> list = tmpActivityManager.getListByColumn(pForm.getColumnSearchReal(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getTaskId());
			
			request.setAttribute("listActivity", list);
			request.setAttribute("listSearchColumn", Constants.Search.ACTIVITY_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			
			
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());	
			
			return mapping.findForward("taskDetail");
			
		} 
		else if ("detailMemberAsHead".equals(pForm.getTask())){
			
			//##. Get Data
			pForm.setEmployeeBean(tmpEmployeeManager.getEmployeeById(pForm.getEmployeeId()));
			pForm.setProjectBean(tmpProjectManager.getProjectById(pForm.getProjectId()));
			pForm.getProjectBean().setEmployeeId(pForm.getEmployeeBean().getEmployeeId());
			pForm.getProjectBean().setEmployeeName(pForm.getEmployeeBean().getEmployeeName());
			
			int countRows = tmpProjectManager.getCountListTaskMember(pForm.getEmployeeId(), pForm.getProjectId());
			List<ProjectBean> list =tmpProjectManager.getListProjectMemberDetails(pForm.getColumnSearchReal(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getEmployeeId(), pForm.getProjectId());
			
			//##. Set Attribute
			request.setAttribute("listProjectMemberDetails", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			request.setAttribute("isAddTaskActive" , tmpRoleManager.getRolesByEmployeeIdAndProjectId(pForm.getProjectBean().getEmployeeId(),  pForm.getProjectBean().getProjectId()).size());
			
			
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			
			return mapping.findForward("detailMemberAsHead");
		}
		
		else if("addmember".equals(pForm.getTask())){
			//belum diisi
			//pForm.getProjectBean().getRoleBean().setRoleId(pForm.getRoleId());
			//pForm.getProjectBean().setEmployeeId(pFor);
			request.setAttribute("listAllRoles", tmpRoleManager.getListAllRole());
			return mapping.findForward("addMember");
		}
				
		else if(Constants.Task.PROJECT.DOCREATEMEMBER.equals(pForm.getTask())){
			
			System.out.println("banyak "+pForm.getTempRoleId());
			String roles=pForm.getTempRoleId();
			String []rolesSplit=roles.split(",");
			System.out.println("size "+rolesSplit.length);
			
			pForm.getProjectBean().setEmployeeId(pForm.getEmployeeId());

			pForm.setEmployeeId(pForm.getProjectBean().getEmployeeId());
			pForm.setProjectId(pForm.getProjectBean().getProjectId());
			
			for(int i=0;i<rolesSplit.length;i++){
				//System.out.println(rolesSplit[i]);
				pForm.getProjectBean().setProjectMemberId(tmpProjectManager.getNewMemberId());
				pForm.getProjectBean().getRoleBean().setRoleId(Integer.valueOf(rolesSplit[i]));
				tmpProjectManager.insertMember(pForm.getProjectBean());
			}
			//tmpProjectManager.insertMember(pForm.getProjectBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.TASK.GOTOSUBMIT.equals(pForm.getTask())){
			//System.out.println("id "+pForm.getProjectId());
			//request.setAttribute("projectName", tmpProjectManager.getProjectNamebyProjectId(pForm.getProjectId()));
			
			
			return mapping.findForward("submit");
		}
		else if("doSubmit".equals(pForm.getTask())){
			System.out.println("PROJECT ID "+pForm.getProjectBean().getProjectId());
			System.out.println("PROJECT RECEIVER "+pForm.getProjectBean().getProjectReceiver());
			System.out.println("PROJECT ASSIGNER "+pForm.getProjectBean().getProjectAssigner());
			pForm.getProjectBean().setProjectStatus(3);
			tmpProjectManager.insertDetail(pForm.getProjectBean());
			
		}
		
		else if("doApprove".equals(pForm.getTask())){
			System.out.println("PROJECT ID "+pForm.getProjectBean().getProjectId());
			System.out.println("PROJECT RECEIVER "+pForm.getProjectBean().getProjectReceiver());
			System.out.println("PROJECT ASSIGNER "+pForm.getProjectBean().getProjectAssigner());
			pForm.getProjectBean().setProjectStatus(7);
			
			tmpProjectManager.insertDetail(pForm.getProjectBean());
			
			ProjectBean e = tmpProjectManager.getProjectById(pForm.getProjectBean().getProjectId());
			tmpProjectManager.updateActualEnd(pForm.getProjectBean().getProjectId(), new java.sql.Date(new java.util.Date().getTime()));
			int mainDays = PrimeUtil.getDayBetweenDate(e.getActualStart(), e.getActualEnd());
			tmpProjectManager.updateMainDays(pForm.getProjectBean().getProjectId(), mainDays);
			
		}
		
		else if("doReject".equals(pForm.getTask())){
			System.out.println("PROJECT ID "+pForm.getProjectBean().getProjectId());
			System.out.println("PROJECT RECEIVER "+pForm.getProjectBean().getProjectReceiver());
			System.out.println("PROJECT ASSIGNER "+pForm.getProjectBean().getProjectAssigner());
			pForm.getProjectBean().setProjectStatus(6);
			tmpProjectManager.insertDetail(pForm.getProjectBean());
			
		}
		
		else if("doChangePM".equals(pForm.getTask())){
			//pForm.getProjectBean().setProjectStatus(6);
			int idPM=tmpProjectManager.getProjectMemberIDbyRole(pForm.getProjectBean().getProjectId(), pForm.getProjectBean().getProjectReceiver(), pForm.getProjectBean().getEmployeeIdReceiver());
			tmpProjectManager.updateStatusProjectMemberRole(idPM, 0);
			pForm.getProjectBean().setProjectMemberId(tmpProjectManager.getNewMemberId());
			//pForm.getProjectBean().setProjectId(projectId);
			pForm.getProjectBean().getRoleBean().setRoleId(1);
			pForm.getProjectBean().setProjectMemberStatus(1);
			pForm.getProjectBean().setEmployeeId(pForm.getEmployeeId());
			tmpProjectManager.insertMember(pForm.getProjectBean());
			
			
			pForm.getProjectBean().setProjectMemberId(tmpProjectManager.getNewMemberId());
			pForm.getProjectBean().setProjectId(pForm.getProjectBean().getProjectId());
			pForm.getProjectBean().getRoleBean().setRoleId(1);
			pForm.getProjectBean().setEmployeeId(pForm.getEmployeeId());
			pForm.getProjectBean().setProjectMemberStatus(1);
			pForm.getProjectBean().setProjectReceiver(pForm.getEmployeeId());
			System.out.println("status "+pForm.getProjectBean().getProjectLastStatus());
			tmpProjectManager.updateProjectReceiver(pForm.getProjectBean().getProjectId(),pForm.getEmployeeId() );
			pForm.getProjectBean().setProjectStatus(pForm.getProjectBean().getProjectLastStatus());
			tmpProjectManager.insertDetail(pForm.getProjectBean());
			
		}
		
		else if(Constants.Task.PROJECT.GOTOEDITMEMBER.equals(pForm.getTask())){
			EmployeeBean tmpEmployeeBean = tmpEmployeeManager.getEmployeeById(pForm.getEmployeeId());
			pForm.getProjectBean().setEmployeeId(tmpEmployeeBean.getEmployeeId());
			pForm.getProjectBean().setEmployeeName(tmpEmployeeBean.getEmployeeName());
			request.setAttribute("listRoles",  tmpProjectManager.getRoleByProjectMember(pForm.getEmployeeId(), pForm.getProjectId()));
			return mapping.findForward("editMemberRole");
		} else if(Constants.Task.PROJECT.DOEDITMEMBER.equals(pForm.getTask())){
			List<RoleOption> listx = tmpProjectManager.getRoleByProjectMember(pForm.getProjectBean().getEmployeeId(), pForm.getProjectId());
			
			List<String> listTemp = new ArrayList<String>();
			List<String> listInsert = new ArrayList<String>();
			List<String> listUpdate = new ArrayList<String>();
			
			for (RoleOption e : listx) {
				if(e.getProjectMemberId() != 0 && e.getProjectMemberStatus() == 1) {
					listTemp.add(e.getRoleId()+";"+e.getProjectMemberId()+";"+e.getProjectMemberStatus());
				}
			}

			String roles = pForm.getTempRoleId();
			String []rolesSplit = roles.split(",");
			for (String string : rolesSplit) {
				System.out.println("insert : "+string);
				listInsert.add(string);
			}
			
			listUpdate.addAll(listTemp);
			listUpdate.removeAll(listInsert);
			
			for (String string : listUpdate) {
				tmpProjectManager.updateStatusProjectMemberRole(Integer.parseInt(string.split(";")[1]),  0);
				
				TaskBean taskBean = new TaskBean();
				taskBean.setTaskReceiver(pForm.getProjectBean().getEmployeeId());
				taskBean.setProjectMemberId(Integer.parseInt(string.split(";")[1]));
				taskBean.setTaskStatus(Constants.Status.ABORT);
				taskBean.setTaskChangeNote("Task aborted by role in project abort");
				tmpTaskManager.insertDetailBySelectTask(taskBean);
				
				ActivityBean activityBean = new ActivityBean();
				activityBean.setActivityChangeNote("Activity aborted by role in project abort");
				activityBean.setTaskReceiver(taskBean.getTaskReceiver());
				activityBean.setProjectMemberId(taskBean.getProjectMemberId());
				activityBean.setTaskStatus(taskBean.getTaskStatus());				
				tmpActivityManager.insertDetailBySelectTask(activityBean);
			}
			
			listInsert.removeAll(listTemp);
			for (String string : listInsert) {
				String [] split = string.split(";");
				int roleId 					= -1;
				int projectMemberId			= -1;
				int projectMemberStatus 	= -1;
				if(!split[0].isEmpty()){
					roleId					= Integer.parseInt(split[0]);
					projectMemberId			= Integer.parseInt(split[1]);
					projectMemberStatus		= Integer.parseInt(split[2]);
				}
				if(projectMemberId == 0) {
					pForm.getProjectBean().setProjectMemberId(tmpProjectManager.getNewMemberId());
					pForm.getProjectBean().setProjectMemberStatus(1);	
					pForm.getProjectBean().getRoleBean().setRoleId(roleId);	
					tmpProjectManager.insertMember(pForm.getProjectBean());
				} else if(projectMemberStatus == 0) {
					tmpProjectManager.updateStatusProjectMemberRole(projectMemberId, 1);
				}
			}
			
			
			return mapping.findForward("forward");
		} else if(("refreshProjectProgress").equals(pForm.getTask())){
			refreshProjectProgressList(request, response, pForm, tmpProjectManager);
			return null;
		}
		
		String search = null;
		if("STARTDATE".equals(pForm.getColumnSearchReal()) || "ESTIMATEDATE".equals(pForm.getColumnSearchReal())) {
			search = pForm.getStartDate()+";"+pForm.getUntilDate();
		} else {
			System.out.println("masuk search");
			search = pForm.getSearch();
		}
		pForm.getProjectBean().setIsAssigner(tmpProjectManager.getCountProjectAssigner(tmpEmployeeId));
		
		int countLevel = tmpEmployeeManager.getCountUnderLevel(tmpEmployeeId);
		System.out.println("jumlah level "+countLevel );
		pForm.setCountUnderLevel(Integer.valueOf(countLevel));
		List<ProjectBean> list = new ArrayList<ProjectBean>();
		System.out.println("colom "+pForm.getColumnSearchReal());
		int countRows  = tmpProjectManager.getCountListByColAsHead(pForm.getColumnSearchReal(), search, tmpEmployeeId);
		list = tmpProjectManager.getListByColumnAsHead(pForm.getColumnSearchReal(), search,
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows), tmpEmployeeId);
		
		request.setAttribute("listProject", list);
		request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
		setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		//if(true)
		return mapping.findForward("success");
	}

	private void setPaging(HttpServletRequest request, ProjectFormAsHead pForm, int countRows, int page, int view) {
		// TODO Auto-generated method stub
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
	
	private void refreshProjectProgressList(HttpServletRequest request, HttpServletResponse response, ProjectFormAsHead pForm, ProjectManager manager) throws SQLException, IOException {
		//##0.Temp Variable
		int tmpI, tmpJ, tmpK;
		List tmpCurnMember, tmpPerMemberProgressedTask;
		ArrayList<ArrayList<Object>> tmpData;
		Date tmpActualStartDate, tmpActualEndDate;
		Date tmpFilterStartDate, tmpFilterEndDate;
		Date tmpCurnDate;
		boolean tmpLastStatus, tmpAnyProgress;
		ArrayList<Object> tmpTaskProgress;
		String tmpLastName = "";
		
		tmpFilterStartDate = PrimeUtil.parseDateStringToDateOnly(pForm.getProgressStartDate());
		tmpFilterEndDate   = PrimeUtil.parseDateStringToDateOnly(pForm.getProgressEndDate());
		List tmpCalendarList = PrimeUtil.getListStringDate(tmpFilterStartDate, tmpFilterEndDate);
		
		//---.Project Progress on Ranged Date
		//---a.Do Looping
		//     Not considering any perfomance turnover, with this code [Will think over about it later]
		tmpData = new ArrayList<ArrayList<Object>>();
		
		tmpCurnMember = manager.getListEmployeeIDInProject(pForm.getProjectId());
		for(tmpI = 0 ; tmpI < tmpCurnMember.size() ; tmpI++){
			tmpPerMemberProgressedTask = manager.getProjectTaskListPerMember(pForm.getProjectId(), (Integer)tmpCurnMember.get(tmpI));	
			tmpLastName = "";
			
			for(tmpJ = 0 ; tmpJ < tmpPerMemberProgressedTask.size() ; tmpJ++){
				tmpActualStartDate = ((TaskBean)tmpPerMemberProgressedTask.get(tmpJ)).getActualStart();
				tmpActualEndDate   = ((TaskBean)tmpPerMemberProgressedTask.get(tmpJ)).getActualEnd();
				
				tmpTaskProgress = new ArrayList<>();
				if(tmpActualStartDate != null){
					tmpAnyProgress = false;
					if(tmpLastName.equals(((TaskBean)tmpPerMemberProgressedTask.get(tmpJ)).getTaskReceiverName())){
						tmpTaskProgress.add("");
					} else {
						tmpLastName = ((TaskBean)tmpPerMemberProgressedTask.get(tmpJ)).getTaskReceiverName();
						tmpTaskProgress.add(((TaskBean)tmpPerMemberProgressedTask.get(tmpJ)).getTaskReceiver() + " - " +
											tmpLastName);
					}
					tmpTaskProgress.add(((TaskBean)tmpPerMemberProgressedTask.get(tmpJ)).getTaskId() + " - " +
										((TaskBean)tmpPerMemberProgressedTask.get(tmpJ)).getTaskName());
					tmpTaskProgress.add(((TaskBean)tmpPerMemberProgressedTask.get(tmpJ)).getTaskLastStatus());
					tmpK = 3;
					tmpAnyProgress = false;
					do {
						tmpCurnDate = PrimeUtil.parseDateStringToDateOnly((String)tmpCalendarList.get(tmpK - 3));
						tmpLastStatus = (tmpActualStartDate.before(tmpCurnDate)); 
						
						if(tmpActualEndDate != null){
							tmpLastStatus = (tmpLastStatus && tmpActualEndDate.after(tmpCurnDate));
							if(!tmpLastStatus){
								if(PrimeUtil.getCompareTo(tmpActualEndDate.getTime(), tmpCurnDate.getTime()) == 0){
									tmpLastStatus = true;
								}
							}
						}
						tmpAnyProgress = (tmpLastStatus) ? true : tmpAnyProgress;
						tmpTaskProgress.add(tmpLastStatus);
						tmpK++;
					} while(tmpCurnDate.before(tmpFilterEndDate) && (tmpK - 3 < tmpCalendarList.size()));
					
					//There's some changing, insert to data
					if(tmpAnyProgress){
						tmpData.add(tmpTaskProgress);
					}
				}
				
			}
		}
		
		//---b.Get Activities
		response.setContentType("text/text;charset=utf-8");
		response.setHeader("cache-control", "no-cache");
		PrintWriter tmpOut = response.getWriter();
		String tmpTimeString = "";
		
		for(tmpI = 0 ; tmpI < tmpCalendarList.size() ; tmpI++){
			tmpTimeString += "<th>";
			tmpTimeString += tmpCalendarList.get(tmpI);
			tmpTimeString += "</th>";
		}
		String tmpValueString = "";
		for(tmpJ = 0 ; tmpJ < tmpData.size() ; tmpJ++){
			tmpValueString += "<tr>"; 
			tmpValueString += "<td width=\"5px\" >" + (tmpJ + 1) + "</td>";
			tmpValueString += "<td>";
			tmpValueString += tmpData.get(tmpJ).get(0); 
			tmpValueString += "</td>";
			tmpValueString += "<td>";
			tmpValueString += tmpData.get(tmpJ).get(1); 
			tmpValueString += "</td>";
			tmpValueString += "<td>";
			switch((int)tmpData.get(tmpJ).get(2)){
				case Constants.Status.CREATE:
					tmpValueString += "<span class=\"label label-warning\">Receive</span>";
					break;
				case Constants.Status.PROGRESS :
					tmpValueString += "<span class=\"label label-success\">Progress</span>";
					break;
				case Constants.Status.PAUSE  :
					tmpValueString += "<span class=\"label label-warning\">Pause</span>";
					break;
				case Constants.Status.FINISH :
					tmpValueString += "<span class=\"label label-info\">Finish</span>";
					break;
				case Constants.Status.ABORT  :
					tmpValueString += "<span class=\"label label-danger\">Abort</span>";
					break;
			}
			tmpValueString += "</td>";
			
			for(tmpK = 3 ; tmpK < tmpData.get(tmpJ).size() ; tmpK++){
				if((boolean)tmpData.get(tmpJ).get(tmpK)){	
					tmpValueString += "<td bgcolor='#339900'>";
				} else {
					tmpValueString += "<td>";
				}
				tmpValueString += "</td>";
			}
			tmpValueString += "</tr>";
		}

		if(tmpData.size() <= 0){
			tmpOut.print("<center><b>No progress in this day range.</center></b>");
		} else {
			tmpOut.print("<table id=\"table-2\" class=\"display cell-border compact\" cellspacing=\"0\" width=\"100%\">" + 
						 "<thead>" +
								"<th>#</th>"   +
								"<th>Name</th>"   + 
								"<th>Task</th>"   + 
								"<th>Status</th>"   + 
						 		tmpTimeString +
						 "</thead>" +
						 "<tbody>"  +
						 		tmpValueString +  
						 "</tbody>" +
					 	 "</table>");
		}
		tmpOut.flush();
	}
}
