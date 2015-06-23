package prime.constants;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

public interface Constants {
	//##0.Zero Constants
	public static final int MAX_PAGE_PERSHOW 	= 5;
	public static final int MAX_IMAGE_FILESIZE  = 1000;
	
	//##A.Task Handling
	static interface Task {
		//---.Login Handling
		static final String DOLOGIN		= "t0";
		
		//---.Menu Handling
		static final String BACKTOMAIN 	= "t1";
		static final String GOTOEDIT	= "t2";
		static final String DOEDIT 	 	= "t3";
		static final String GOTOADD 	= "t4";
		static final String DOADD 	 	= "t5";
		static final String DODELETE 	= "t6";
		static final String CHANGELANG 	= "t7";
		static final String NONE		= "t8";
		static final String GOTOMANAGER = "t9";
		static final String GOTOVIEW 	= "t10";
		static final String DOSEARCH	= "t11";
		
		interface TASK {
			final String GOTOTASKTYPE	= "t11";
			final String GOTOSUBMIT		= "t12";
			final String DOSUBMIT		= "t13";
		}
		
		interface ACTIVITY {
			final String GOTOTDETAIL		= "t14";
			final String DOADD 	 			= "t15";
			final String DOEDIT 	 		= "t16";
			final String DOCHANGESTATUS		= "t17";
			final String DODELETE 			= "t18";
			final String GOTOADD 			= "t19";
			final String GOTOEDIT 			= "t20";
			final String GOTOCHANGESTATUS 	= "t21";
		}
	}

	//##B.Search Handling
	static interface Search {
		static final Map<String, String> EMPLOYEE_SEARCHCOLUMNS = Collections.unmodifiableMap(
	        new LinkedHashMap<String, String>() {{
	        	put("NAME", "EMPLOYEE NAME");
	        	put("ID", "EMPLOYEE ID");
	        }
	    });
		
		static final Map<String, String> DIVISION_SEARCHCOLUMNS = Collections.unmodifiableMap(
	        new LinkedHashMap<String, String>() {{
	        	put("SHOW_ALL", "SHOW ALL");
	        	put("NAME", "DIVISION NAME");
	        }
	    });
		static final Map<String, String> POSITION_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("SHOW_ALL", "SHOW ALL");
				put("NAME", "DIVISION NAME");
			}
		});
		static final Map<String, String> ROLE_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("SHOW_ALL", "SHOW ALL");
				put("NAME", "ROLE NAME");
			}
		});
		static final Map<String, String> HOLIDAY_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("SHOW_ALL", "SHOW ALL");
				put("DESCRIPTION", "DECRIPTION HOLIDAY");
			}
		});
		
		static final Map<String, String>PROJECT_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "Project Name");
				put("DESCRIPTION", "Project Description");
			}
		});
	}

	//##C.Page Handling
	static final Map<Integer, Integer> PAGINGROWPAGE = Collections.unmodifiableMap(
		new LinkedHashMap<Integer, Integer>() {{
        	put(5,   5);
        	put(10,  10);
        	put(25,  25);
        	put(50,  50);
        	put(100, 100);
        }
	});
	
	//##D.Standard Value
	//---1.Standard Status Value
	static interface Status {
		final int RECEIVE  = 0;
		final int PROGRESS = 1;
		final int PAUSE    = 2;
		final int SUBMIT   = 3;
		final int FINISH   = 4;
		final int ABORT    = 5;
		final int CREATE   = 6;
		
		final Map<Integer, String> LIST_STATUSACTIVITY = Collections.unmodifiableMap(
			new LinkedHashMap<Integer, String>() {{
				put(PROGRESS, "START");
				put(PAUSE, "PAUSE");
				put(FINISH, "FINISH");
			}
		});
	}
	
	//---2.Standard Day Conversion
	static interface Day {
		static int MONDAY    = 0;
		static int TUESDAY   = 1;
		static int WEDNESDAY = 2;
		static int THURSDAY  = 3;
		static int FRIDAY 	 = 4;
		static int SATURDAY  = 5;
		static int SUNDAY	 = 6;
	}
	
	//---3.Standard Status User
	static interface UserStatus {
		static int LOCKED = 0;
		static int OK     = 1;
	}
	
	//##E.Response
	static interface Confirmation {
		static String DELETE 		= "Are you sure you want to delete this ?";
	}
	
	static interface Response {
		static String FAILLOGIN_USERNOTEXISTS 		= "Username doesn't exists !";
		static String FAILLOGIN_VALIDATIONFAILED  	= "User validation failed !";
		static String FAILLOGIN_USERLOCKED			= "User is locked, contact your administrator for further info !";
		static String FAILLOGIN_SOMEFAILURE			= "Some failure is happening, please contact your administrator for further info !";
		static String FAILLOGIN_EMPTYDATA			= "Please insert your username and password before proceed !";
		static String FAILLOGIN_ERROR				= "Something wrong with the system, please contact your administrator for further info !";
		static String FAILLOAD_CONTENT				= "Fail to load content, something must be wrong at here...";
		static String TABLE_EMPTY					= "No Data to be Shown";
	}
	
	//##F.Session Attribute
	static interface Session{
		static String USERNAME 			 = "s1";
		static String IS_ACTIVEDIRECTORY = "s2";
		static String NAME 				 = "s2";
		static String PROFILE_PICTURE 	 = "s3";
		static String EMPLOYEE_ID		 = "s4";
		static String SESSION_ID		 = "s5";
	}
	
	//##G.Active Directory
	static interface ActiveDirectory {
		static String ADMIN_USERNAME	 = "dedy.suwandi";
		static String ADMIN_PASSWORD	 = "Ace2015";
	}
	
	//##H.System Level
	static interface SystemLevel {
		static int ADMIN			= 0;
		static int OPERATOR 		= 1;
		static int OPERATOR_MONITOR = 2;
	}
	
	//##J.Menu Handling
	public static final  String[] PAGES_LIST = new String[]{
															"Login.do",				//0
															"Menu.do",				//1
															"DashboardAdmin.do",	//2
															"UserAdmin.do",			//3
															"EmployeeAdmin.do",		//4
															"DivisionAdmin.do",		//5
															"PositionAdmin.do",		//6
															"RoleAdmin.do",			//7
															"HolidayAdmin.do",		//8
															"#",					//9
															"SettingAdmin.do",		//10
															"DashboardUser.do",		//11
															"ProjectUser.do",		//12
															"TaskUser.do",			//13
															"ActivityUser.do",		//14
															"TaskSubmissionUser.do",//15
															"#"
												};
	static interface Page {
		static int LOGIN				= 0;
		static int MENU					= 1;
		static int ADMIN_DASHBOARD		= 2;
		static int ADMIN_USER			= 3;
		static int ADMIN_EMPLOYEE		= 4;
		static int ADMIN_DIVISION		= 5;
		static int ADMIN_POSITION 		= 6;
		static int ADMIN_ROLE			= 7;
		static int ADMIN_HOLIDAY		= 8;
		static int ADMIN_LOG			= 9;
		static int ADMIN_SETTING		= 10;
		static int USER_DASHBOARD		= 11;
		static int USER_PROJECT			= 12;
		static int USER_TASK			= 13;
		static int USER_ACTIVITY		= 14;
		static int USER_TASKSUBMISSION	= 15;
		static int USER_REPORT			= 16;
	}

}
