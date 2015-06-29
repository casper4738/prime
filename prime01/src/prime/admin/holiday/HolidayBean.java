package prime.admin.holiday;

import java.sql.Date;


public class HolidayBean {

	private java.sql.Date holidayDate;
	private String holidayDescription;
	
	public HolidayBean() {
		setHolidayDate(new Date(new java.util.Date().getTime()));
	}

	public java.sql.Date getHolidayDate() {
		return holidayDate;
	}

	public void setHolidayDate(java.sql.Date holidayDate) {
		this.holidayDate = holidayDate;
	}

	public String getHolidayDescription() {
		return holidayDescription;
	}

	public void setHolidayDescription(String holidayDescription) {
		this.holidayDescription = holidayDescription;
	}

}
