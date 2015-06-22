package prime.utility;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.DatatypeConverter;

public class PrimeUtil {

	public static Integer getStartRow(int page, int view, int countRows) {
		if (view == -1)
			return 1;

		int sumOfPage = (int) Math.ceil(countRows / Double.parseDouble(view + ""));
		if (page > sumOfPage)
			return sumOfPage;

		return (page - 1) * view + 1;
	}

	public static Integer getEndRow(int page, int view, int countRows) {
		if (view == -1)
			return countRows;
		return ((page - 1) * view) + view;
	}
	
	public static String getURLWithContextPath(HttpServletRequest request) {
	   return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	}
	
	public static String getPath(HttpServletRequest request) {
		return request.getRealPath("/");
	}
	
	public static Map<Integer,Integer> getListPositionLevel(int max) {
		Map<Integer,Integer> map = new HashMap<Integer, Integer>();
		for (int i = 0; i <= max; i++) {
			map.put(i, i);
		}
		return map;
	}
		
}
