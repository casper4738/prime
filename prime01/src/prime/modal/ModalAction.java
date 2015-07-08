package prime.modal;

import java.io.PrintWriter;
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
import prime.admin.user.UserBean;
import prime.admin.user.UserManager;
import prime.admin.user.UserManagerImpl;
import prime.constants.Constants;
import prime.user.activity.ActivityBean;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
import prime.user.project.ProjectForm;
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
		EmployeeBean tmpEmployeeData = (EmployeeBean)request.getSession().getAttribute(Constants.Session.Employeedata);
		UserBean tmpUserData = (UserBean)request.getSession().getAttribute(Constants.Session.Userdata);
		Integer tmpEmployeeID = tmpEmployeeData.getEmployeeId();
		
		//---.Depend on the object
		ModalForm pForm = (ModalForm) form;

		ArrayList<ArrayList<String>> tmpData = new ArrayList<ArrayList<String>>();
		int countRows = 0;
		String task = pForm.getTask();
		
		System.out.println("task=" + task + "&param1=" + pForm.getParam1() + "&param2=" + pForm.getParam2()+ "&param3=employeeResign&param4="+pForm.getParam4()+"&param5="+pForm.getParam5());
		
        switch (task) {
	        case "insertEmployeeToDoList" :
	    		ActivityManager tmpActivityManager = new ActivityManagerImpl();
	    		tmpActivityManager.insertToDoList(tmpEmployeeID,pForm.getParam2());
	    		return null;
        	case "changePwd" :
        		UserManager tmpManager = new UserManagerImpl();
     			response.setContentType("text/text;charset=utf-8");
     			response.setHeader("cache-control", "no-cache");
     			PrintWriter tmpOut = response.getWriter();
     			String tmpResponse = "";
     			
        		 if("doChangePwd".equals(pForm.getParam1())) {
            		 //---.Validate User
            		 if(tmpManager.isUserValidated(tmpUserData.getUserName(), pForm.getParam3())){
     					tmpManager.changePassword(tmpUserData.getUserName(), pForm.getParam6());
             			tmpResponse = "1#<center><div id=\"message\" style=\"color:green;font-size:12px\">Password changed successfuly</div></center>";
             			
             			//Invalidate Session
                   		request.getSession().invalidate();
             			request.getSession(true).setAttribute(Constants.Session.isSessionExpired, true);
            		 } 
            		 //---.Fail Just Return and Inform
            		 else {
            			tmpResponse = "0#<center><div id=\"message\" style=\"color:red;font-size:12px\"><i>Password doesn't match</div><center>";
        			 }

          			tmpOut.print(tmpResponse);
          			tmpOut.flush();
  					return null;
        		 } 
        		 else {
        			 //Do Nothing
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
                		
                		String search = "";
                		if("GENDER".equals(pForm.getColumnSearchReal())) {
                			search = pForm.getGenderSearch();
                		} else if("STATUS".equals(pForm.getColumnSearchReal())) {
                			search = pForm.getStatusSearch();
                		} else {
                			search = pForm.getSearch();			
                		}
                		
                    	//##1.Fetch Data From DB
                		countRows  = manager.getCountByColumnEmployeeActive(pForm.getColumnSearchReal(), search);
                		
                		//---.Depend On The Object
                		list = manager.getListByColumnEmployeeActive(pForm.getColumnSearchReal(), search,
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
                			tmpData.get(tmpI).add((list.get(tmpI).getGender() == 0) ? "Male" : "Female");
                			tmpData.get(tmpI).add(list.get(tmpI).getEmail());
                			tmpData.get(tmpI).add(list.get(tmpI).getDivisionName());
                			tmpData.get(tmpI).add(list.get(tmpI).getPositionName());
                			tmpData.get(tmpI).add(list.get(tmpI).getManagerName());
                		}
            			break;
            		case "employeeHead":  
                		tmpTarget = "employeeHead";            		
                			
            			search = "";
                		if("GENDER".equals(pForm.getColumnSearchReal())) {
                			search = pForm.getGenderSearch();
                		} else if("STATUS".equals(pForm.getColumnSearchReal())) {
                			search = pForm.getStatusSearch();
                		} else {
                			search = pForm.getSearch();			
                		}
            			
                    	//##1.Fetch Data From DB
                		countRows  = manager.getCountByColumnEmployeeHead(pForm.getColumnSearchReal(), search, listPosition.getPositionLevel(), pForm.getParam3(), pForm.getParam4(), pForm.getParam5());
                		
                		//---.Depend On The Object
                		list = manager.getListEmployeeHead(pForm.getColumnSearchReal(),search, listPosition.getPositionLevel(),
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
            		case "employeeTree"  :
                		tmpTarget = "employeeTree";
                    	//##1.Fetch Data From DB
                		countRows = manager.getCountListByTree(pForm.getColumnSearch(), pForm.getSearch(), tmpEmployeeData.getEmployeeId());
                		//---.Depend On The Object
                		list = manager.getListByTree(pForm.getColumnSearch(), pForm.getSearch(),
				   				 PrimeUtil.getStartRow(pForm.getGoToPage() , pForm.getShowInPage(), countRows),  
				   				 PrimeUtil.getEndRow(pForm.getGoToPage()   , pForm.getShowInPage(), countRows), tmpEmployeeData.getEmployeeId());
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
                			System.out.println("masuk list");
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
            			
            		case "employeeProjectMember"  :
                		tmpTarget = "employeeProjectMember";
                		ProjectForm project = new ProjectForm();
                		System.out.println("modal id assigner "+project.getIdAssigner());
                		
                		System.out.println("id login modal "+ tmpEmployeeData.getEmployeeId());
                    	//##1.Fetch Data From DB
                		countRows = manager.getCountListByTreeforMember(pForm.getColumnSearch(), pForm.getSearch(), pForm.getParam2(), pForm.getParam4());
                		//---.Depend On The Object
                		System.out.println("count rows modal "+countRows);
                		list = manager.getListTreeforMember(pForm.getColumnSearch(), pForm.getSearch(),
				   				 PrimeUtil.getStartRow(pForm.getGoToPage() , pForm.getShowInPage(), countRows),  
				   				 PrimeUtil.getEndRow(pForm.getGoToPage()   , pForm.getShowInPage(), countRows),pForm.getParam2(), pForm.getParam4());
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
                			System.out.println("masuk list");
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
            		case "employeeChangePM"  :
                		tmpTarget = "employeeChangePM";
                		
                		System.out.println("id login modalss "+ tmpEmployeeData.getEmployeeId());
                		System.out.println("datanya "+ pForm.getParam5());
                    	//##1.Fetch Data From DB
                		countRows = manager.getCountListByTreeforChangePM(pForm.getColumnSearch(), pForm.getSearch(), tmpEmployeeData.getEmployeeId(), pForm.getParam5());
                		//---.Depend On The Object
                		System.out.println("count rows modal "+countRows);
                		list = manager.getListTreeforChangePM(pForm.getColumnSearch(), pForm.getSearch(),
				   				 PrimeUtil.getStartRow(pForm.getGoToPage() , pForm.getShowInPage(), countRows),  
				   				 PrimeUtil.getEndRow(pForm.getGoToPage()   , pForm.getShowInPage(), countRows),tmpEmployeeData.getEmployeeId(), pForm.getParam5());
                		System.out.println("jumlah list"+list.size());
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
                			System.out.println("masuk list");
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
            		case "activityList":  
                		tmpTarget = "activityList";
                		List<ActivityBean> listActivity;	
                		ActivityManager managerActivity = new ActivityManagerImpl();
                		
                		System.out.println(tmpEmployeeID+"--"+pForm.getColumnSearch()+"--"+pForm.getSearch());
	                    //##1.Fetch Data From DB
                		countRows = managerActivity.getCountListActivityById(tmpEmployeeID,pForm.getColumnSearch(),pForm.getSearch());
                		
                		//---.Depend On The Object
                		listActivity = managerActivity.getListActivityById(tmpEmployeeID,pForm.getColumnSearch(), 
								 pForm.getSearch(), PrimeUtil.getStartRow(
								 pForm.getGoToPage(), pForm.getShowInPage(), countRows),
								 PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
								 countRows));
                	
                		//##2.Prepare Data for Modal-Table Show
                		//---a.Modal Title
                		request.setAttribute("modalListName", "Activity List");
                		System.out.println(Constants.Search.ACTIVITY_SEARCHCOLUMNS);
                		request.setAttribute("listSearchColumnActivity", Constants.Search.ACTIVITY_SEARCHCOLUMNS);
                		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
                		
                		
                		request.setAttribute("modalForm", "activityForm");
                		
                		
                		//---b.Column Head
                		//[P.S] : Just Hardcode Here, because it only 1 form
                		tmpColHead.add("Activity ID");
                		tmpColHead.add("Activity Name");
                		tmpColHead.add("Activity Description");
                		tmpColHead.add("Task Name");
                		tmpColHead.add("Assigner");
                		tmpColHead.add("Last Status");
                		
                		request.setAttribute("listColumnHead", tmpColHead);
                		
                		for(tmpI = 0 ; tmpI < listActivity.size() ; tmpI++){
                			tmpData.add(new ArrayList<String>());
                			tmpData.get(tmpI).add(listActivity.get(tmpI).getActivityId().toString());
                			tmpData.get(tmpI).add(listActivity.get(tmpI).getActivityName());
                			tmpData.get(tmpI).add(listActivity.get(tmpI).getActivityDescription());
                			tmpData.get(tmpI).add(listActivity.get(tmpI).getTaskName());
                			tmpData.get(tmpI).add(listActivity.get(tmpI).getTaskAssignerName());
                			tmpData.get(tmpI).add(listActivity.get(tmpI).getActivityStatus().toString());
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
		request.setAttribute("pageNow", pageUtil.getPage());
		request.setAttribute("pageFirst", 1);
		request.setAttribute("pageLast", pageUtil.getSumOfPage());
		request.setAttribute("pagePrev", pageUtil.getPagePrev());
		request.setAttribute("pageNext", pageUtil.getPageNext());
		request.setAttribute("listMaxDataPerPage", Constants.PAGINGROWPAGE);
	}
}
