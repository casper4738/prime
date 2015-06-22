package prime.modal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class ModalAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//##0.Temp Variable
		//---.Normally Used Temp Variable
		int tmpI, tmpJ;
		
		//---.Depend on the object
		List<EmployeeBean> list;
		EmployeeManager manager = new EmployeeManagerImpl();
		ModalForm pForm = (ModalForm) form;
		
		System.out.println("Taskzz = " + pForm.getTask());
		
		//##1.Fetch Data From DB
		int countRows  = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
		
		//---.Depend On The Object
		list = manager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
									   PrimeUtil.getStartRow(pForm.getGoToPage() , pForm.getShowInPage(), countRows),  
									   PrimeUtil.getEndRow(pForm.getGoToPage()   , pForm.getShowInPage(), countRows));

		//##2.Prepare Data for Modal-Table Show
		//---a.Modal Title
		request.setAttribute("modalListName", "Employees List");
		
		//---b.Column Head
		//[P.S] : Just Hardcode Here, because it only 1 form
		ArrayList<String> tmpColHead = new ArrayList<String>();
		tmpColHead.add("Employee ID");
		tmpColHead.add("Name");
		tmpColHead.add("Gender");
		//tmpColHead.add("Email");
		//tmpColHead.add("Division");
		//tmpColHead.add("Position");
		//tmpColHead.add("Manager");
		request.setAttribute("listColumnHead", tmpColHead);
		
		ArrayList<ArrayList<String>> tmpData = new ArrayList<ArrayList<String>>();
		for(tmpI = 0 ; tmpI < list.size() ; tmpI++){
			tmpData.add(new ArrayList<String>());
			tmpData.get(tmpI).add(list.get(tmpI).getEmployeeId().toString());
			tmpData.get(tmpI).add(list.get(tmpI).getEmployeeName());
			tmpData.get(tmpI).add((list.get(tmpI).getGender() == 0) ? "Man" : "Woman");
			//tmpData.get(tmpI).add(list.get(tmpI).getEmail());
			//tmpData.get(tmpI).add(list.get(tmpI).getDivisionName());
			//tmpData.get(tmpI).add(list.get(tmpI).getPositionName());
			//tmpData.get(tmpI).add(list.get(tmpI).getManagerName());
		}
		request.setAttribute("listTableData", tmpData);
		
		//##3.Set Paging
		request.setAttribute("listSearchColumn", Constants.Search.EMPLOYEE_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
		setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		
		return mapping.findForward("success");
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
