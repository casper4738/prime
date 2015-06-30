package prime.filter;

import java.io.IOException;
import java.io.PrintWriter;

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
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest tmpServletRequest = (HttpServletRequest) request;
	    HttpServletResponse tmpServletResponse = (HttpServletResponse) response;
	    HttpSession tmpSession = tmpServletRequest.getSession();
	    RequestDispatcher tmpRO;
	    
	    /*
	    if(tmpSession.getAttribute(Constants.Session.USERDATA) == null) {
	    	
	    	if("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
			     PrintWriter out = response.getWriter();
			     out.println("<script type=\"text/javascript\">");
			     out.println("window.location.href = '" + Constants.PAGES_LIST[Constants.Page.LOGIN] + "';");
			     out.println("</script>");
		    } else {
				tmpRO = request.getRequestDispatcher(Constants.PAGES_LIST[Constants.Page.LOGIN]);
				tmpRO.forward(tmpServletRequest, tmpServletResponse);
		    }
	    } else {
	    	chain.doFilter(request, response);
	    }
	    */
    	chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
