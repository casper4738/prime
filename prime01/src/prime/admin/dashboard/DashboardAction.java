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

public class DashboardAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String imageString;
//		File folder = new File("C:\\Users\\Public\\Pictures\\Resource");
//		File fileImage = new File(folder + "\\Lighthouse.jpg");
		
		imageString = encodeToString();
		decode(imageString);
		// File fileImage = new
		// File("C:\\Users\\adrian.dp\\git\\prime\\prime01\\WebContent\\image\\Lighthouse.jpg");
		// BufferedImage originalImage = ImageIO.read();
		//
		// BufferedImage resizeImage = ImageUtil.resizeImage(originalImage, 300,
		// 300);
		return mapping.findForward("success");
	}

	// convert image to byte array
	private String encodeToString() {
		String encoded = null;
		File folder = new File("C:\\Users\\Public\\Pictures\\Resource");
		File fileImage = new File(folder + "\\Lighthouse.jpg");
		try {
			FileInputStream imageInFile = new FileInputStream(fileImage);
			byte imageData[] = new byte[(int) fileImage.length()];
			imageInFile.read(imageData);
			encoded = DatatypeConverter.printBase64Binary(imageData);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return encoded;
	}

	// convert byte array to image
	private static void decode(String image) {
		File folder = new File(
				"C:\\Users\\adrian.dp\\git\\prime\\prime01\\WebContent");
		File folderSub = new File(folder + "\\image");
		File fileImageExport = new File(folderSub + "\\Lighthouse.jpg");
		File fileResize = new File("C:\\Users\\adrian.dp\\git\\prime\\prime01\\WebContent\\image\\resize-Lighthouse.jpg");
		byte[] decoded = DatatypeConverter.parseBase64Binary(image);
		FileOutputStream imageOutFile;
		try {
			imageOutFile = new FileOutputStream(fileImageExport);
			imageOutFile.write(decoded);
			imageOutFile.close();
			BufferedImage originalImage = ImageUtil.readImage(fileImageExport);
			BufferedImage resizeImage = ImageUtil.resizeImage(originalImage, 100, 100);
			ImageUtil.saveImage(resizeImage, "JPG", fileResize);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}





	
}
