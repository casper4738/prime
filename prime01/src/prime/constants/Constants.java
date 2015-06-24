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
		static final String GOTORESIGN	= "t23";
		static final String DORESIGN	= "t26";
		static final String GOTODAYOFF	= "t24";
		static final String DODAYOFF	= "t27";
		static final String GOTOWEEKEND	= "t25";
		static final String DOWEEKEND	= "t28";
		static final String DORESET 	= "t33";
		static final String DOLOCK 		= "t34";
		static final String DOUNLOCK 	= "t35";
		static final String GOTOEDITWEEKEND	= "t29";
		static final String DOEDITWEEKEND	= "t30";
		static final String GOTOEDITDAYOFF	= "t31";
		static final String DOEDITDAYOFF	= "t32";
		
		interface TASK {
			final String GOTOTASKTYPE	= "t101";
			final String GOTOSUBMIT		= "t102";
			final String DOSUBMIT		= "t103";
			final String DOAPPROVAL		= "t104";
			final String DOREJECT		= "t105";
			final String DOABORT		= "t106";
		}
		
		interface ACTIVITY {
			final String GOTOTDETAIL		= "t15";
			final String DOADD 	 			= "t16";
			final String DOEDIT 	 		= "t17";
			final String DOCHANGESTATUS		= "t18";
			final String DODELETE 			= "t19";
			final String GOTOADD 			= "t20";
			final String GOTOEDIT 			= "t21";
			final String GOTOCHANGESTATUS 	= "t22";
		}
	}

	//##B.Search Handling
	static interface Search {
		final Map<String, String> EMPLOYEE_SEARCHCOLUMNS = Collections.unmodifiableMap(
	        new LinkedHashMap<String, String>() {{
	        	put("NAME", "EMPLOYEE NAME");
	        	put("ID", "EMPLOYEE ID");
	        }
	    });
		
		final Map<String, String> DIVISION_SEARCHCOLUMNS = Collections.unmodifiableMap(
	        new LinkedHashMap<String, String>() {{
	        	put("NAME", "DIVISION NAME");
	        }
	    });
		
		final Map<String, String> USER_SEARCHCOLUMNS = Collections.unmodifiableMap(
		        new LinkedHashMap<String, String>() {{
		        	put("NAME", "USERNAME");
		        	put("ID", "EMPLOYEE ID");
		        }
		    });
		
		final Map<String, String> POSITION_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "POSITION NAME");
				put("LEVEL", "POSITION LEVEL");
			}
		});
		
		final Map<String, String> ROLE_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "ROLE NAME");
			}
		});
		
		final Map<String, String> HOLIDAY_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("DESCRIPTION", "DECRIPTION HOLIDAY");
			}
		});
		
		final Map<String, String> TASK_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "Task Name");
				put("DESCRIPTION", "Task Description");
				put("ASSIGNER", "Task Assigner");
				put("RECEIVER", "Task Receiver");
				put("START", "Start Date");
				put("ESTIMATE", "Estimate Date");
			}
		});
		
		final Map<String, String> ACTIVITY_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "Activity Name");
				put("DESCRIPTION", "Task Description");
			}
		});
		
		static final Map<String, String>PROJECT_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "Project Name");
				put("DESCRIPTION", "Project Description");
			}
		});
		
		final Map<String, String> LOG_SEARCHCOLUMNS = Collections.unmodifiableMap(
				new LinkedHashMap<String, String>() {{
					put("ID", "Audit Trail Id");
					put("USERNAME", "Username");
					put("TABLE", "Audit Trail Table");
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
		final int CREATE   = 0;
		final int PROGRESS = 1;
		final int PAUSE    = 2;
		final int SUBMIT   = 3;
		final int FINISH   = 4;
		final int ABORT    = 5;
		final int REJECT   = 6;
		final int APPROVAL = 7;
	}
	
	//---2.Standard Day Conversion
	static interface Day {
		int MONDAY    = 0;
		int TUESDAY   = 1;
		int WEDNESDAY = 2;
		int THURSDAY  = 3;
		int FRIDAY 	 = 4;
		int SATURDAY  = 5;
		int SUNDAY	 = 6;
	}
	
	//---3.Standard Status User
	static interface UserStatus {
		int LOCKED = 0;
		int OK     = 1;
		int WITHLOCK = 2;
		int WITHABORT = 3;
	}
	
	//##E.Response
	static interface Confirmation {
		String DELETE 		= "Are you sure you want to delete this ?";
		String LOCK			= "Are you sure you want to lock this ?";
		String UNLOCK		= "Are you sure you want to unlock this ?";
	}
	
	static interface Response {
		String FAILLOGIN_USERNOTEXISTS 		= "Username doesn't exists !";
		String FAILLOGIN_VALIDATIONFAILED  	= "User validation failed !";
		String FAILLOGIN_USERLOCKED			= "User is locked, contact your administrator for further info !";
		String FAILLOGIN_SOMEFAILURE		= "Some failure is happening, please contact your administrator for further info !";
		String FAILLOGIN_EMPTYDATA			= "Please insert your username and password before proceed !";
		String FAILLOGIN_ERROR				= "Something wrong with the system, please contact your administrator for further info !";
		String FAILLOAD_CONTENT				= "Fail to load content, something must be wrong at here...";
		String TABLE_EMPTY					= "No Data to be Shown";
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
															"Login.do",				 //0
															"Menu.do",				 //1
															"DashboardAdmin.do",	 //2
															"UserAdmin.do",			 //3
															"EmployeeAdmin.do",		 //4
															"DivisionAdmin.do",		 //5
															"PositionAdmin.do",		 //6
															"RoleAdmin.do",			 //7
															"HolidayAdmin.do",		 //8
															"LogAdmin.do",			 //9
															"SettingAdmin.do",		 //10
															"DashboardUser.do",		 //11
															"ProjectUser.do",		 //12
															"TaskHeadUser.do",		 //13
															"TaskSubordinateUser.do",//14
															"ActivityUser.do",		 //15
															"TaskSubmissionUser.do", //16
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
		static int USER_TASK_HEAD		= 13;
		static int USER_TASK_SUBORDINATE= 14;
		static int USER_REPORT			= 15;
	}

	
}
