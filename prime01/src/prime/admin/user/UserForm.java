package prime.admin.user;

import org.apache.struts.action.ActionForm;

public class UserForm extends ActionForm {

	private int showInPage;
	private String search;

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public int getShowInPage() {
		return showInPage;
	}

	public void setShowInPage(int showInPage) {
		this.showInPage = showInPage;
	}

}
