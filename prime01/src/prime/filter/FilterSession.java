package prime.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prime.admin.employee.EmployeeBean;
import prime.admin.employee.EmployeeManager;
import prime.admin.employee.EmployeeManagerImpl;
import prime.admin.user.UserBean;
import prime.admin.user.UserManager;
import prime.admin.user.UserManagerImpl;
import prime.constants.Constants;
import prime.login.LoginData;
import prime.login.LoginManager;
import prime.login.LoginManagerImpl;

/**
 * Servlet Filter implementation class FilterSession
 */
public class FilterSession implements Filter {

	/**
	 * Default constructor.
	 */
	public FilterSession() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
			ServletException {
		HttpServletRequest tmpServletRequest = (HttpServletRequest) request;
	    HttpServletResponse tmpServletResponse = (HttpServletResponse) response;
	    HttpSession tmpSession = tmpServletRequest.getSession();
	    boolean tmpIsRedirectNeed = true;
	    
		if(!tmpServletRequest.getServletPath().equals("/" + Constants.PAGES_LIST[Constants.Page.LOGIN])){
			//##a.Check Session State
		    if(tmpSession.getAttribute(Constants.Session.Userdata) != null && 
		       tmpSession.getAttribute(Constants.Session.Employeedata) != null &&
		       tmpSession.getAttribute(Constants.Session.menuLists) != null) {
		    	//##b.Check From DB, Session Value
		    	LoginManager tmpLoginManager = new LoginManagerImpl();
		    	String tmpUsername = ((UserBean)tmpSession.getAttribute(Constants.Session.Userdata)).getUserName();
		    	String tmpDBSession = "";
				try {
					tmpDBSession = tmpLoginManager.getLoginSession(tmpUsername);
				} catch (SQLException e) {
					//Nothing need to be done at here
					e.printStackTrace();
				}
				
				String tmpCurrentSession = ((UserBean)tmpSession.getAttribute(Constants.Session.Userdata)).getloginSession();
		    	if(tmpDBSession.equals(tmpCurrentSession)){
		    		tmpIsRedirectNeed = false;
		    	} else {
		    		tmpSession.setAttribute(Constants.Session.isSessionExpired, true);
		    	}
		    } 

		    //##.For Page-Changing Handler
		    if(!tmpIsRedirectNeed){
		    	chain.doFilter(request, response);
		    } else {
		    	if("XMLHttpRequest".equals(tmpServletRequest.getHeader("X-Requested-With"))) {
				     PrintWriter out = response.getWriter();
				     out.println("<script type=\"text/javascript\">");
				     out.println("window.location.href = '" + Constants.PAGES_LIST[Constants.Page.LOGIN] + "';");
				     out.println("</script>");
			    } else {  
			    	tmpServletResponse.sendRedirect(Constants.PAGES_LIST[Constants.Page.LOGIN]);
			    }
		    }		
		} else {
	    	chain.doFilter(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}
}
