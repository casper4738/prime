package prime.user.dashboard;

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
