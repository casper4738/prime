package prime.user.project;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.employee.EmployeeManager;
import prime.admin.employee.EmployeeManagerImpl;
import prime.admin.role.RoleBean;
import prime.admin.role.RoleManager;
import prime.admin.role.RoleManagerImpl;
import prime.constants.Constants;
import prime.user.activity.ActivityBean;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
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
		
		System.out.println("cell 1: "+pForm.getTask());
		System.out.println("cell 2: "+Constants.Task.Project.DOCREATETASK);
		
		if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##.Get Data
			//EmployeeBean tmpTaskAssign 	= tmpEmployeeManager.getEmployeeById(100);
		//	EmployeeBean tmpTaskReceive = tmpEmployeeManager.getEmployeeById(pForm.getProjectReceiver());
			
			//##.Add Data
			System.out.println("masuk add " + tmpProjectManager.getNewId());
			
			//pForm.getProjectBean().setProjectId(manager.getNewId());
			//pForm.getProjectBean().setProjectAssigner(101);
			//pForm.getProjectBean().setProjectAssigner(tmpTaskAssign.getEmployeeId());
			//pForm.getProjectBean().setProjectReceiver(tmpTaskAssign.getEmployeeId());
			
			return mapping.findForward("add");
		} 
		else if (Constants.Task.DOADD.equals(pForm.getTask())){
			//##.Insert Data Task
			//System.out.println("do "+manager.getNewId());
			pForm.getProjectBean().setProjectId(tmpProjectManager.getNewId());
			pForm.getProjectBean().setProjectReceiver(101);
			pForm.getProjectBean().setProjectLastStatus(1);
			pForm.getProjectBean().setProjectStatus(1);
			pForm.getProjectBean().setProjectAssigner(pForm.getEmployeeId());
			pForm.getProjectBean().setProjectChangeNote("First Time");
			tmpProjectManager.insert(pForm.getProjectBean());
			tmpProjectManager.insertDetail(pForm.getProjectBean());

			
			int countRows  = tmpProjectManager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<ProjectBean> list = tmpProjectManager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
			request.setAttribute("listProject", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("success");
		} else if (Constants.Task.Project.GOTOPROJECTDETAIL.equals(pForm.getTask())){
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
			return mapping.findForward("details");
		} else if(Constants.Task.Project.GOTOTASKMEMBER.equals(pForm.getTask())){
			//##. Get Data
			pForm.setEmployeeBean(tmpEmployeeManager.getEmployeeById(pForm.getEmployeeId()));
			pForm.setProjectBean(tmpProjectManager.getProjectById(pForm.getProjectId()));
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
			
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());			
			
			return mapping.findForward("detailMember");
		} else if(Constants.Task.Project.GOTOCREATETASK.equals(pForm.getTask())){
			request.setAttribute("listRoles", tmpRoleManager.getRolesByEmployeeIdAndProjectId(pForm.getProjectBean().getEmployeeId(),  pForm.getProjectBean().getProjectId()));
			
			return mapping.findForward("createTask");
		} else if(Constants.Task.Project.DOCREATETASK.equals(pForm.getTask())){
			
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
		} else if("addmember".equals(pForm.getTask())){
			System.out.println("addmember");
			//belum diisi
			//pForm.getProjectBean().getRoleBean().setRoleId(pForm.getRoleId());
			//pForm.getProjectBean().setEmployeeId(pFor);
			request.setAttribute("listAllRoles", tmpRoleManager.getListAllRole());
			return mapping.findForward("addMember");
		} else if(Constants.Task.Project.DOCREATEMEMBER.equals(pForm.getTask())){
			System.out.println("celllllll");
			pForm.getProjectBean().setProjectMemberId(tmpProjectManager.getNewMemberId());
			pForm.getProjectBean().setEmployeeId(pForm.getEmployeeId());

			pForm.setEmployeeId(pForm.getProjectBean().getEmployeeId());
			pForm.setProjectId(pForm.getProjectBean().getProjectId());
			
			tmpProjectManager.insertMember(pForm.getProjectBean());
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

	private void setPaging(HttpServletRequest request, ProjectForm pForm,
			int countRows, int page, int view) {
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
