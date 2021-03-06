package prime.user.notification;

import java.io.PrintWriter;
import java.sql.SQLException;
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
import prime.admin.notiftemplate.NotifTemplateBean;
import prime.admin.notiftemplate.NotifTemplateManager;
import prime.admin.notiftemplate.NotifTemplateManagerImpl;
import prime.admin.user.UserBean;
import prime.constants.Constants;
import prime.utility.MailUtil;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class NotificationAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		NotificationForm pForm = (NotificationForm) form;
		NotificationManager tmpManager = new NotificationManagerImpl();
		
		//##0.Only two tipe of Notification Action Task
		//----a.Show Notification Page [Usually Null or Forward or Success]
		//----b.Send Notification to Other User Silently ["sendNotification"] --> Not Using Constants ? Will think about it later :)
		if(("sendNotification").equals(pForm.getTask())){
			//---.Three main variable needed : From [ID | Name], To[ID | Name], Link [Direct Getter Link]
			//	 . Logic : Convert The Fetched Param to String and Insert it To Map
			//   .         Replace Notif Template String with the Map
			int tmpI;
			int tmpId = tmpManager.getNewId();
			
			NotifTemplateManager tmpNotifTempManager = new NotifTemplateManagerImpl();
			NotifTemplateBean tmpNotifTempBean = tmpNotifTempManager.getNotifTemplateById(pForm.getNotifType());
			
			EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
			EmployeeBean tmpReceiverBean = tmpEmployeeManager.getEmployeeById(pForm.getNotifReceiverID());
			
			//---.Send Notification to specified ID with specified Param
			String[] tmpNotifLinkParam = pForm.getNotifParam().split(";");
			String tmpBackLink = "Menu.do?" +
							  	 "task=redirect&" +
							  	 "param1=" + tmpNotifLinkParam[0] + "&" + 
							  	 "param2=" + tmpNotifLinkParam[1] + "&" + 	
							  	 "param3=" + tmpNotifLinkParam[2] + "&" +	
							  	 "param4=" + tmpNotifLinkParam[3] + "&" +
							  	 "param5=" + tmpId;
			String tmpNotifButton = "<a href='" + tmpBackLink + "'>" + 	
								  	 	tmpNotifTempBean.getNotifTemplateName() + 
								  	"</a>";
			String tmpTemplate    	= tmpNotifTempBean.getNotifTemplateValue();
			String[] tmpParamFlag	= new String[]{	Constants.MailTemplate.TO, 
													Constants.MailTemplate.FROM,
													Constants.MailTemplate.LINK};
			String[] tmpParamInsert = new String[] {
														tmpReceiverBean.getEmployeeId() + " - " + tmpReceiverBean.getEmployeeName(),
														((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId() + " - " + ((EmployeeBean)request.getSession().getAttribute(Constants.Session.Employeedata)).getEmployeeName(),
														PrimeUtil.getURLWithContextPath(request) + tmpBackLink
												   };
			String tmpHolder = "";
	
			for(tmpI = 0 ; tmpI < tmpParamFlag.length ; tmpI++){
				tmpHolder 	= "#" + tmpParamFlag[tmpI] + "#";
				tmpTemplate = tmpTemplate.replaceAll(tmpHolder, tmpParamInsert[tmpI]);
			}
			
			//---.Send Email with Mail Util 
			//---.Mail Send Error Handling [Use Fake SMTP]
			try {
				MailUtil.send(tmpReceiverBean.getEmail(), tmpNotifTempBean.getNotifTemplateName(), tmpTemplate);
			} catch (Exception e){
				e.printStackTrace();
			}
			
			tmpManager.insert(tmpId, pForm.getNotifType(), tmpNotifButton, ((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId(), tmpReceiverBean.getEmployeeId(), tmpBackLink);
			
			return null;
		} else if(("reloadNotification").equals(pForm.getTask())){ 
			ArrayList<Integer> tmpLists = (ArrayList<Integer>)request.getSession().getAttribute(Constants.Session.menuLists);
			if(tmpLists.indexOf(Constants.Page.USER_VIEWNOTIF) == -1)
				return null;
			
			int countNotif = tmpManager.getCountListNotifNoRead(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId());
					
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("cache-control", "no-cache");
			PrintWriter tmpOut = response.getWriter();
			
			String tmpPrint = "";
			
			tmpPrint += "<a href=\"javascript:void(0)\" class=\"dropdown-toggle\" data-toggle=\"dropdown\">";
			tmpPrint += "<i class=\"fa fa-bell-o\"></i>";
			tmpPrint += "<span class=\"label label-warning\">" + countNotif + "</span>";
			tmpPrint += "</a>";
			tmpPrint += "<ul class=\"dropdown-menu\">";
			tmpPrint += "<li class=\"header\">You have " + countNotif + " notifications</li>";
            tmpPrint += "<li>";
            tmpPrint += "<ul class=\"menu\">";
            for(int i=0;i<tmpManager.getListNotifNoRead(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId()).size();i++){
            	NotificationBean tmpNotifBean = tmpManager.getListNotifNoRead(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId()).get(i);
            	tmpPrint += "<li>";
            	tmpPrint += "<a href=\"" + tmpNotifBean.getNotificationLink() + "\">";
            	tmpPrint += "<i class=\"fa fa-warning text-yellow\"></i>";
            	tmpPrint += tmpNotifBean.getNotificationNameType();
            	tmpPrint += "</a>";
            	tmpPrint += "</li>";
			}
			tmpPrint += "</ul>";
			tmpPrint += "</li>";
			tmpPrint += "<li class=\"footer\"><a style=\"paging\" href=\"#\" onclick=\"doViewAllNotif()\">View all</a></li>";
			tmpPrint += "</ul>";
			
			
			tmpOut.print(tmpPrint);
			tmpOut.flush();
			return null;
		} else {
			//---.Get Count Rows
			int countRows = tmpManager.getCountByColumn(pForm.getColumnSearch(),pForm.getSearch(), ((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId());

			//---.Set Paging
			List<NotificationBean> list = tmpManager.getListByColumn(
					pForm.getColumnSearch(), pForm.getSearch(), PrimeUtil.getStartRow(pForm.getGoToPage(),
							pForm.getShowInPage(), countRows), PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
							countRows), ((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getEmployeeId());
			
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
