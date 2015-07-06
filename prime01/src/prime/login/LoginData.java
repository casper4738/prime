package prime.login;
import java.util.ArrayList;

import prime.admin.employee.EmployeeBean;
import prime.admin.user.UserBean;

/**
 * For Login Data Handling
 */
public class LoginData {
	/**
	 * Variable
	 */
	private static UserBean dataUser = null;
	private static EmployeeBean dataEmployee = null;
	private static ArrayList<Integer> dataMenuLists = null;
	
	/**
	 * Setter Method
	 **/
	public static void setUserBean(UserBean bean){
		dataUser = bean;
	}
	public static void setEmployeeBean(EmployeeBean bean){
		dataEmployee = bean;
	}
	public static void setMenuLists(ArrayList<Integer> bean){
		dataMenuLists = bean;
	}
	
	/**
	 * Getter Method
	 * [For Easier Access, Rather than direct access using dataLogin and dataEmployee]
	 */
	public static boolean isDataExists(){
		return (dataUser != null && dataEmployee != null);
	}
	public static UserBean getUserData(){
		return dataUser;
	}
	public static EmployeeBean getEmployeeData(){
		return dataEmployee;
	}
	public static ArrayList<Integer> getMenuLists(){
		return dataMenuLists;
	}
	
	public static void clear(){
		dataUser = null;
		dataEmployee = null;
		dataMenuLists = null;
	}
	
}
