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
		//##. Edit Data
		if("edit".equals(pForm.getTask())) {
			pForm.setSettingBean(manager.getSetting());
			return mapping.findForward("edit");
		} 
		//##. Update Data
		else if("update".equals(pForm.getTask())) {
			manager.save(pForm.getSettingBean());
			return mapping.findForward("forward");
		}
		//##1.Attribute for Table Show
		pForm.setSettingBean(manager.getSetting());
		return mapping.findForward("success");
	}

}
