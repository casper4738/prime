package prime.utility;

public class PrimeUtil {

	public static Integer getStartRow(int page, int view) {
		if(view == -1) return 1;
		return (page - 1) * view + 1;
	}

	public static Integer getEndRow(int page, int view, int  countRows) {
		if(view == -1) return countRows;
		return ((page - 1) * view) + view;
	}
}
