package prime.admin.setting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.admin.user.UserBean;
import prime.constants.Constants;

public class SettingAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SettingForm pForm 				 = (SettingForm) form;
		GeneralSettingManager tmpManager = new GeneralSettingManagerImpl();
		if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			//##. Edit Data
			pForm.setWeekends(pForm.getSettingBean().getWeekend());
			pForm.setSettingBean(tmpManager.getGeneralSetting());
			return mapping.findForward("edit");
		} else if(Constants.Task.DOEDIT.equals(pForm.getTask())) {
			//##. Update Data
			pForm.getSettingBean().setWeekend(pForm.getWeekends());
			pForm.getSettingBean().setUpdateBy(((UserBean)request.getSession().getAttribute(Constants.Session.Userdata)).getUserName());
			tmpManager.save(pForm.getSettingBean());				
			return mapping.findForward("forward");
		}

		pForm.setSettingBean(tmpManager.getGeneralSetting());
		return mapping.findForward("success");
	}

}
