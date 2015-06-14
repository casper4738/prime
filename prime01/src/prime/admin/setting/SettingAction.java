package prime.admin.setting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class SettingAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SettingForm pForm = (SettingForm) form;
		GeneralSetting manager = new GeneralSetting(request);
		
		if("edit".equals(pForm.getTask())) {
			pForm.setSettingBean(manager.getSetting());
			return mapping.findForward("edit");
		} else if("update".equals(pForm.getTask())) {
			System.out.println(pForm.getSettingBean().getLevel()+":sss");
			manager.save(pForm.getSettingBean());
			return mapping.findForward("forward");
		}
		pForm.setSettingBean(manager.getSetting());
		return mapping.findForward("success");
	}

}
