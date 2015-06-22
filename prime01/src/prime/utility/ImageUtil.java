package prime.utility;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

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
}
