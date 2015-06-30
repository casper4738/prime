package prime.user.project;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.ha.util.IDynamicProperty;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.employee.EmployeeBean;
import prime.admin.employee.EmployeeManager;
import prime.admin.employee.EmployeeManagerImpl;
import prime.admin.role.RoleManager;
import prime.admin.role.RoleManagerImpl;
import prime.constants.Constants;
import prime.user.activity.ActivityBean;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
import prime.user.task.TaskBean;
import prime.user.task.TaskManager;
import prime.user.task.TaskManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class ProjectAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		int tmpEmployeeId = 100;
		
		ProjectForm 	pForm 				= (ProjectForm) form;
		ProjectManager 	tmpProjectManager 	= new ProjectManagerImpl();
		EmployeeManager tmpEmployeeManager 	= new EmployeeManagerImpl();
		TaskManager 	tmpTaskManager 		= new TaskManagerImpl();
		ActivityManager tmpActivityManager	= new ActivityManagerImpl();
		RoleManager 	tmpRoleManager 		= new RoleManagerImpl();
		
		if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##.Get Data
			//EmployeeBean tmpTaskAssign 	= tmpEmployeeManager.getEmployeeById(100);
		//	EmployeeBean tmpTaskReceive = tmpEmployeeManager.getEmployeeById(pForm.getProjectReceiver());
			
			//##.Add Data
			
			//pForm.getProjectBean().setProjectId(manager.getNewId());
			//pForm.getProjectBean().setProjectAssigner(101);
			//pForm.getProjectBean().setProjectAssigner(tmpTaskAssign.getEmployeeId());
			//pForm.getProjectBean().setProjectReceiver(tmpTaskAssign.getEmployeeId());
			
			pForm.setEmployeeBean(tmpEmployeeManager.getEmployeeById(101));
			System.out.println("div "+pForm.getEmployeeBean().getDivisionId());
			pForm.setDivisionId(pForm.getEmployeeBean().getDivisionId());
			pForm.setPositionId(pForm.getEmployeeBean().getPositionId());
			return mapping.findForward("add");
		} else if (Constants.Task.DOADD.equals(pForm.getTask())){
			//##.Insert Data Task
			pForm.getProjectBean().setProjectId(tmpProjectManager.getNewId());
			pForm.getProjectBean().setProjectReceiver(101);
			pForm.getProjectBean().setProjectLastStatus(1);
			pForm.getProjectBean().setProjectStatus(0);
			pForm.getProjectBean().setProjectAssigner(pForm.getEmployeeId());
			pForm.getProjectBean().setProjectChangeNote("First Time");
			tmpProjectManager.insert(pForm.getProjectBean());
			tmpProjectManager.insertDetail(pForm.getProjectBean());
			pForm.getProjectBean().setProjectMemberId(tmpProjectManager.getNewMemberId());
			pForm.getProjectBean().getRoleBean().setRoleId(1);
			pForm.getProjectBean().setEmployeeId(101);
			pForm.getProjectBean().setProjectMemberStatus(1);
			tmpProjectManager.insertMember(pForm.getProjectBean());

			
			int countRows  = tmpProjectManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<ProjectBean> list = tmpProjectManager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
			request.setAttribute("listProject", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("success");
		} else if (Constants.Task.PROJECT.GOTOPROJECTDETAIL.equals(pForm.getTask())){
			//##.View Detail Project
			pForm.setProjectBean(tmpProjectManager.getProjectById(pForm.getProjectId()));
			int countRows = tmpProjectManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			
			
			List<ProjectBean> list = tmpProjectManager.getListProjectMember(pForm.getColumnSearch(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getProjectId());
			System.out.println("ID "+pForm.getProjectId());
			double percentStatus = tmpProjectManager.getPercentStatusProject(pForm.getProjectId());
			pForm.getProjectBean().setPercentStatus(percentStatus);
			
			request.setAttribute("listProjectMember", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		//	double percentStatus=tmpProjectManager.getStatus
			//System.out.println("masuk "+pForm.getProjectId());
			
			return mapping.findForward("details");
		}
		else if ("detailsAsHead".equals(pForm.getTask())){
			//##.View Detail Project
			pForm.setProjectBean(tmpProjectManager.getProjectById(pForm.getProjectId()));
			int countRows = tmpProjectManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<ProjectBean> list = tmpProjectManager.getListProjectMember(pForm.getColumnSearch(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getProjectId());
			request.setAttribute("listProjectMember", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
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
			System.out.println("changePM "+pForm.getEmployeeIdReceiver());
			
			return mapping.findForward("changePM");
		}
		
		else if(Constants.Task.PROJECT.GOTOTASKMEMBER.equals(pForm.getTask())){
			//##. Get Data
			pForm.setEmployeeBean(tmpEmployeeManager.getEmployeeById(pForm.getEmployeeId()));
			pForm.setProjectBean(tmpProjectManager.getProjectById(pForm.getProjectId()));
			pForm.getProjectBean().setEmployeeId(pForm.getEmployeeBean().getEmployeeId());
			pForm.getProjectBean().setEmployeeName(pForm.getEmployeeBean().getEmployeeName());
			System.out.println("PID "+pForm.getProjectId());
			
			int countRows = tmpProjectManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<ProjectBean> list =tmpProjectManager.getListProjectMemberDetails(pForm.getColumnSearch(), pForm.getSearch(), 
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
			int countRows = tmpActivityManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch(), pForm.getTaskId());
			List<ActivityBean> list = tmpActivityManager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(), 
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
			
			int countRows = tmpProjectManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<ProjectBean> list =tmpProjectManager.getListProjectMemberDetails(pForm.getColumnSearch(), pForm.getSearch(), 
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
			
		}
		
		else if("doReject".equals(pForm.getTask())){
			System.out.println("PROJECT ID "+pForm.getProjectBean().getProjectId());
			System.out.println("PROJECT RECEIVER "+pForm.getProjectBean().getProjectReceiver());
			System.out.println("PROJECT ASSIGNER "+pForm.getProjectBean().getProjectAssigner());
			pForm.getProjectBean().setProjectStatus(6);
			
			tmpProjectManager.insertDetail(pForm.getProjectBean());
			
		}
		
		else if("doChangePM".equals(pForm.getTask())){
			System.out.println("PROJECT ID "+pForm.getProjectBean().getProjectId());
			System.out.println("PROJECT RECEIVER "+pForm.getProjectBean().getProjectReceiver());
			System.out.println("EMPLOYEE "+pForm.getEmployeeId());
			//pForm.getProjectBean().setProjectStatus(6);
			System.out.println("EMPLOYEE id "+pForm.getProjectBean().getEmployeeIdReceiver() );
			int idPM=tmpProjectManager.getProjectMemberIDbyRole(pForm.getProjectBean().getProjectId(), pForm.getProjectBean().getProjectReceiver(), pForm.getProjectBean().getEmployeeIdReceiver());
			System.out.println("idpm "+idPM);
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
				System.out.println("update : "+string);
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
				int roleId 					= 0;
				int projectMemberId			= 0;
				int projectMemberStatus 	= 0;
				if(!split[0].isEmpty()){
					roleId					= Integer.parseInt(split[0]);
					projectMemberId			= Integer.parseInt(split[1]);
					projectMemberStatus		= Integer.parseInt(split[2]);
				}
				System.out.println("sisa : "+string);
				
				if(projectMemberId == 0) {
					pForm.getProjectBean().setProjectMemberId(tmpProjectManager.getNewMemberId());
					pForm.getProjectBean().setProjectMemberStatus(1);	
					pForm.getProjectBean().getRoleBean().setRoleId(roleId);	
					
					System.out.println("2.1. "+pForm.getProjectBean().getProjectMemberId());
					System.out.println("2.2. "+pForm.getProjectBean().getProjectMemberStatus());
					System.out.println("2.3. "+pForm.getProjectBean().getRoleBean().getRoleId());
					
					tmpProjectManager.insertMember(pForm.getProjectBean());
				} else if(projectMemberStatus == 0) {
					tmpProjectManager.updateStatusProjectMemberRole(projectMemberId, 1);
				}
			}
			
			
			return mapping.findForward("forward");
		}
		int countRows  = tmpProjectManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
		List<ProjectBean> list = tmpProjectManager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
		
		request.setAttribute("listProject", list);
		request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
		setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		return mapping.findForward("success");
	}

	private void setPaging(HttpServletRequest request, ProjectForm pForm, int countRows, int page, int view) {
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
	
}
