package prime.utility;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
	
	public static java.sql.Date getDate(String inDate, String format) throws ParseException {
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(dateFormat.parse(inDate).getTime());
		c.set(c.get(Calendar.YEAR), c.get(Calendar.MONTH), c.get(Calendar.DATE));
		return new java.sql.Date(c.getTimeInMillis());
	}

	private static SimpleDateFormat DATEFORMAT_TIME = new SimpleDateFormat("HH:mm");
	private static SimpleDateFormat DATEFORMAT_DATE = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    public static String setDateToTimeString(Date date){
    	return DATEFORMAT_TIME.format(date);
    }
    public static String setDateToDateString(Date date){
    	return DATEFORMAT_DATE.format(date);
    }

	public static Date parseDateStringToTime(String date) {
	    try {
	        return DATEFORMAT_TIME.parse(date);
	    } catch (java.text.ParseException e) {
	        return new Date(0);
	    }
	}

	public static Date parseDateStringToDate(String date) {
	    try {
	        return DATEFORMAT_DATE.parse(date);
	    } catch (java.text.ParseException e) {
	        return new Date(0);
	    }
	}
}
