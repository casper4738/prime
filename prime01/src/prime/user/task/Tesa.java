package prime.user.task;

import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import prime.admin.employee.EmployeeBean;
import prime.admin.employee.EmployeeManager;
import prime.admin.employee.EmployeeManagerImpl;
import prime.admin.holiday.HolidayBean;
import prime.user.project.ProjectManager;
import prime.user.project.ProjectManagerImpl;

public class Tesa {

	public static void main(String[] args) throws SQLException {
//		Calendar c1 = Calendar.getInstance();
//		c1.set(2015, 05, 01);
//
//		Calendar c2 = Calendar.getInstance();
//		c2.set(2015, 05, 15);
//
//		java.sql.Date date1 = new java.sql.Date(c1.getTimeInMillis());
//		java.sql.Date date2 = new java.sql.Date(c2.getTimeInMillis());
//
//		System.out.println(selisihDateTime(date1, date2));
//
//		getWeekEnd(date1, date2);

		ProjectManager tmpProjectManager = new ProjectManagerImpl();
		//tmpProjectManager.updateActualStart(1, new java.sql.Date(new java.util.Date().getTime()));
		TaskManager manager = new TaskManagerImpl();
		
		manager.updateActualEnd(1, new java.sql.Date(new java.util.Date().getTime()));
	}

	// Method menghitung selisih dua waktu
	protected static String selisihDateTime(Date date1, Date date2) {
		long selisihMS = Math.abs(date1.getTime() - date2.getTime());
		long selisihDetik = selisihMS / 1000 % 60;
		long selisihMenit = selisihMS / (60 * 1000) % 60;
		long selisihJam = selisihMS / (60 * 60 * 1000) % 24;
		long selisihHari = selisihMS / (24 * 60 * 60 * 1000);
		String selisih = selisihHari + " hari " + selisihJam + " Jam " + selisihMenit + " Menit " + selisihDetik
				+ " Detik";
		return selisih;
	}

	public static void ulang(Date date1, Date date2) {
		Calendar start = Calendar.getInstance();
		start.setTime(date1);

		Calendar end = Calendar.getInstance();
		end.setTime(date2);

		while (!start.after(end)) {
			System.out.println("hasil : " + new java.sql.Date(start.getTimeInMillis()));
			start.add(Calendar.DATE, 1);
		}
	}

	public static void getWeekEnd(Date date1, Date date2) throws SQLException {
		EmployeeManager tmpEmployeeManager = new EmployeeManagerImpl();
		List<EmployeeBean> listDate = tmpEmployeeManager.getListWeekendByEmployeeId(101);
		if(listDate.size() == 0) 
			return;

		Calendar start = Calendar.getInstance();
		start.setTime(date1);

		Calendar end = Calendar.getInstance();
		end.setTime(date2);

		System.out.println("cek:"+listDate.size());
		
		int sumOfWeekEnd = 0;
		while (!start.after(end)) {
			System.out.print("hasil : " + new java.sql.Date(start.getTimeInMillis()));
			
			boolean isGet = false;
			EmployeeBean week = new EmployeeBean();
			for (EmployeeBean e : listDate) {
				Calendar c = Calendar.getInstance();
				c.setTimeInMillis(e.getStartFrom().getTime());
				if(start.after(c)) {
					week = e;
					isGet = true;
					System.out.print("                                 xxx " +e.getStartFrom()+ "   || |");
				} else {
					System.out.print("                                 yyy " +e.getStartFrom()+ "   || |");
					if(!isGet) {
						week = e;						
					}
					break;
				}
			}
			
			
			String[] split = week.getWeekEnd().split(",");
			
			for (String s : split) {
				s = s.trim();
				System.out.print("  xxx " + start.get(Calendar.DAY_OF_WEEK) + "| " + getDay(s.trim()));
				System.out.print("  xxx " + (start.get(Calendar.DAY_OF_WEEK) == getDay(s.trim())));
				if(start.get(Calendar.DAY_OF_WEEK) == getDay(s.trim())) {
					sumOfWeekEnd++;
				}
			}
			
			System.out.println();
			start.add(Calendar.DATE, 1);
		}
		System.out.println("cek : " + sumOfWeekEnd);
	}
	
	public static void getHoliday(Date date1, Date date2) {
		List<HolidayBean> listDate = new ArrayList<HolidayBean>();
		HolidayBean bean = new HolidayBean();

		bean = new HolidayBean();
		bean.setHolidayDate(getDate(2015, 05, 10));
		listDate.add(bean);
		
		bean = new HolidayBean();
		bean.setHolidayDate(getDate(2015, 05, 11));
		listDate.add(bean);
		
		
		bean = new HolidayBean();
		bean.setHolidayDate(getDate(2015, 05, 15));
		listDate.add(bean);
		
		
		Calendar start = Calendar.getInstance();
		start.setTime(date1);	

		Calendar end = Calendar.getInstance();
		end.setTime(date2);

		int x = 0;
		int sumOfWeekEnd = 0;
		while (!start.after(end)) {
			System.out.println("hasil : " + new java.sql.Date(start.getTimeInMillis()));
			for (int i = 0; i < listDate.size(); i++) {
				HolidayBean e = listDate.get(i);
				
				Calendar c = Calendar.getInstance();
				c.setTime(e.getHolidayDate());
				
				//System.out.print("hasil : " + new java.sql.Date(start.getTimeInMillis()) +"|"+ e.getHolidayDate());
				//System.out.println(" |  " + getCompareTo(start.getTimeInMillis(), e.getHolidayDate().getTime()));

				if(getCompareTo(start.getTimeInMillis(), e.getHolidayDate().getTime())== 0) {
					sumOfWeekEnd ++;
					break;
				}
			}
			x++;
			start.add(Calendar.DATE, 1);
		}
		System.out.println("cek : " + sumOfWeekEnd);
	}

	public static java.sql.Date getDate(int y, int m, int d) {
		Calendar c = Calendar.getInstance();
		c.set(y, m, d);
		return new java.sql.Date(c.getTimeInMillis());
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

	public static Integer getCompareTo(long time1, long time2) {
		java.util.Date date1 = new java.util.Date(time1);
		java.util.Date date2 = new java.util.Date(time2);
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 	java.util.Date xdate1 = sdf.parse(sdf.format(date1));
		 	java.util.Date xdate2 = sdf.parse(sdf.format(date2));
			return xdate1.compareTo(xdate2);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return 2;
	}
}

class Weekend {

	private java.sql.Date startFrom;
	private String weekend;
	
	public Weekend() {
	}
	
	public Weekend(java.sql.Date startFrom, String weekend) {
		this.startFrom = startFrom;
		this.weekend = weekend;
	}

	public java.sql.Date getStartFrom() {
		return startFrom;
	}

	public void setStartFrom(java.sql.Date startFrom) {
		this.startFrom = startFrom;
	}

	public String getWeekend() {
		return weekend;
	}

	public void setWeekend(String weekend) {
		this.weekend = weekend;
	}

}
