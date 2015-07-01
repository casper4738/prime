package prime.user.notification;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;
import prime.login.LoginData;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class NotificationAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		
		NotificationForm pForm = (NotificationForm) form;
		NotificationManager tmpManager = new NotificationManagerImpl();
		

		System.out.println(pForm.getTask());
		
		//##0.Only two tipe of Notification Action Task
		//----a.Show Notification Page [Usually Null or Forward or Success]
		//----b.Send Notification to Other User Silently ["sendNotification"] --> Not Using Constants ? Will think about it later :)
		if(("sendNotification").equals(pForm.getTask())){
			
		} else {
			//---.Get Count Rows
			int countRows = tmpManager.getCountByColumn(pForm.getColumnSearch(),pForm.getSearch(), LoginData.getEmployeeData().getEmployeeId());

			//---.Set Paging
			List<NotificationBean> list = tmpManager.getListByColumn(
					pForm.getColumnSearch(), pForm.getSearch(), PrimeUtil.getStartRow(pForm.getGoToPage(),
							pForm.getShowInPage(), countRows), PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
							countRows),100);
			
			//---.Attribute for Table Show
			request.setAttribute("listNotification", list);
			request.setAttribute("listSearchColumn",Constants.Search.NOTIFICATION_SEARCHCOLUMNS);
			setPaging(request, countRows, pForm.getGoToPage(),pForm.getShowInPage());
		}
		
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request,
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
	}

}
