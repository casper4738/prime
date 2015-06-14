package prime.utility;

import java.util.ArrayList;
import java.util.List;

public class PaginationUtility {

	private int countRows;
	private int view;
	private int page;
	private int pageNext;
	private int pagePrev;
	private int sumOfPage;

	public List<Integer> getListPaging(int page) {
		view = view <= 0 ? 1 : view;
		sumOfPage = (int) Math.ceil(countRows / Double.parseDouble(view + ""));

		pageNext = 0;
		pagePrev = 0;
		int begin = 0;
		int end = 0;

		if (page <= 1)
			pagePrev = page;
		else
			pagePrev = page - 1;

		if (page >= sumOfPage) {
			page = sumOfPage;
			pageNext = page;
		}
		else
			pageNext = page + 1;

		if (page <= 2)
			begin = 1;
		else
			begin = page - 2;

		if (sumOfPage <= 5) {
			begin = 1;
			end = sumOfPage;
		} else if (page <= 2) {
			begin = 1;
			end = 5;
		} else if (page + 2 >= sumOfPage) {
			end = sumOfPage;
			begin = end - 4;
		} else {
			end = page + 2;
		}

		this.page = page;
		
		List<Integer> listPage = new ArrayList<Integer>();
		for (int i = begin; i <= end; i++) {
			listPage.add(i);
		}
		return listPage;
	}

	public void setCountRows(int countRows) {
		this.countRows = countRows;
	}

	public void setView(int view) {
		this.view = view;
	}

	public int getPageNext() {
		return pageNext;
	}

	public int getPagePrev() {
		return pagePrev;
	}

	public int getSumOfPage() {
		return sumOfPage;
	}

	public int getPage() {
		return page;
	}
	
}

