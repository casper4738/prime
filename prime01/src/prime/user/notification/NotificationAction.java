package prime.user.notification;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.notiftemplate.NotifTemplateBean;
import prime.admin.notiftemplate.NotifTemplateManager;
import prime.admin.notiftemplate.NotifTemplateManagerImpl;
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
			NotifTemplateManager tmpNotifTempManager = new NotifTemplateManagerImpl();
			NotifTemplateBean tmpNotifTempBean = tmpNotifTempManager.getNotifTemplateById(pForm.getNotifType());
			
			//---.Three main variable needed : From [ID | Name], To[ID | Name], Link [Direct Getter Link]
			//	 . Logic : Convert The Fetched Param to String and Insert it To Map
			//   .         Replace Notif Template String with the Map
			int tmpI;
			HashMap tmpMap  = new HashMap<>();
			String tmpTemplate  = tmpNotifTempBean.getNotifTemplateValue();
			String tmpReceived  = pForm.getNotifParam();
			String[] tmpParam1  = tmpReceived.split(";");
			String[] tmpParam2;
			
			for(tmpI = 0 ; tmpI < tmpParam1.length ; tmpI++){
				tmpParam2 = tmpParam1[tmpI].split("=");
				tmpMap.put(tmpParam2[0], tmpParam2[1]);
				System.out.println(tmpParam2[0] + " _ " + tmpParam2[1]);
				tmpTemplate.replace("&" + tmpParam2[0] + "&", tmpParam2[1]);
			}
			System.out.println(tmpTemplate);
		
			//---.Send Email with Mail Util
			
			
			//---.Send Notification to specified ID with specified Param
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
