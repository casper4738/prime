package prime.admin.dashboard;

import java.util.ArrayList;
import java.util.Calendar;
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
import prime.admin.holiday.HolidayBean;
import prime.admin.holiday.HolidayManager;
import prime.admin.holiday.HolidayManagerImpl;
import prime.admin.user.UserBean;
import prime.constants.Constants;

public class DashboardAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		DashboardForm pForm = (DashboardForm) form;

		pForm.setEmployeeId(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId());
		
		HolidayManager tmpManager = new HolidayManagerImpl();
		EmployeeManager empManager = new EmployeeManagerImpl();
		
		tmpManager.getListByYear(pForm.getYear());
		empManager.getListDayoffByEmployeeId(pForm.getEmployeeId());

		List<String> list = new ArrayList<String>();
		
		//##. Set National Holiday Data For Calendar
		int year = Calendar.getInstance().get(Calendar.YEAR);
		List<HolidayBean> listHolidayBean = tmpManager.getListByYear(year);
		for (HolidayBean e : listHolidayBean) {
			list.add(getHoliday(e)+  ", " );
		}
		
		for (EmployeeBean e : empManager.getListDayoffByEmployeeId(pForm.getEmployeeId())) {
			list.add(getEmployeeDayOff(e)+  ", " );
		}

		//##1.Attribute for Dashboard Show
		request.setAttribute("teslist", list);
		return mapping.findForward("success");
	}
	
	private String getHoliday(HolidayBean e) {
		String backgroundColor = "#f56954";
		String borderColor = "#f56954";
		
		Calendar c = Calendar.getInstance();
		c.setTime(e.getHolidayDate());
		int y = c.get(Calendar.YEAR);
		int m = c.get(Calendar.MONTH);
		int d = c.get(Calendar.DATE);

		String str = "{title: \"" + e.getHolidayDescription() + " \", "
				+ "start: new Date("+ y + ", " + m + ", " + d + "), "
				+ "backgroundColor: '" + backgroundColor + "', "
				+ "borderColor: '" + borderColor + "' } ";
		return str;
	}
	
	private String getEmployeeDayOff(EmployeeBean e) {
		String backgroundColor = "F7F707";
		String borderColor = "#f56954";
		
		Calendar c = Calendar.getInstance();
		c.setTime(e.getStartDate());
		int yStart = c.get(Calendar.YEAR);
		int mStart = c.get(Calendar.MONTH);
		int dStart = c.get(Calendar.DATE);

		c.setTime(e.getEndDate());
		int yEnd = c.get(Calendar.YEAR);
		int mEnd = c.get(Calendar.MONTH);
		int dEnd = c.get(Calendar.DATE)+1;

		String str = "{title: \"" + e.getDescriptionDayOff() + "\", "
				+ "start: new Date(" + yStart + ", " + mStart + ", "+ dStart + "), " 
				+ "end: new Date(" + yEnd + ", " + mEnd + ", " + dEnd + ")," 
				+ "backgroundColor: '" + backgroundColor+ "', " 
				+ "borderColor: '" + borderColor + "' } ";
		return str;
	}
	
}
