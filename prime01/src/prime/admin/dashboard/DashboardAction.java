package prime.admin.dashboard;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
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

public class DashboardAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		DashboardForm pForm = (DashboardForm) form;

		pForm.setEmployeeId(100);

		HolidayManager tmpManager = new HolidayManagerImpl();
		EmployeeManager empManager = new EmployeeManagerImpl();
		String strHoliday = "#f56954";
		String strHoliday2 = "#f56954";
		String strDayOff = "F7F707";
		String strDayOff2 = "#f56954";
		tmpManager.getListByYear(pForm.getYear());
		System.out.println("asd" + pForm.getEmployeeId());
		empManager.getListDayoffByEmployeeId(pForm.getEmployeeId());
		String str;

		List<String> list = new ArrayList<String>();
		
		//##. Set National Holiday Data For Calendar
		int year = Calendar.getInstance().get(Calendar.YEAR);
		for (HolidayBean e : tmpManager.getListByYear(year)) {
			Calendar c = Calendar.getInstance();
			c.setTime(e.getHolidayDate());
			int y = c.get(Calendar.YEAR);
			int m = c.get(Calendar.MONTH);
			int d = c.get(Calendar.DATE);

			str = "{" + "title: '" + e.getHolidayDescription() + "', "
					+ "start: new Date(" + y + ", " + m + ", " + d + "), "
					+ "backgroundColor: '" + strHoliday + "', "
					+ "borderColor: '" + strHoliday2 + "', " + "},";
			list.add(str);
		}
		
		//##. Set Day Off Data For Calendar

		for (EmployeeBean e : empManager.getListDayoffByEmployeeId(pForm
				.getEmployeeId())) {
			System.out.println(pForm.getEmployeeId());
			Calendar c = Calendar.getInstance();
			c.setTime(e.getStartDate());
			int yStart = c.get(Calendar.YEAR);
			int mStart = c.get(Calendar.MONTH);
			int dStart = c.get(Calendar.DATE);
			System.out.println(e.getStartDate());

			c.setTime(e.getEndDate());
			int yEnd = c.get(Calendar.YEAR);
			int mEnd = c.get(Calendar.MONTH);
			int dEnd = c.get(Calendar.DATE)+1;
			System.out.println(e.getEndDate());

			str = "{" + "title: '" + e.getDescriptionDayOff() + "', "
					+ "start: new Date(" + yStart + ", " + mStart + ", "
					+ dStart + "), " + "end: new Date(" + yEnd + ", " + mEnd
					+ ", " + dEnd + ")," + "backgroundColor: '" + strDayOff
					+ "', " + "borderColor: '" + strDayOff2 + "', " + "},";
			list.add(str);
			System.out.println(e.getDescriptionDayOff());
		}

		//##1.Attribute for Dashboard Show
		request.setAttribute("teslist", list);
		return mapping.findForward("success");
	}
}
