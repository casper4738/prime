package prime.user.dashboard;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.user.activity.ActivityBean;
import prime.user.activity.ActivityManager;
import prime.user.activity.ActivityManagerImpl;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class DashboardAction extends Action{
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		DashboardForm pForm = (DashboardForm) form;
		ActivityManager tmpManager = new ActivityManagerImpl();
		
		if("chooseActivity".equals(pForm.getTask())) {
			//parameter pertama adalah session login employee id
			int countRows = tmpManager.getCountToDoListById(101,pForm.getColumnSearch(),pForm.getSearch());
			List<ActivityBean> list = tmpManager.getListActivityById(101,pForm
					.getColumnSearch(), pForm.getSearch(), PrimeUtil.getStartRow(
							pForm.getGoToPage(), pForm.getShowInPage(), countRows),
					PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),
							countRows));
			
			request.setAttribute("listActivity", list);
			setPaging(request, pForm, countRows, pForm.getGoToPage(),
					pForm.getShowInPage());
			
			return mapping.findForward("add");
		}else if("addToDoList".equals(pForm.getTask())){
			tmpManager.insertToDoList(101,pForm.getTmpId());
		}else if("delete".equals(pForm.getTask())){
			tmpManager.deleteToDoList(101,pForm.getTmpId());
		}else if("addActivity".equals(pForm.getTask())){
			tmpManager.insertActivityDetail(101,pForm.getTmpId(), pForm.getTmpValue(), "START");
		}else if("pauseActivity".equals(pForm.getTask())){
			tmpManager.insertActivityDetail(101,pForm.getTmpId(), pForm.getTmpValue(), "PAUSE");
		}else if("finishActivity".equals(pForm.getTask())){
			tmpManager.insertActivityDetail(101,pForm.getTmpId(), pForm.getTmpValue(), "FINISH");
		}
		
		
		//int detik = calendar.get(Calendar.SECOND);
		
		
		List<ActivityBean> list = tmpManager.getToDoListById(101);
		List<ActivityBean> currentListActivity = tmpManager.getCurrentListActivity(101,"20-06-2015");
		//List<ActivityBean> activityRangeTime = tmpManager.getActivityRangeTime(101,"20-06-2015");
		request.setAttribute("currentListActivity", currentListActivity);


		List<Timestamp> time = new ArrayList<Timestamp>();
		//long durasi = time2.getTime()- time1.getTime();
		

		Calendar calendar = Calendar.getInstance();
		//calendar.setTimeInMillis(durasi);
		
		//int menit = calendar.get(Calendar.MINUTE);
		List<List<ActivityBean>> listAll = new ArrayList<List<ActivityBean>>();
		for(int i = 0;i<currentListActivity.size();i++){
			System.out.println(currentListActivity.get(i).getActivityId()+"activityId");
			List<ActivityBean> activityRangeTime = tmpManager.getActivityRangeTime(currentListActivity.get(i).getActivityId());
			
			request.setAttribute("activityRangeTime"+currentListActivity.get(i).getActivityId(), activityRangeTime);
			System.out.println(activityRangeTime.size()+" size");
			
			//listAll.add(activityRangeTime);
		}
		//request.setAttribute("lists", listAll);
		request.setAttribute("listActivity", list);
		
		
		/*
		ArrayList<Object[]> tmpData = new ArrayList<Object[]>();
		tmpData.add(new Object[]{"Activity 1", new int[]{5 , 10}, new int[]{20, 5}, new int[]{22, 2}});
		tmpData.add(new Object[]{"Activity 2", new int[]{15, 10}});
		tmpData.add(new Object[]{"Activity 3", new int[]{12, 2}});
		request.setAttribute("listActivityProgress", tmpData);
		*/

		ArrayList<Object[]> tmpData = new ArrayList<Object[]>();
		tmpData.add(new Object[]{"Activity 1", false, false, false, false, false, false, false, false, false, false, false, false,
								 false, false, false, false, false, false, false, false, false, false, false, false,
								 false, false, false, false, false, false, false, false, false, false, false, false,
								 false, false, false, false, false, false, false, false, false, false, false, false});

		tmpData.add(new Object[]{"Activity 2", true, true, true, false, true, true, true, true, true, true, false, false,
								 false, false, false, false, false, false, false, false, false, false, false, false,
								 false, false, false, false, true, false, false, true, false, false, false, false,
								 false, false, false, false, false, false, false, false, false, false, false, false});

		tmpData.add(new Object[]{"Activity 3", true, true, true, true, true, false, false, false, false, false, false, false,
								 false, false, false, false, false, false, false, false, false, false, false, false,
								 false, false, true, true, true, true, true, true, true, true, true, false,
								 false, false, false, false, false, false, false, false, false, false, false, false});
		request.setAttribute("listActivities", tmpData);
		
		
		String[] tmpTime =  new String[]{ "00.00", "00.30",
				"01.00", "01.30",
				"02.00", "02.30",
				"03.00", "03.30",
				"04.00", "04.30",
				"05.00", "05.30",
				"06.00", "06.30",
				"07.00", "07.30",
				"08.00", "08.30",
				"09.00", "09.30",
				"10.00", "10.30",
				"11.00", "11.30",
				"12.00", "12.30",
				"13.00", "13.30",
				"14.00", "14.30",
				"15.00", "15.30",
				"16.00", "16.30",
				"17.00", "17.30",
				"18.00", "18.30",
				"19.00", "19.30",
				"20.00", "20.30",
				"21.00", "21.30",
				"22.00", "22.30",
				"23.00", "23.30"};
		request.setAttribute("dailyTime", new String[]{ "00.00", "00.30",
														"01.00", "01.30",
														"02.00", "02.30",
														"03.00", "03.30",
														"04.00", "04.30",
														"05.00", "05.30",
														"06.00", "06.30",
														"07.00", "07.30",
														"08.00", "08.30",
														"09.00", "09.30",
														"10.00", "10.30",
														"11.00", "11.30",
														"12.00", "12.30",
														"13.00", "13.30",
														"14.00", "14.30",
														"15.00", "15.30",
														"16.00", "16.30",
														"17.00", "17.30",
														"18.00", "18.30",
														"19.00", "19.30",
														"20.00", "20.30",
														"21.00", "21.30",
														"22.00", "22.30",
														"23.00", "23.30"});
		
		System.out.println("Task = " + pForm.getTask());
		if(pForm.getTask().equals("a")){
			System.out.println("Masuk Sini");
			response.setContentType("text/text;charset=utf-8");
			response.setHeader("cache-control", "no-cache");
			PrintWriter tmpOut = response.getWriter();
			String tmpTimeString = "";
			for(int tmpI = 0 ; tmpI < tmpTime.length ; tmpI++){
				tmpTimeString += "<th  width=\"5px\" bgcolor=\"#B0B0B0\">";
				tmpTimeString += tmpTime[tmpI];
				tmpTimeString += "</th>";
			}
			String tmpValueString = "";
			for(int tmpJ = 0 ; tmpJ < tmpData.size() ; tmpJ++){
				tmpValueString += "<tr>";
				tmpValueString += "<td>" + (tmpJ + 1) + "</td>";
				tmpValueString += "<td height=\"5px\">";
				tmpValueString += tmpData.get(tmpJ)[0];
				tmpValueString += "</td>";
				for(int tmpK = 1 ; tmpK < tmpData.get(tmpJ).length ; tmpK++){
					if((boolean)tmpData.get(tmpJ)[tmpK]){	
						tmpValueString += "<td height=\"5px\" bgcolor='green'>";
					} else {
						tmpValueString += "<td height=\"5px\">";
					}
					tmpValueString += "</td>";
				}
				tmpValueString += "</tr>";
			}
					
			tmpOut.print("1;"     +					
						"<thead>" +
								"<th width=\"5px\">#</th>"   +
								"<th width=\"5px\">Activity</th>"   + 
						 		tmpTimeString +
						 "</thead>" +
						 "<tbody>"  +
						 		tmpValueString +  
						 "</tbody>");
			tmpOut.flush();
			return null;
		}
		
		return mapping.findForward("success");
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
}
