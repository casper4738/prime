package prime.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	    HttpSession tmpSession = tmpServletRequest.getSession(true);
	    boolean tmpIsRedirectNeed = true;
	    
	    System.out.println("Step A");
	    
		if(!tmpServletRequest.getServletPath().equals("/" + Constants.PAGES_LIST[Constants.Page.LOGIN])){
			 System.out.println("Step B");
			
			//##a.Check Session State
		    if(tmpSession.getAttribute(Constants.Session.ID) != null) {
		    	System.out.println("Step C");
		    	
		    	//##b.Check From DB, Session Value
		    	LoginManager tmpLoginManager = new LoginManagerImpl();
		    	
		    	if(LoginData.isDataExists()){
		    		System.out.println("Step D");
		    		
			    	String tmpDBSession = "";
					try {
						tmpDBSession = tmpLoginManager.getLoginSession(LoginData.getUserData().getUserName());
					} catch (SQLException e) {
						//Nothing need to be done at here
						e.printStackTrace();
					}
			    	String tmpCurnSession = LoginData.getUserData().getloginSession() ;
			    	if(tmpDBSession.equals(tmpCurnSession)){
			    		 System.out.println("Step E");
			    		tmpIsRedirectNeed = false;
			    	} else {
			    		System.out.println("Step F");
			    		LoginData.clear();
			    		tmpSession.invalidate();
			    		request.setAttribute(Constants.Request.LOGIN_STATUS, Constants.Response.FAILLOGIN_SESSIONKICKED);
			    	}
		    	} else {
		    		System.out.println("Step G");
		    		 
		    		LoginData.clear();
		    		tmpSession.invalidate();
		    		request.setAttribute(Constants.Request.LOGIN_STATUS, Constants.Response.FAILLOGIN_SESSIONKICKED);
		    	}
		    } else {
		    	if(LoginData.isDataExists()){
		    		System.out.println("Step H");
		    		LoginData.clear();
		    		request.setAttribute(Constants.Request.LOGIN_STATUS, Constants.Response.FAILLOGIN_SESSIONEXPIRED);
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
    		LoginData.clear();
    		tmpSession.invalidate();
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
