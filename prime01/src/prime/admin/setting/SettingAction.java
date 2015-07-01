package prime.admin.setting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.constants.Constants;

public class SettingAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		SettingForm pForm 			= (SettingForm) form;
		GeneralSettingManager manager 	= new GeneralSettingManagerImpl();

		if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			//##. Edit Data
			pForm.setSettingBean(manager.getGeneralSetting());
			return mapping.findForward("edit");
		} else if("update".equals(pForm.getTask())) {
			//##. Update Data
			manager.save(pForm.getSettingBean());
			return mapping.findForward("forward");
		}

		//##1.Attribute for Table Show
		pForm.setSettingBean(manager.getGeneralSetting());
		return mapping.findForward("success");
	}

}
