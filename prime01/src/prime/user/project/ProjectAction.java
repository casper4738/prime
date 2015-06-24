package prime.user.project;

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
import prime.user.task.TaskBean;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class ProjectAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		//return super.execute(mapping, form, request, response);
		ProjectForm pForm =(ProjectForm) form;
		ProjectManager manager= new ProjectManagerImpl();
		EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();

		
		//ActivityManager tmpActivityManager = new ActivityManagerImpl();
		
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
		}
		else if (Constants.Task.GOTOVIEW.equals(pForm.getTask())){
			//##.View Detail Project
			pForm.setProjectBean(manager.getProjectById(pForm.getProjectId()));
			//pForm.getRoleId();
			int countRows = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			
			List<ProjectBean> list =manager.getListProjectMember(pForm.getColumnSearch(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getProjectId());
			request.setAttribute("listProjectMember", list);
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("details");
		}
		else if("memberDetails".equals(pForm.getTask())){
			System.out.println("masuk member" + pForm.getProjectId() + " "+pForm.getEmployeeId());
			pForm.setProjectBean(manager.getProjectMemberDetailById(pForm.getEmployeeId()));
			
			
			
			int countRows = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
			
			List<ProjectBean> list =manager.getListProjectMemberDetails(pForm.getColumnSearch(), pForm.getSearch(), 
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(),pForm.getShowInPage(), countRows),
					pForm.getEmployeeId());
			
			//request.setAttribute("listRoles", listRole);
			request.setAttribute("listRoles", manager.getRoleName(pForm.getEmployeeId(),pForm.getProjectId()));
			request.setAttribute("listProjectMemberDetails", list);
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("detailMember");
			
		}
		else if("addTask".equals(pForm.getTask())){
			//System.out.println("masuk add task " + pForm.getProjectMemberId()+" - "+ pForm.getProjectBean().getProjectMemberId());
			
			
			return mapping.findForward("createTask");
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
