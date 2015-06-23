package prime.admin.dashboard;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import prime.utility.ImageUtil;
import prime.utility.PrimeUtil;

public class DashboardAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ImageUtil.decode(ImageUtil.encodeToString("E:\\prime\\prime01\\WebContent\\image\\Lighthouse.jpg"));
		return mapping.findForward("success");
	}






	
}
