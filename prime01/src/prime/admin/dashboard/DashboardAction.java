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

import prime.admin.holiday.HolidayBean;
import prime.admin.holiday.HolidayManager;
import prime.admin.holiday.HolidayManagerImpl;

public class DashboardAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		DashboardForm pForm = (DashboardForm) form;
		HolidayManager tmpManager = new HolidayManagerImpl();
		String str2 = "#f56954";
		String str3 = "#f56954";
		tmpManager.getListByYear(pForm.getYear());
		String str;
		
		List<String> list = new ArrayList<String>();

		int year = Calendar.getInstance().get(Calendar.YEAR);
		for (HolidayBean e : tmpManager.getListByYear(year)) {
			Calendar c = Calendar.getInstance();
			c.setTime(e.getHolidayDate());
			int y = c.get(Calendar.YEAR);
			int m = c.get(Calendar.MONTH);
			int d = c.get(Calendar.DATE);
			
			str = "{"
					+ "title: '"+e.getHolidayDescription()+"', "
					+ "start: new Date("+y+", "+m+", "+d+"), "
					+ "backgroundColor: '"+str2+"', "
					+ "borderColor: '"+str3+"', "
					+ "},";
			list.add(str);
		}
		
		
		
		System.out.println("masuk");
		request.setAttribute("teslist", list);
		return mapping.findForward("success");
	}
}
