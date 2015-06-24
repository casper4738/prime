package prime.user.project;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;
import prime.user.task.TaskManager;
import prime.user.task.TaskManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class ProjectAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		int tmpEmployeeId = 100;
		
		ProjectForm pForm =(ProjectForm) form;
		ProjectManager manager= new ProjectManagerImpl();
		TaskManager tmpTaskManager = new TaskManagerImpl();
		
		if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##.Get Data
			//EmployeeBean tmpTaskAssign 	= tmpEmployeeManager.getEmployeeById(100);
		//	EmployeeBean tmpTaskReceive = tmpEmployeeManager.getEmployeeById(pForm.getProjectReceiver());
			
			//##.Add Data
			System.out.println("masuk add " + manager.getNewId());
			
			//pForm.getProjectBean().setProjectId(manager.getNewId());
			//pForm.getProjectBean().setProjectAssigner(101);
			//pForm.getProjectBean().setProjectAssigner(tmpTaskAssign.getEmployeeId());
			//pForm.getProjectBean().setProjectReceiver(tmpTaskAssign.getEmployeeId());
			
			return mapping.findForward("add");
		} 
		else if (Constants.Task.DOADD.equals(pForm.getTask())){
			//##.Insert Data Task
			//System.out.println("do "+manager.getNewId());
			pForm.getProjectBean().setProjectId(manager.getNewId());
			pForm.getProjectBean().setProjectReceiver(101);
			pForm.getProjectBean().setProjectStatus(1);
			pForm.getProjectBean().setProjectChangeNote("First Time");
			manager.insert(pForm.getProjectBean());
			manager.insertDetail(pForm.getProjectBean());

			
			int countRows  = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<ProjectBean> list = manager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
			request.setAttribute("listProject", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("success");
		} else if (Constants.Task.Project.GOTOPROJECTDETAIL.equals(pForm.getTask())){
			//##.View Detail Project
			pForm.setProjectBean(manager.getProjectById(pForm.getProjectId()));
			int countRows = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<ProjectBean> list = manager.getListProjectMember(pForm.getColumnSearch(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getProjectId());
			request.setAttribute("listProjectMember", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("details");
		} else if(Constants.Task.Project.GOTOTASKMEMBER.equals(pForm.getTask())){
			pForm.setProjectBean(manager.getProjectMemberDetailById(pForm.getEmployeeId()));
			
			int countRows = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			List<ProjectBean> list =manager.getListProjectMemberDetails(pForm.getColumnSearch(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getEmployeeId());
			
			request.setAttribute("listRoles", manager.getRoleName(pForm.getEmployeeId(),pForm.getProjectId()));
			request.setAttribute("listProjectMemberDetails", list);
			request.setAttribute("listSearchColumn", Constants.Search.PROJECT_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("detailMember");
			
		} else if(Constants.Task.Project.GOTOCREATETASK.equals(pForm.getTask())){
			System.out.println("masuk add task " + pForm.getProjectMemberId()+" - "+ pForm.getProjectBean().getProjectMemberId());
			pForm.setProjectBean(manager.getDataProjectMemberByProjectMemberId(pForm.getProjectMemberId()));
			return mapping.findForward("createTask");
		} else if(Constants.Task.Project.DOCREATETASK.equals(pForm.getTask())){
			System.out.println("asdaswd");
			pForm.getProjectBean().getTaskBean().setTaskId(tmpTaskManager.getNewId());
			pForm.getProjectBean().getTaskBean().setTaskAssigner(tmpEmployeeId);
			pForm.getProjectBean().getTaskBean().setTaskReceiver(pForm.getProjectBean().getEmployeeId());
			pForm.getProjectBean().getTaskBean().setProjectMemberId(pForm.getProjectBean().getProjectMemberId());
			
			tmpTaskManager.insert(pForm.getProjectBean().getTaskBean());
			tmpTaskManager.insertDetail(pForm.getProjectBean().getTaskBean());
			return mapping.findForward("forward");
		}
		
		int countRows  = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
		List<ProjectBean> list = manager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
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
