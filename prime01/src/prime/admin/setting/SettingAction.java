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
		SettingForm pForm 				 = (SettingForm) form;
		GeneralSettingManager tmpManager = new GeneralSettingManagerImpl();

		if(Constants.Task.GOTOEDIT.equals(pForm.getTask())) {
			//##. Edit Data
			pForm.setSettingBean(tmpManager.getGeneralSetting());
			return mapping.findForward("edit");
		} else if(Constants.Task.DOEDIT.equals(pForm.getTask())) {
			//##. Update Data
			System.out.println("cek 1");
			if("".equals(pForm.getSmtpPassword())) {
			} else {
				pForm.getSettingBean().setSmtpPassword(pForm.getSmtpPassword());
			}
			System.out.println("cek 2"+pForm.getSettingBean().getSmtpPassword());
			tmpManager.save(pForm.getSettingBean());				
			System.out.println("cek 3");
			return mapping.findForward("forward");
		}

		pForm.setSettingBean(tmpManager.getGeneralSetting());
		return mapping.findForward("success");
	}

}
