package prime.utility;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

public class ImageUtil {

	// resize image
	public static BufferedImage resizeImage(BufferedImage oriImage, int newWidth, int newHeight) {
		BufferedImage resizedImage = new BufferedImage(newWidth, newHeight, oriImage.getType());
		Graphics2D g2 = resizedImage.createGraphics();
		g2.drawImage(oriImage, 0, 0, newWidth, newHeight, null);
		g2.dispose();
		return resizedImage;
	}

	// convert image to buffered image
	public static BufferedImage convertToBufferedImage(Image source) {
		int width = source.getWidth(null);
		int height = source.getHeight(null);
		BufferedImage dest = new BufferedImage(width, height, 2);

		Graphics2D g2 = (Graphics2D) dest.getGraphics();
		g2.drawImage(source, 0, 0, null);
		g2.dispose();

		return dest;
	}

	// convert image to array
	public static byte[] convertImageToByte(BufferedImage image, String type) {
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(image, type, baos);
			baos.flush();
			return baos.toByteArray();
		} catch (Exception ex) {
		}
		return null;
	}

	// convert image to array
	public static byte[] convertImageToByte(Image img, String type) {
		try {
			BufferedImage image = convertToBufferedImage(img);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(image, type, baos);
			baos.flush();
			return baos.toByteArray();
		} catch (Exception ex) {
		}
		return null;
	}

	// convert byte array back to BufferedImage
	public static BufferedImage convertByteToImage(byte[] imageInByte) throws Exception{
		InputStream in = new ByteArrayInputStream(imageInByte);
		BufferedImage image = ImageIO.read(in);
		return image;
	}
	

	public static byte[] decode(String image) {
		return DatatypeConverter.parseBase64Binary(image);
	}
	
	// save image
	public static boolean saveImage(BufferedImage image, String type, File path) throws IOException {
		return ImageIO.write(image, type, path);
	}

	//read image
	public static BufferedImage readImage(File fileImage) throws IOException {
		return ImageIO.read(fileImage);
	}
	
}
