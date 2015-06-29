package prime.modal;

import java.util.ArrayList;
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
import prime.admin.position.PositionBean;
import prime.admin.position.PositionManager;
import prime.admin.position.PositionManagerImpl;
import prime.admin.user.UserManager;
import prime.admin.user.UserManagerImpl;
import prime.constants.Constants;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class ModalAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//##0.Temp Variable
		//---.Normally Used Temp Variable
		int tmpI, tmpJ;
		String tmpTarget = "";
		
		//---.Depend on the object
		ModalForm pForm = (ModalForm) form;

		ArrayList<ArrayList<String>> tmpData = new ArrayList<ArrayList<String>>();
		int countRows = 0;
		String task = pForm.getTask();
		
        switch (task) {
        	case "changePwd" :
        		UserManager tmpManager = new UserManagerImpl();
        		 if("changePassword".equals(pForm.getParam1())) {
        			 if(tmpManager.isUserValidated("mahmud21", pForm.getUserBean().getPassword())){
        					tmpManager.changePassword(pForm.getUserBean());
        					request.setAttribute("flag", "true");
        			 } else {
        				 //TO DO :: Not Validated, Force Return
        				 request.setAttribute("flag", "false");
        			 }
        		}
        		 tmpTarget = "changePwd";
        		 break;
	        case "activityNote" :
        		tmpTarget = "activityNote";
        		request.setAttribute("activityId", pForm.getParam2());
        		request.setAttribute("taskId"    , pForm.getParam3());
	        	break;
	        case "taskNote" :
        		tmpTarget = "taskNote";
        		request.setAttribute("taskId"    , pForm.getParam2());
        		request.setAttribute("task"    , pForm.getParam3());
	        	break;
            case "modalTable":  
            	String table=pForm.getParam1();
    			List<EmployeeBean> list;
    			PositionBean listPosition;
        		PositionManager pManager = new PositionManagerImpl();
    			listPosition = pManager.getPositionById(pForm.getParam2());
        		EmployeeManager manager = new EmployeeManagerImpl();
        		ArrayList<String> tmpColHead = new ArrayList<String>();
        		
            	switch(table){
            		case "employeeList"  :
                		tmpTarget = "employeeList";
                		
                    	//##1.Fetch Data From DB
                		countRows  = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
        		
                		//---.Depend On The Object
                		list = manager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
                									   PrimeUtil.getStartRow(pForm.getGoToPage() , pForm.getShowInPage(), countRows),  
                									   PrimeUtil.getEndRow(pForm.getGoToPage()   , pForm.getShowInPage(), countRows));

                		//##2.Prepare Data for Modal-Table Show
                		//---a.Modal Title
                		request.setAttribute("modalListName", "Employees List");
                		request.setAttribute("listSearchColumn", Constants.Search.EMPLOYEE_SEARCHCOLUMNS);
                		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
            			request.setAttribute("modalForm", "employeeUser");
                		
                		//---b.Column Head
                		//[P.S] : Just Hardcode Here, because it only 1 form
                		tmpColHead.add("Employee ID");
                		tmpColHead.add("Name");
                		tmpColHead.add("Gender");
                		tmpColHead.add("Email");
                		tmpColHead.add("Division");
                		tmpColHead.add("Position");
                		tmpColHead.add("Manager");
                		request.setAttribute("listColumnHead", tmpColHead);
                		
                		for(tmpI = 0 ; tmpI < list.size() ; tmpI++){
                			tmpData.add(new ArrayList<String>());
                			tmpData.get(tmpI).add(list.get(tmpI).getEmployeeId().toString());
                			tmpData.get(tmpI).add(list.get(tmpI).getEmployeeName());
                			tmpData.get(tmpI).add((list.get(tmpI).getGender() == 0) ? "Man" : "Woman");
                			tmpData.get(tmpI).add(list.get(tmpI).getEmail());
                			tmpData.get(tmpI).add(list.get(tmpI).getDivisionName());
                			tmpData.get(tmpI).add(list.get(tmpI).getPositionName());
                			tmpData.get(tmpI).add(list.get(tmpI).getManagerName());
                		}
            			break;
            		case "employeeHead":  
                		tmpTarget = "employeeHead";
                		
                    	//##1.Fetch Data From DB
                		countRows  = manager.getCountByColumnEmployeeHead(pForm.getColumnSearch(), pForm.getSearch(), listPosition.getPositionLevel(), pForm.getParam3(), pForm.getParam4(), pForm.getParam5());
                		
                		//---.Depend On The Object
                		list = manager.getListEmployeeHead(pForm.getColumnSearch(), pForm.getSearch(), listPosition.getPositionLevel(),
                										   PrimeUtil.getStartRow(pForm.getGoToPage() , pForm.getShowInPage(), countRows),  
                										   PrimeUtil.getEndRow(pForm.getGoToPage()   , pForm.getShowInPage(), countRows), pForm.getParam3(), pForm.getParam4(), pForm.getParam5());
                		
                		//##2.Prepare Data for Modal-Table Show
                		//---a.Modal Title
                		request.setAttribute("modalListName", "Employees List");
                		request.setAttribute("listSearchColumn", Constants.Search.EMPLOYEE_SEARCHCOLUMNS);
                		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
                		
                		if(pForm.getParam3().equals("employeeAdd") || pForm.getParam3().equals("employeeEditPosDiv")){
                			request.setAttribute("modalForm", "employeeHead");
                		}else if(pForm.getParam3().equals("employeeResign")){
                			request.setAttribute("modalForm", "employeeResign");
                		}else if(pForm.getParam3().equals("projectAssigner")){
                			request.setAttribute("modalForm", "project");
                		}else if(pForm.getParam3().equals("projectMember")){
                			request.setAttribute("modalForm", "projectMember");
                		}
                		
                		//---b.Column Head
                		//[P.S] : Just Hardcode Here, because it only 1 form
                		tmpColHead.add("Employee ID");
                		tmpColHead.add("Name");
                		tmpColHead.add("Gender");
                		tmpColHead.add("Email");
                		tmpColHead.add("Division");
                		tmpColHead.add("Position");
                		tmpColHead.add("Manager");
                		request.setAttribute("listColumnHead", tmpColHead);
                		
                		for(tmpI = 0 ; tmpI < list.size() ; tmpI++){
                			tmpData.add(new ArrayList<String>());
                			tmpData.get(tmpI).add(list.get(tmpI).getEmployeeId().toString());
                			tmpData.get(tmpI).add(list.get(tmpI).getEmployeeName());
                			tmpData.get(tmpI).add((list.get(tmpI).getGender() == 0) ? "Man" : "Woman");
                			tmpData.get(tmpI).add(list.get(tmpI).getEmail());
                			tmpData.get(tmpI).add(list.get(tmpI).getDivisionName());
                			tmpData.get(tmpI).add(list.get(tmpI).getPositionName());
                			tmpData.get(tmpI).add(list.get(tmpI).getManagerName());;
                		}
                		break;
            		default:
                		break;
            	}
        		request.setAttribute("listTableData", tmpData);
        		
        		//##3.Set Paging
        		request.setAttribute("listSearchColumn", Constants.Search.EMPLOYEE_SEARCHCOLUMNS);
        		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
        		setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
        		break;
         
            default:
                break;
        }
        
		return mapping.findForward(tmpTarget);
	}
	
	private void setPaging(HttpServletRequest request, int countRows, int page, int view) {
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
