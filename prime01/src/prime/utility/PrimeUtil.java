package prime.utility;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class PrimeUtil {

	public static Integer getStartRow(int page, int view, int countRows) {
		if(page == 0) page = 1;
		if (view == -1)
			return 1;

		int sumOfPage = (int) Math.ceil(countRows / Double.parseDouble(view + ""));
		if (page > sumOfPage)
			return sumOfPage;

		return (page - 1) * view + 1;
	}

	public static Integer getEndRow(int page, int view, int countRows) {
		if(page == 0) page = 1;
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

	private static SimpleDateFormat DATEFORMAT_TIME 		= new SimpleDateFormat("HH:mm");
	private static SimpleDateFormat DATEFORMAT_DATE 		= new SimpleDateFormat("dd/MM/yyyy HH:mm");
	private static SimpleDateFormat DATEFORMAT_DATEONLY		= new SimpleDateFormat("dd/MM/yyyy");
    
	public static String setDateToTimeString(Date date){
    	return DATEFORMAT_TIME.format(date);
    }
    public static String setDateToDateString(Date date){
    	return DATEFORMAT_DATE.format(date);
    }
    public static String setDateToDateOnlyString(Date date){
    	return DATEFORMAT_DATEONLY.format(date);
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
	
	public static Date parseDateStringToDateOnly(String date) {
	    try {
	        return DATEFORMAT_DATEONLY.parse(date);
	    } catch (java.text.ParseException e) {
	        return new Date(0);
	    }
	}	

	public static Integer getCompareTo(long time1, long time2) {
		java.util.Date date1 = new java.util.Date(time1);
		java.util.Date date2 = new java.util.Date(time2);
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 	java.util.Date xdate1 = sdf.parse(sdf.format(date1));
		 	java.util.Date xdate2 = sdf.parse(sdf.format(date2));
			return xdate1.compareTo(xdate2);
		} catch (Exception e) {
		}
		return 0;
	}
	

	public static Integer getDay(String weekend) {
		if("SUNDAY".equals(weekend.toUpperCase())) return 1;
		else if("MONDAY".equals(weekend.toUpperCase())) return 2;
		else if("TUESDAY".equals(weekend.toUpperCase())) return 3;
		else if("WEDNESDAY".equals(weekend.toUpperCase())) return 4;
		else if("THURSDAY".equals(weekend.toUpperCase())) return 5;
		else if("FRIDAY".equals(weekend.toUpperCase())) return 6;
		else if("SATURDAY".equals(weekend.toUpperCase())) return 7;
		return 0;
	}
	
	public static Integer getDayBetweenDate(Date date1, Date date2) {
		long time 		= Math.abs(date1.getTime() - date2.getTime());
		long day 		= time / (24 * 60 * 60 * 1000);
		return Integer.parseInt((day+1)+"");
	}
	

	public static List<String> getListStringDate(Date startDate, Date endDate) {
		Calendar start = Calendar.getInstance();
		start.setTime(startDate);

		Calendar end = Calendar.getInstance();
		end.setTime(endDate);

		List<String> list = new ArrayList<String>();
		
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		
		while (!start.after(end)) {
			list.add(format.format(new java.sql.Date(start.getTimeInMillis())) + "");
			start.add(Calendar.DATE, 1);
		}
		
		return list;
	}
		
}
