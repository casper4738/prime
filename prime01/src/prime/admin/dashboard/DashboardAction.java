package prime.admin.dashboard;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class DashboardAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
//		ImageUtil.decode(ImageUtil.encodeToString(request.getContextPath() + "/image/Lighthouse.jpg"));
		String str2 = "#f56954";
		String str3 = "#f56954";
		
		String str;
		List<String> list = new ArrayList<String>();
		str = "{title: '"+"Event 1"+"', start: new Date(y, m, 1), backgroundColor: '"+str2+"', borderColor: '"+str3+"'},";
		list.add(str);

		str = "{title: '"+"Event 2"+"', start: new Date(y, m, 2), backgroundColor: '"+str2+"', borderColor: '"+str3+"'},";
		list.add(str);
		
		str = "{title: '"+"Event 3"+"', start: new Date(y, m, 3), backgroundColor: '"+str2+"', borderColor: '"+str3+"'},";
		list.add(str);
		
		str = "{title: '"+"Event 4"+"', start: new Date(y, m, 4), backgroundColor: '"+str2+"', borderColor: '"+str3+"'},";
		list.add(str);
		
		str = "{title: '"+"Event 5"+"', start: new Date(y, m, 5), backgroundColor: '"+str2+"', borderColor: '"+str3+"'}";
		list.add(str);

		request.setAttribute("teslist", list);
		return mapping.findForward("success");
	}
}
