package prime.admin.employee;

import java.lang.reflect.Array;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.division.DivisionManager;
import prime.admin.division.DivisionManagerImpl;
import prime.admin.position.PositionManager;
import prime.admin.position.PositionManagerImpl;
import prime.constants.Constants;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class EmployeeAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		EmployeeForm pForm = (EmployeeForm) form;
		EmployeeManager manager = new EmployeeManagerImpl();
		DivisionManager tmpDivisionManager = new DivisionManagerImpl();
		PositionManager tmpPositionManager = new PositionManagerImpl();
		
		if(Constants.Task.GOTOMANAGER.equals(pForm.getTask())) {
			request.setAttribute("listDivision", tmpDivisionManager.getListAll());
			int countRows  = manager.getCountByColumnAndDivision(pForm.getColumnSearch(), pForm.getSearch(), pForm.getEmployeeBean().getDivisionId());
			
			List<EmployeeBean> list = manager.getListByColumnAndDivision(pForm.getColumnSearch(), pForm.getSearch(), pForm.getEmployeeBean().getDivisionId(), 
																		 PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
																		 PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
			request.setAttribute("listEmployee", list);
			request.setAttribute("listSearchColumn", Constants.Search.POSITION_SEARCHCOLUMNS);
			setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
			return mapping.findForward("choose_manager");
		} else if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			request.setAttribute("listPosition", tmpPositionManager.getListAll());
			request.setAttribute("listDivision", tmpDivisionManager.getListAll());
			return mapping.findForward("add");
		} else if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			EmployeeBean tmpEmployee = manager.getEmployeeById(pForm.getTmpId());
			System.out.println(pForm.getTmpId()+" Employee ID "+ tmpEmployee.getManagerId());
			if(tmpEmployee.getManagerId() != null) {
				EmployeeBean tmpManager = manager.getEmployeeById(tmpEmployee.getManagerId());
			}
			System.out.println("Masuk Edit2");
			pForm.setEmployeeBean(tmpEmployee);
			System.out.println("Masuk Edit");
			//request.setAttribute("listPosition", tmpPositionManager.getListAll());
			return mapping.findForward("edit");
		} else if(Constants.Task.GOTORESIGN.equals(pForm.getTask())) {
			EmployeeBean tmpEmployee = manager.getEmployeeById(pForm.getTmpId());
			System.out.println(pForm.getTmpId()+" Employee ID MASUK RESIGN");
			pForm.setEmployeeBean(tmpEmployee);
			pForm.setEmployeeId(pForm.getTmpId());
			pForm.getEmployeeBean().setResignDate(new java.sql.Date(new java.util.Date().getTime()));
			request.setAttribute("listPosition", tmpPositionManager.getListAll());
			return mapping.findForward("resign");
		} else if(Constants.Task.GOTOVIEW.equals(pForm.getTask())) {
			pForm.setEmployeeBean(manager.getEmployeeById(pForm.getTmpId()));
			List<EmployeeBean> listWeekendByEmployeeId = manager.getListWeekendByEmployeeId(pForm.getTmpId());
			List<EmployeeBean> listDayoffByEmployeeId = manager.getListDayoffByEmployeeId(pForm.getTmpId());
			request.setAttribute("listWeekendByEmployeeId", listWeekendByEmployeeId);	
			request.setAttribute("listDayoffByEmployeeId", listDayoffByEmployeeId);
			return mapping.findForward("view");
		} else if(Constants.Task.GOTODAYOFF.equals(pForm.getTask())) {
			EmployeeBean tmpEmployee = manager.getEmployeeById(pForm.getTmpId());
			System.out.println(pForm.getTmpId()+" Employee ID MASUK DAYOFF");
			pForm.setEmployeeBean(tmpEmployee);
			request.setAttribute("listPosition", tmpPositionManager.getListAll());
			return mapping.findForward("dayoff");
		} else if(Constants.Task.GOTOWEEKEND.equals(pForm.getTask())) {
			EmployeeBean tmpEmployee = manager.getEmployeeById(pForm.getTmpId());
			System.out.println(pForm.getTmpId()+" Employee ID MASUK WEEKEND");
			pForm.setEmployeeBean(tmpEmployee);
			Map<Integer, String> monthsList = new HashMap<Integer, String>();
		    String[] months = new DateFormatSymbols().getMonths();
		    
		    Calendar now = Calendar.getInstance();
		    int year = now.get(Calendar.YEAR);
		    String yearInString = String.valueOf(year);
		    for (int i = 0; i < months.length-1; i++) {
		      String month = months[i];
		      System.out.println("month = " + month + yearInString);
		      String str = months[i]+" "+yearInString;
		      monthsList .put(i, str);
		    }
			request.setAttribute("listMonthYear", monthsList);
			return mapping.findForward("weekend");
		} else if(Constants.Task.DOADD.equals(pForm.getTask())) {
			pForm.getEmployeeBean().setEmployeeId(manager.getNewId());
			pForm.getEmployeeBean().setDivisionId(pForm.getDivisionId());
			pForm.getEmployeeBean().setManagerId(pForm.getManagerId());
			manager.insert(pForm.getEmployeeBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DORESIGN.equals(pForm.getTask())) {
			manager.insertResign(pForm.getEmployeeBean());
			// FOR UPDATE HEAD ID WHERE OLD HEAD ID WAS RESIGN 
			System.out.println(pForm.getEmployeeBean().getEmployeeId() + "EmployeeId");
			System.out.println(pForm.getSubstituteHeadId() + "SubstituteHead");
			manager.updateHead(pForm.getEmployeeBean().getEmployeeId(),pForm.getSubstituteHeadId());
			
			//FOR UPDATE STATUS USER
			manager.updateStatusUser(pForm.getEmployeeBean().getEmployeeId());
			
			return mapping.findForward("forward");
		} else if(Constants.Task.DOEDIT.equals(pForm.getTask())) {
			EmployeeBean tmpEmployee = pForm.getEmployeeBean();
			manager.update(tmpEmployee);
			return mapping.findForward("forward");
		} else if(Constants.Task.DOWEEKEND.equals(pForm.getTask())) {
			pForm.getEmployeeBean().setWeekEnd(pForm.getWeekEnds());
			String startDateString= pForm.getListMondayDate();
			
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy"); 
		    java.sql.Date startDate = new java.sql.Date(df.parse(startDateString).getTime());

		    pForm.getEmployeeBean().setStartFrom(startDate);
			manager.insertWeekend(pForm.getEmployeeBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DODAYOFF.equals(pForm.getTask())) {
			manager.insertDayoff(pForm.getEmployeeBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.GOTOEDITWEEKEND.equals(pForm.getTask())) {
			EmployeeBean tmpEmployee = manager.getEmployeeWeekendByIdAndStartFrom(pForm.getTmpId(),pForm.getTmpString());
			pForm.setEmployeeBean(tmpEmployee);
			
			/*String res = pForm.getEmployeeBean().getWeekEnd();
			String[] resSplit = res.split(",");
			System.out.println(resSplit.length + "LENGTH");
			
			for(int i = 0;i<resSplit.length;i++){
				pForm.setWeekEnd(resSplit[i]);
			}*/
			//pForm.setWeekEnd("Monday");
			
			return mapping.findForward("weekendEdit");
		} else if(Constants.Task.DOEDITWEEKEND.equals(pForm.getTask())) {
			System.out.println(pForm.getEmployeeBean().getDescriptionWeekEnd()+" DESC WEEK");
			System.out.println(pForm.getWeekEnds()+" WEKEND");
			pForm.getEmployeeBean().setWeekEnd(pForm.getWeekEnds());
			manager.updateWeekend(pForm.getEmployeeBean());
			return mapping.findForward("forward");
		}  else if(Constants.Task.DOEDITDAYOFF.equals(pForm.getTask())) {
			//pForm.getEmployeeBean().set;
			manager.updateWeekend(pForm.getEmployeeBean());
		} else if(Constants.Task.GOTOEDITPOSITION.equals(pForm.getTask())) {
			System.out.println("Masuk EditPosDiv"+ pForm.getTmpId());
			EmployeeBean tmpEmployee = manager.getEmployeeById(pForm.getTmpId());
			System.out.println(pForm.getTmpId()+" Employee ID "+ tmpEmployee.getManagerId());
			if(tmpEmployee.getManagerId() != null) {
				EmployeeBean tmpManager = manager.getEmployeeById(tmpEmployee.getManagerId());
			}
			
			pForm.setDivisionId(tmpEmployee.getDivisionId());
			pForm.setManagerId(tmpEmployee.getManagerId());
			pForm.setEmployeeBean(tmpEmployee);
			pForm.setEmployeeId(pForm.getTmpId());
			pForm.setSubstituteHeadId(pForm.getTmpId());
			request.setAttribute("listPosition", tmpPositionManager.getListAll());
			request.setAttribute("listDivision", tmpDivisionManager.getListAll());
			return mapping.findForward("positionDivisionEdit");
		}else if(Constants.Task.DOEDITPOSITION.equals(pForm.getTask())) {
			// FOR UPDATE SELF EMPLOYEE
			pForm.getEmployeeBean().setDivisionId(pForm.getDivisionId());
			pForm.getEmployeeBean().setManagerId(pForm.getManagerId());
			EmployeeBean tmpEmployee = pForm.getEmployeeBean();
			manager.updatePositionDivision(tmpEmployee);
			
			//FOR UPDATE HEAD ID WHERE OLD HEAD ID WAS CHANGE POSITION OR DIVISION 
			manager.updateHead(pForm.getEmployeeBean().getEmployeeId(),pForm.getSubstituteHeadId());
			return mapping.findForward("forward");
		} 
		
		int countRows  = manager.getCountByColumn(pForm.getColumnSearch(), pForm.getSearch());
		List<EmployeeBean> list = manager.getListByColumn(pForm.getColumnSearch(), pForm.getSearch(),
														  PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
														  PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));

		//##1.Attribute For Table Paging
		request.setAttribute("listEmployee", list);
		request.setAttribute("listSearchColumn", Constants.Search.EMPLOYEE_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
		setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, int countRows, int page, int view)
			throws SQLException {
		//##0.Paging Number Handling
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
	
	private Map<Integer,Integer> getEmployeeLevel(int min) {
		Map<Integer,Integer> map = new HashMap<Integer, Integer>();
		for (int i = min; i <= 8; i++) {
			map.put(i, i);
		}
		return map;
	}

}
