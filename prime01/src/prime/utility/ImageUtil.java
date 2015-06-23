package prime.utility;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

public class ImageUtil {
	public static BufferedImage resizeImage(BufferedImage oriImage, int newWidth, int newHeight) {
		BufferedImage resizedImage = new BufferedImage(newWidth, newHeight, oriImage.getType());
		Graphics2D g2 = resizedImage.createGraphics();
		g2.drawImage(oriImage, 0, 0, newWidth, newHeight, null);
		g2.dispose();
		return resizedImage;
	}

	public static BufferedImage readImage(File fileImage) throws IOException {
		return ImageIO.read(fileImage);
	}

	public static boolean saveImage(BufferedImage image, String type, File path) throws IOException {
		return ImageIO.write(image, type, path);
	}
	

	// convert image to byte array
	public static String encodeToString(String location) {
		String encoded = null;
//		File folder = new File("C:\\Users\\Public\\Pictures\\Resource");
//		File fileImage = new File(folder + "\\Lighthouse.jpg");
		File fileImage = new File(location);
		try {
			FileInputStream imageInFile = new FileInputStream(fileImage);
			byte imageData[] = new byte[(int) fileImage.length()];
			imageInFile.read(imageData);
			encoded = DatatypeConverter.printBase64Binary(imageData);
			imageInFile.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return encoded;
	}

	// convert byte array to image and image resizing
	public static void decode(String image) {
		File folder = new File("C:\\Users\\adrian.dp\\git\\prime\\prime01\\WebContent");
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
			BufferedImage resizeImage = ImageUtil.resizeImage(originalImage, 300, 300);
			ImageUtil.saveImage(resizeImage, "JPG", fileResize);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
}
