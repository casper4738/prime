package prime.user.report.employees;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.user.UserBean;
import prime.constants.Constants;
import prime.user.task.TaskBean;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class ReportEmployeesAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		ReportEmployeesForm pForm = (ReportEmployeesForm) form;
		ReportEmployeesManager tmpManager = new ReportEmployeesManagerImpl();
		
		if(Constants.Task.REPORT.GOTODETAILEMPLOYEE.equals(pForm.getTask())){
			System.out.println("GOTODETAILEMPLOYEE");
			//##. Get Data
			String search = "";
			if("STARTDATE".equals(pForm.getColumnSearchReal()) || "ESTIMATEDATE".equals(pForm.getColumnSearchReal())) {
				search = pForm.getStartDate()+";"+pForm.getUntilDate();
			} else {
				search = pForm.getSearch();
			}
			
			pForm.setReportEmployeesBean(tmpManager.getEmployeeById(pForm.getEmployeeId()));
			int countRows  = tmpManager.getCountListEmployeeTaskReport(pForm.getColumnSearchReal(), search, pForm.getEmployeeId());
			
			List<TaskBean> list = tmpManager.getListEmployeeTaskReport(pForm.getColumnSearchReal(), search,
					PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows), 
					pForm.getEmployeeId());
			
			request.setAttribute("listTask", list);
			request.setAttribute("listSearchColumn", Constants.Search.TASK_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request,pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());			
			return mapping.findForward("detailEmployee");
		}
		else if(Constants.Task.REPORT.GENERATEREPORTEMPLOYEE.equals(pForm.getTask())){
			System.out.println("GENERATEREPORTEMPLOYEE");
			if("ID".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE EMP.EMPLOYEE_ID LIKE ('%" + pForm.getSearch()+ "%')");				
			} else if ("NAME".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER(EMP.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");	
				request.getSession(true).setAttribute("searchQuery2", " WHERE LOWER(EMP.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");	
			} else if ("EMAIL".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER(EMP.EMAIL) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("DIVISION".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (DIV.DIVISION_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("POSITION".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (POS.POSITION_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("MANAGER".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE LOWER (EMPMGR.EMPLOYEE_NAME) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("GENDER".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE GENDER = '"+pForm.getGenderSearch()+"'");
			} else if ("STATUS".equals(pForm.getColumnSearch())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE (CASE WHEN NVL(TO_CHAR(RE.RESIGN_DATE, 'yyyy-mm-dd'), '0') = '0' THEN 0 ELSE 1 END) = '"+pForm.getStatusSearch()+"'");
			} 
			
			return mapping.findForward("showReportEmployee");
		} else if (Constants.Task.REPORT.GENERATEREPORTEMPLOYEETASK.equals(pForm.getTask())) {
			System.out.println("GENERATEREPORTEMPLOYEETASK");
			if("SHOW ALL".equals(pForm.getColumnSearchReal())){
				request.getSession(true).setAttribute("searchQuery", " WHERE (TASK_ASSIGNER='"+pForm.getEmployeeId()+"' OR TASK_RECEIVER='"+pForm.getEmployeeId()+"')");
			}else if("NAME".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE (TASK_ASSIGNER="+pForm.getEmployeeId()+" OR TASK_RECEIVER="+pForm.getEmployeeId()+") AND  TASK_NAME LIKE ('%" + pForm.getSearch()+ "%')");				
			} else if ("DESCRIPTION".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE (TASK_ASSIGNER="+pForm.getEmployeeId()+" OR TASK_RECEIVER="+pForm.getEmployeeId()+") AND LOWER(TASK_DESCRIPTION) LIKE LOWER ('%" + pForm.getSearch()+ "%')");	
			} else if ("ASSIGNER".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE (TASK_ASSIGNER="+pForm.getEmployeeId()+" OR TASK_RECEIVER="+pForm.getEmployeeId()+") AND LOWER(TASK_ASSIGNER) LIKE LOWER ('%" + pForm.getSearch()+ "%')");
			} else if ("RECEIVER".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE (TASK_ASSIGNER="+pForm.getEmployeeId()+" OR TASK_RECEIVER="+pForm.getEmployeeId()+") AND LOWER(TASK_RECEIVER) LIKE LOWER ('%" +pForm.getSearch()+ "%')");
			} else if ("STARTDATE".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE (TASK_ASSIGNER="+pForm.getEmployeeId()+" OR TASK_RECEIVER="+pForm.getEmployeeId()+") AND TASK_START_DATE BETWEEN TO_DATE('"+pForm.getStartDate()+"', 'yyyy-mm-dd') AND TO_DATE('"+pForm.getUntilDate()+"', 'yyyy-mm-dd')");
			} else if ("ESTIMATEDATE".equals(pForm.getColumnSearchReal())) {
				request.getSession(true).setAttribute("searchQuery", " WHERE (TASK_ASSIGNER="+pForm.getEmployeeId()+" OR TASK_RECEIVER="+pForm.getEmployeeId()+") AND TASK_ESTIMATE_DATE BETWEEN TO_DATE('"+pForm.getStartDate()+"', 'yyyy-mm-dd') AND TO_DATE('"+pForm.getUntilDate()+"', 'yyyy-mm-dd')");
			} 
			/*request.getSession(true).setAttribute("searchQuery1", " WHERE EMPLOYEE_ID = '"+pForm.getEmployeeId()+"'");
			request.getSession(true).setAttribute("searchQuery2", " WHERE EMPLOYEE_ID = '"+pForm.getEmployeeId()+"'");
			request.getSession(true).setAttribute("searchQuery3", " WHERE EMPLOYEE_ID = '"+pForm.getEmployeeId()+"'");
			request.getSession(true).setAttribute("searchQuery4", " WHERE EMPLOYEE_ID = '"+pForm.getEmployeeId()+"'");
			request.getSession(true).setAttribute("searchQuery5", " WHERE EMPLOYEE_ID = '"+pForm.getEmployeeId()+"'");
			request.getSession(true).setAttribute("searchQuery6", " WHERE EMP.EMPLOYEE_ID = '"+pForm.getEmployeeId()+"'");
			request.getSession(true).setAttribute("searchQuery7", " WHERE EMPLOYEE_ID '= "+pForm.getEmployeeId()+"'");		*/	
			
			return mapping.findForward("showReportEmployeeTask");
		}

		String search = "";
		if("GENDER".equals(pForm.getColumnSearchReal())) {
			search = pForm.getGenderSearch();
		} else if("STATUS".equals(pForm.getColumnSearchReal())) {
			search = pForm.getStatusSearch();
		} else {
			search = pForm.getSearch();			
		}
		
		System.out.println("MASUK SINI");
		int countRows = tmpManager.getCountByColumn(pForm.getColumnSearchReal(),
				search,((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId());
		List<ReportEmployeesBean> list = tmpManager.getListByColumn(
				pForm.getColumnSearchReal(), search, PrimeUtil
						.getStartRow(pForm.getGoToPage(),
								pForm.getShowInPage(), countRows), PrimeUtil
						.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
								countRows),((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId());
		
		// ##1.Attribute for Table Show
		request.setAttribute("listReportEmployees", list);
		//request.setAttribute("listSearchColumnEmployeeTask", Constants.Search.TASK_SEARCHCOLUMNS);
		request.setAttribute("listSearchColumn",
				Constants.Search.REPORTEMPLOYEE_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries", Constants.PAGINGROWPAGE);
		setPaging(request, pForm, countRows, pForm.getGoToPage(),
				pForm.getShowInPage());
		
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, ReportEmployeesForm pForm,
			int countRows, int page, int view) throws SQLException {
		// ##2.Paging Handling
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

		pForm.setGoToPage(pageUtil.getPage());
	}
}
