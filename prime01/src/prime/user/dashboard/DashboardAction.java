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
		int tmpI, tmpJ;
		ArrayList<Object> tmpActivityList;
		List<ActivityBean> tmpActivityDetail;
		boolean tmpLastStatus;
		ArrayList<ArrayList<Object>> tmpData = new ArrayList<ArrayList<Object>>();
		
		//---.Activities Progress on Specified Date
		//---a.Get Activities List on Specified Date
		DateFormat tmpDateFormat = new SimpleDateFormat("dd-MM-yyyy");
		Date tmpDate = new Date();
		List<ActivityBean> currentListActivity = manager.getCurrentListActivity(101, tmpDateFormat.format(tmpDate));
		request.setAttribute("currentListActivity", currentListActivity);
	    
		for(tmpI = 0 ; tmpI < currentListActivity.size() ; tmpI++){
			tmpActivityList = new ArrayList<Object>();
			
			//tmpActivityDetails.add(currentListActivity.get(tmpI).getActivityId());
			tmpActivityList.add(currentListActivity.get(tmpI).getActivityName());	
			for(tmpJ = 0 ; tmpJ < Constants.DAILY_TIME.length ; tmpJ++){
				tmpActivityList.add(false);
			}
			tmpActivityDetail = manager.getActivityRangeTime(currentListActivity.get(tmpI).getActivityId());
			if(tmpActivityDetail.get(0).getActivityStatus() == Constants.Status.PAUSE  ||
			   tmpActivityDetail.get(0).getActivityStatus() == Constants.Status.FINISH ||
			   tmpActivityDetail.get(0).getActivityStatus() == Constants.Status.ABORT  ||
			   tmpActivityDetail.get(0).getActivityStatus() == Constants.Status.SUBMIT) {
			   tmpLastStatus  = true;
			} else {
				tmpLastStatus = false;
			}
			
			int tmpK = 0;
			boolean tmpOverloop = false;
			Date curnTime;
			Date compTime;
			for(tmpJ = 0 ; tmpJ < tmpActivityDetail.size() ; tmpJ++) {
				tmpOverloop = false;
				while(tmpK < Constants.DAILY_TIME.length){
					curnTime = PrimeUtil.parseDateStringToTime(Constants.DAILY_TIME[tmpK]);
					compTime = PrimeUtil.parseDateStringToTime(PrimeUtil.setDateToTimeString(tmpActivityDetail.get(tmpJ).getActivityChangeDate()));
					tmpOverloop = compTime.after(curnTime);
					
					if(tmpOverloop){
						tmpActivityList.set(tmpK + 1, tmpLastStatus);
						tmpK++;
					} else {
						break;
					}
				}
				if(tmpActivityDetail.get(tmpJ).getActivityStatus() == Constants.Status.PROGRESS){
					tmpLastStatus = true;
				}
				else if(tmpActivityDetail.get(tmpJ).getActivityStatus() == Constants.Status.PAUSE  || 
						tmpActivityDetail.get(tmpJ).getActivityStatus() == Constants.Status.FINISH ||
						tmpActivityDetail.get(tmpJ).getActivityStatus() == Constants.Status.ABORT  ||
						tmpActivityDetail.get(tmpJ).getActivityStatus() == Constants.Status.SUBMIT ||
						tmpActivityDetail.get(tmpJ).getActivityStatus() == Constants.Status.CREATE) {
					tmpLastStatus = false;
				}
			}
			
			//##.For Closing State [If Latest State is True]
			curnTime = PrimeUtil.parseDateStringToTime(PrimeUtil.setDateToDateString(new Date()));
			compTime = PrimeUtil.parseDateStringToTime(PrimeUtil.setDateToDateString(tmpDate));
			tmpOverloop = compTime.before(curnTime);
			if(tmpOverloop){ 
				while(tmpK < Constants.DAILY_TIME.length){			
					tmpActivityList.set(tmpK + 1, tmpLastStatus);
					tmpK++;
				}
			}
			tmpData.add(tmpActivityList);
		}
		
		//---b.Get Activities
		request.setAttribute("listActivities", tmpData);
		
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
			for(int tmpK = 1 ; tmpK < tmpData.get(tmpJ).size() ; tmpK++){
				if((boolean)tmpData.get(tmpJ).get(tmpK)){	
					tmpValueString += "<td bgcolor='green'>";
				} else {
					tmpValueString += "<td >";
				}
				tmpValueString += "</td>";
			}
			tmpValueString += "</tr>";
		}

		if(tmpData.size() <= 0){
			tmpOut.print("<thead>" +
								"<th></th>"   +
						 "</thead>" +
						 "<tbody>"  +
						 		"<td><h5><center>No Activity Progress Can be Shown</center></h5></td>" +  
						 "</tbody>");
		} else {
			tmpOut.print("<thead>" +
								"<th>#</th>"   +
								"<th>Activity</th>"   + 
						 		tmpTimeString +
						 "</thead>" +
						 "<tbody>"  +
						 		tmpValueString +  
						 "</tbody>");
		}
		tmpOut.flush();
	}
}
