package prime.admin.notiftemplate;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.employee.EmployeeBean;
import prime.constants.Constants;
import prime.utility.PaginationUtility;
import prime.utility.PrimeUtil;

public class NotifTemplateAction extends Action{
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		NotifTemplateForm pForm = (NotifTemplateForm) form;
		NotifTemplateManager tmpManager = new NotifTemplateManagerImpl();
		
		if(Constants.Task.GOTOADD.equals(pForm.getTask())) {
			return mapping.findForward("add");
		} else if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			NotifTemplateBean tmpNotifTemplate = tmpManager.getNotifTemplateById(pForm.getTmpId());
			pForm.setNotifTemplateBean(tmpNotifTemplate);	
			return mapping.findForward("edit");
		} else if(Constants.Task.DOADD.equals(pForm.getTask())) {
			pForm.getNotifTemplateBean().setNotifTemplateId(tmpManager.getNewId());
			tmpManager.insert(pForm.getNotifTemplateBean());
			return mapping.findForward("forward");
		} else if(Constants.Task.DOEDIT.equals(pForm.getTask())) {
			NotifTemplateBean tmpNotifTemplate = pForm.getNotifTemplateBean();
			tmpManager.update(tmpNotifTemplate);
			return mapping.findForward("forward");
		}
		
		int countRows  = tmpManager.getCountByColumn();
		
		List<NotifTemplateBean> list = tmpManager.getListByColumn(
														  PrimeUtil.getStartRow(pForm.getGoToPage(), pForm.getShowInPage(),0),  
														  PrimeUtil.getEndRow(pForm.getGoToPage(), pForm.getShowInPage(),0));
		
		//##1.Attribute For Table Paging
		request.setAttribute("listNotifTemplate", list);
		
		setPaging(request, countRows, pForm.getGoToPage(), pForm.getShowInPage());
		
		return mapping.findForward("success");
	}
	
	private void setPaging(HttpServletRequest request, int countRows, int page, int view)
			throws SQLException {
		//##0.Paging Number Handling
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
	}
}
