package prime.user.dashboard;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;
import prime.user.activity.ActivityBean;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class DashboardAction extends Action{
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {	
		//##0.Temp Variable
		DashboardForm pForm = (DashboardForm) form;
		ActivityManager tmpManager = new ActivityManagerImpl();
		ActionForward tmpAction = mapping.findForward("success");
		Integer tmpEmployeeID = 100;
		
		//##1.Start Task Selection
		if("chooseActivity".equals(pForm.getTask())) {
			//parameter pertama adalah session login employee id
			int countRows = tmpManager.getCountToDoListById(tmpEmployeeID,pForm.getColumnSearch(),pForm.getSearch());
			List<ActivityBean> list = tmpManager.getListActivityById(tmpEmployeeID,pForm.getColumnSearch(), 
																	 pForm.getSearch(), PrimeUtil.getStartRow(
																	 pForm.getGoToPage(), pForm.getShowInPage(), countRows),
																	 PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
																	 countRows));
			request.setAttribute("listActivity", list);
			request.setAttribute("listSearchColumn", Constants.Search.ACTIVITY_SEARCHCOLUMNS);
			request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
			setPaging(request, pForm, countRows, pForm.getGoToPage(),
					  pForm.getShowInPage());
			refreshToDoList(request, pForm, tmpManager);
			tmpAction = mapping.findForward("add");
		}else if("addToDoList".equals(pForm.getTask())){
			tmpManager.insertToDoList(tmpEmployeeID,pForm.getTmpId());
			refreshToDoList(request, pForm, tmpManager);
			tmpAction = mapping.findForward("success");
		}else if("delete".equals(pForm.getTask())){
			tmpManager.deleteToDoList(tmpEmployeeID,pForm.getTmpId());
			refreshToDoList(request, pForm, tmpManager);
			tmpAction = mapping.findForward("success");
		}else if("addActivity".equals(pForm.getTask())){
			tmpManager.insertActivityDetail(tmpEmployeeID,pForm.getTmpId(), pForm.getTmpValue(), "START");
			refreshToDoList(request, pForm, tmpManager);
			tmpAction = mapping.findForward("success");
		}else if("pauseActivity".equals(pForm.getTask())){
			tmpManager.insertActivityDetail(tmpEmployeeID,pForm.getTmpId(), pForm.getTmpValue(), "PAUSE");
			refreshToDoList(request, pForm, tmpManager);
			tmpAction = mapping.findForward("success");
		}else if("finishActivity".equals(pForm.getTask())){
			tmpManager.insertActivityDetail(tmpEmployeeID,pForm.getTmpId(), pForm.getTmpValue(), "FINISH");
			refreshToDoList(request, pForm, tmpManager);
			tmpAction = mapping.findForward("success");
		}else if("refreshActivityProgress".equals(pForm.getTask())){
			refreshActivityProgressList(request, response, pForm, tmpManager);
			tmpAction = null;
		}
		
		return tmpAction;
	}
	
	private void setPaging(HttpServletRequest request, DashboardForm pForm,
			int countRows, int page, int view) throws SQLException {
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

		pForm.setGoToPage(pageUtil.getPage());
	}
	
	private void refreshToDoList(HttpServletRequest request, DashboardForm pForm, ActivityManager manager) throws SQLException {
		List<ActivityBean> list = manager.getToDoListById(101);
		request.setAttribute("listActivity", list);
	}
	
	private void refreshActivityProgressList(HttpServletRequest request, HttpServletResponse response, DashboardForm pForm, ActivityManager manager) throws SQLException, IOException {
		//##0.Temp Variable
		int tmpI, tmpJ, tmpK;
		Date curnTime, compTime;
		ArrayList<Object> tmpActivityList;
		boolean tmpOverloop, tmpLastStatus;
		List<ActivityBean> tmpCurnListActivity, tmpActivityDetail;
		ArrayList<ArrayList<Object>> tmpData;
		Date tmpDateRequest, tmpDateNow;
		
		//---.Activities Progress on Specified Date
		//---a.Get Activities List on Specified Date
		tmpDateRequest = PrimeUtil.parseDateStringToDate(pForm.getCurrentDate());
		tmpDateNow	   = PrimeUtil.parseDateStringToDate(PrimeUtil.setDateToDateString(new Date()));
		
		
		tmpData = new ArrayList<ArrayList<Object>>();
		tmpCurnListActivity = manager.getCurrentListActivity(101, pForm.getCurrentDate());
		for(tmpI = 0 ; tmpI < tmpCurnListActivity.size() ; tmpI++){
			tmpActivityList = new ArrayList<Object>();
			tmpActivityList.add(tmpCurnListActivity.get(tmpI).getActivityId());
			tmpActivityList.add(tmpCurnListActivity.get(tmpI).getActivityName());	
			
			for(tmpJ = 0 ; tmpJ < Constants.DAILY_TIME.length ; tmpJ++){
				tmpActivityList.add(false);
			}
			tmpK = Constants.DAILY_TIME.length - 1;
			tmpActivityDetail = manager.getActivityRangeTime(tmpCurnListActivity.get(tmpI).getActivityId(), pForm.getCurrentDate());
			
			for(tmpJ = 0 ; tmpJ < tmpActivityDetail.size() ; tmpJ++) {
				if(tmpActivityDetail.get(tmpJ).getActivityStatus()  == Constants.Status.PAUSE  ||
				   tmpActivityDetail.get(tmpJ).getActivityStatus()  == Constants.Status.FINISH ||
				   tmpActivityDetail.get(tmpJ).getActivityStatus()  == Constants.Status.ABORT  ||
				   tmpActivityDetail.get(tmpJ).getActivityStatus()  == Constants.Status.SUBMIT ||
				   tmpActivityDetail.get(tmpJ).getActivityStatus() == Constants.Status.CREATE) {
				   tmpLastStatus  = false;
				} else {
				   tmpLastStatus  = true;
				}
				
				tmpOverloop = false;
				while(tmpK >= 0){
					curnTime    = PrimeUtil.parseDateStringToTime(Constants.DAILY_TIME[tmpK]);
					compTime    = PrimeUtil.parseDateStringToTime(PrimeUtil.setDateToTimeString(tmpActivityDetail.get(tmpJ).getActivityChangeDate()));
					tmpOverloop = compTime.before(curnTime);
					if(tmpOverloop){
						tmpActivityList.set(tmpK, tmpLastStatus);
						tmpK--;
					} else {
						//For Extra Checking when the time difference was too small
						if(!tmpLastStatus){
							tmpK++;	
						}
						break;
					}
				}
			}
			tmpData.add(tmpActivityList);
		}
		
		//---b.Get Activities
		response.setContentType("text/text;charset=utf-8");
		response.setHeader("cache-control", "no-cache");
		PrintWriter tmpOut = response.getWriter();
		String tmpTimeString = "";
		for(tmpI = 0 ; tmpI < Constants.DAILY_TIME.length ; tmpI++){
			tmpTimeString += "<th>";
			tmpTimeString += Constants.DAILY_TIME[tmpI];
			tmpTimeString += "</th>";
		}
		String tmpValueString = "";
		for(tmpJ = 0 ; tmpJ < tmpData.size() ; tmpJ++){
			tmpValueString += "<tr>"; 
			tmpValueString += "<td width=\"5px\" >" + (tmpJ + 1) + "</td>";
			tmpValueString += "<td>";
			tmpValueString += tmpData.get(tmpJ).get(0); 
			tmpValueString += "</td>";
			tmpValueString += "<td>";
			tmpValueString += tmpData.get(tmpJ).get(1); 
			tmpValueString += "</td>";
			for(tmpK = 2 ; tmpK < tmpData.get(tmpJ).size() ; tmpK++){
				if((boolean)tmpData.get(tmpJ).get(tmpK)){	
					tmpValueString += "<td bgcolor='green'>";
				} else {
					tmpValueString += "<td bgcolor='white' >";
				}
				tmpValueString += "</td>";
			}
			tmpValueString += "</tr>";
		}

		if(tmpData.size() <= 0){
			tmpOut.print("<table id=\"table-1\" class=\"display\" cellspacing=\"0\" width=\"100%\" >" + 
						 "<thead>" +
								"<th></th>"  +
								"<th></th>"  +
								"<th></th>"  +
						 "</thead>" +
						 "<tbody>"  +
						 		"<tr>" +
						 			"<td></td>" +
						 			"<td>"  +
					 					"<center>No Activity Progress in this day.</center>" + 
					 				"</td>" +
						 			"<td></td>" +
						 		"</tr>" + 
						 "</tbody>" +
					 	 "</table>");
		} else {
			tmpOut.print("<table id=\"table-1\" class=\"display cell-border compact\" cellspacing=\"0\" width=\"100%\">" + 
						 "<thead>" +
								"<th>#</th>"   +
								"<th width=\"200px\">Activity ID</th>"   + 
								"<th width=\"200px\">Activity Name</th>"   + 
						 		tmpTimeString +
						 "</thead>" +
						 "<tbody>"  +
						 		tmpValueString +  
						 "</tbody>" +
					 	 "</table>");
		}
		tmpOut.flush();
	}
}
