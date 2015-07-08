package prime.admin.role;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.division.DivisionBean;
import prime.admin.user.UserBean;
import prime.constants.Constants;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class RoleAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RoleForm pForm = (RoleForm) form;
		RoleManager tmpManager = new RoleManagerImpl();
		
		request.setAttribute("homepage", request.getSession().getAttribute(Constants.Session.lastPage));
		
		if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			//##. Add Data
			return mapping.findForward("add");
		} else if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			//##. Edit Data
			pForm.setRoleBean(tmpManager.getRoleById(pForm.getTmpId()));
			return mapping.findForward("edit");
		} else if(Constants.Task.DOADD.equals(pForm.getTask())) {
			//##.Insert Data and Go to Forward
			pForm.getRoleBean().setRoleId(tmpManager.getNewId());
			pForm.getRoleBean().setUpdateBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
			tmpManager.insert(pForm.getRoleBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOEDIT.equals(pForm.getTask())) {
			//##.Update Data and Go to Forward
			pForm.getRoleBean().setUpdateBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
			tmpManager.update(pForm.getRoleBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DODELETE.equals(pForm.getTask())) {
			//##.Delete Data and Back Main
			pForm.getRoleBean().setUpdateBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
			tmpManager.delete(pForm.getTmpId());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOVALIDATE1.equals(pForm.getTask())){
			response.setContentType("text/text;charset=utf-8");
			response.setHeader("cache-control", "no-cache");
			PrintWriter tmpOut = response.getWriter();
			String tmpResponse = "";
			
			int tmpResponseCode;
			
			//0 : Exists Database ; 1 : Empty Database
			if(tmpManager.getRoleUsed(pForm.getTmpId()) > 0){
				tmpResponseCode = 1;	//Role Already Used
			} else {
				tmpResponseCode = 0;	//Success
			}

			System.out.println(tmpResponseCode + " tmpResponseCode");
			if(tmpResponseCode == 1){
				tmpResponse = "1#";
			} else {
				tmpResponse = "0#";
			}
			
			tmpOut.print(tmpResponse);
			tmpOut.flush();
			return null;
		}
		
		int countRows  = tmpManager.getCountByColumn(pForm.getColumnSearchReal(), pForm.getSearch());
		List<RoleBean> list = tmpManager.getListByColumn(pForm.getColumnSearchReal(), pForm.getSearch(),
				PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows),  
				PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(), countRows));
		
		//##1.Attribute for Table Show
		request.setAttribute("listRole", list);
		request.setAttribute("listSearchColumn", Constants.Search.ROLE_SEARCHCOLUMNS);
		request.setAttribute("listShowEntries" , Constants.PAGINGROWPAGE);
		setPaging(request, pForm, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, RoleForm pForm, int countRows, int page, int view)
			throws SQLException {
		//##2.Paging Handling
		PaginationUtility pageUtil = new PaginationUtility();
		pageUtil.setCountRows(countRows);
		pageUtil.setView(view);

		request.setAttribute("totalData", countRows);
		request.setAttribute("listPage", pageUtil.getListPaging(page));
		request.setAttribute("pageNow", page);
		request.setAttribute("pageFirst", 1);
		request.setAttribute("pageLast", pageUtil.getSumOfPage());
		request.setAttribute("pagePrev", pageUtil.getPagePrev());
		request.setAttribute("pageNext", pageUtil.getPageNext());
		request.setAttribute("listMaxDataPerPage", Constants.PAGINGROWPAGE);
		
		pForm.setGoToPage(pageUtil.getPage());
	}

}
