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
		static final String DOLOGIN				= "t0";
		
		//---.Menu Handling
		static final String BACKTOMAIN 			= "t1";
		static final String GOTOEDIT			= "t2";
		static final String DOEDIT 	 			= "t3";
		static final String GOTOADD 			= "t4";
		static final String DOADD 	 			= "t5";
		static final String DODELETE 			= "t6";
		static final String CHANGELANG 			= "t7";
		static final String NONE				= "t8";
		static final String GOTOMANAGER 		= "t9";
		static final String GOTOVIEW 			= "t10";
		static final String DOSEARCH			= "t11";
		static final String GOTORESIGN			= "t23";
		static final String DORESIGN			= "t26";
		static final String GOTODAYOFF			= "t24";
		static final String DODAYOFF			= "t27";
		static final String GOTOWEEKEND			= "t25";
		static final String DOWEEKEND			= "t28";
		static final String GOTOEDITWEEKEND		= "t29";
		static final String DOEDITWEEKEND		= "t30";
		static final String GOTOEDITDAYOFF		= "t31";
		static final String DOEDITDAYOFF		= "t32";
		static final String DORESET 			= "t33";
		static final String DOLOCK 				= "t34";
		static final String DOCHECK				= "t35";
		
		static final String GOTOEDITPOSITION 	= "t36";
		static final String DOEDITPOSITION 		= "t37";
		static final String DOVALIDATE1			= "t38";
		static final String DOVALIDATE2			= "t39";
		static final String DOLOGOUT			= "t40";
		
		static final String DOCOUNTDAYOFF       = "t41";
		static final String DOCHANGEPIC       	= "t42";
		static final String DOVALIDATEDAYOFF    = "t43";
		static final String DOVALIDATEWEEKEND   = "t44";
		
		interface PROJECT {
			final String GOTOPROJECTDETAIL	= "p01";
			final String GOTOTASKMEMBER		= "p02";
			final String GOTOCREATETASK		= "p03";
			final String GOTOCREATEMEMBER	= "p04";
			final String GOTOEDITMEMBER		= "p05";
			final String DOCREATETASK		= "p06";
			final String DOCREATEMEMBER		= "p07";
			final String DOEDITMEMBER		= "p08";
		}
		
		interface TASK {
			final String GOTOTASKTYPE	= "t101";
			final String GOTOSUBMIT		= "t102";
			final String GOTODETAIL		= "t103";
			final String DOSUBMIT		= "t104";
			final String DOAPPROVAL		= "t105";
			final String DOREJECT		= "t106";
			final String DOABORT		= "t107";
			final String DOAGREE		= "t108";
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
		
		interface REPORT {
			final String GOTODETAILEMPLOYEE			= "r1";
			final String GOTODETAILPROJECT			= "r2";
			final String GENERATEREPORTEMPLOYEE		= "r3";
			final String GENERATEREPORTEMPLOYEETASK	= "r4";
			final String GENERATEREPORTPROJECT		= "r5";
			final String GENERATEREPORTPROJECTTASK	= "r6";
			final String GENERATEREPORTPROJECTMEMBER	= "r7";
		}
	}

	//##B.Search Handling
	static interface Search {
		final Map<String, String> EMPLOYEE_SEARCHCOLUMNS = Collections.unmodifiableMap(
	        new LinkedHashMap<String, String>() {{
	        	put("ID", "EMPLOYEE ID");	        	
	        	put("NAME", "EMPLOYEE NAME");
	        	put("GENDER", "GENDER");
	        	put("EMAIL", "EMAIL");
	        	put("DIVISION", "DIVISION");
	        	put("POSITION", "POSITION");
	        	put("MANAGER", "MANAGER");
	        	put("STATUS", "STATUS");
	        }
	    });
		
		final Map<String, String> DIVISION_SEARCHCOLUMNS = Collections.unmodifiableMap(
	        new LinkedHashMap<String, String>() {{
	        	put("NAME", "DIVISION NAME");
	        }
	    });
		
		final Map<String, String> USER_SEARCHCOLUMNS = Collections.unmodifiableMap(
		        new LinkedHashMap<String, String>() {{
		        	put("USERNAME", "USERNAME");
		        	put("ID", "EMPLOYEE ID");
		        	put("EMPNAME", "EMPLOYEE NAME");
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
				put("DESCRIPTION", "Holiday Description");
				put("DATE", "Holiday Date");
			}
		});
		
		final Map<String, String> TASK_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "Task Name");
				put("DESCRIPTION", "Task Description");
				put("ASSIGNER", "Task Assigner");
				put("RECEIVER", "Task Receiver");
				put("STARTDATE", "Start Date");
				put("ESTIMATEDATE", "Estimate Date");
			}
		});
		
		final Map<String, String> TASK_HEADSEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "Task Name");
				put("DESCRIPTION", "Task Description");
				put("RECEIVER", "Task Receiver");
				put("STARTDATE", "Start Date");
				put("ESTIMATEDATE", "Estimate Date");
			}
		});

		final Map<String, String> TASK_SUBORDINATESEARCHCOLUMNS = Collections.unmodifiableMap(
				new LinkedHashMap<String, String>() {{
					put("NAME", "Task Name");
					put("DESCRIPTION", "Task Description");
					put("ASSIGNER", "Task Assigner");
					put("STARTDATE", "Start Date");
					put("ESTIMATEDATE", "Estimate Date");
				}
				});
		
		final Map<String, String> ACTIVITY_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "Activity Name");
				put("DESCRIPTION", "Activity Description");
			}
		});
		
		final Map<String, String>PROJECT_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("NAME", "Project Name");
				put("DESCRIPTION", "Project Description");
				put("PM", "Project Manager");
				put("PROPOSED", "Proposed By");
				put("STARTDATE", "Project Start Date");
				put("ESTIMATEDATE", "Project Estimate Date");
			}
		});
		
		final Map<String, String> LOG_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("ID", "Audit Trail Id");
				put("USERNAME", "Username");
				put("TABLE", "Audit Trail Table");
				put("DATE", "Activity Time");
			}
		});
		
		final Map<String, String> NOTIFICATION_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<String, String>() {{
				put("ID", "Notification Id");
				put("SENDER", "Sender");
				put("RECEIVER", "Receiver");
			}
		});
		
		final Map<String, String> USERMENU_SEARCHCOLUMNS = Collections.unmodifiableMap(
				new LinkedHashMap<String, String>() {{
					put("ID", "User Menu ID");
					put("NAME", "User Menu Name");
				}
			});
		
		final Map<String, String> USERROLE_SEARCHCOLUMNS = Collections.unmodifiableMap(
				new LinkedHashMap<String, String>() {{
					put("ID", "User Role ID");
					put("NAME", "User Role Name");
				}
			});
		
		
		final Map<Integer, String> TABLELOG_SEARCHCOLUMNS = Collections.unmodifiableMap(
			new LinkedHashMap<Integer, String>() {{
				put(LogTable.EMPLOYEES, "Employees");
				put(LogTable.USERS, "Users");
				put(LogTable.DIVISIONS, "Divisions");
				put(LogTable.POSITIONS, "Positions");
				put(LogTable.ROLES, "Roles");
				put(LogTable.RESIGN_EMPLOYEES, "Resign Employees");
				put(LogTable.DAY_OFFS, "Day Off");
				put(LogTable.NATIONAL_HOLIDAYS, "National Holidays");
				put(LogTable.WEEKEND_HOLIDAYS, "Weekend");
				put(LogTable.TASKS, "Tasks");
				put(LogTable.PROJECTS, "Projects");
				put(LogTable.NOTIFICATIONS, "Notifications");
			}
		});
		
		final Map<String, String> REPORTEMPLOYEE_SEARCHCOLUMNS = Collections.unmodifiableMap(
		        new LinkedHashMap<String, String>() {{
		        	put("NAME", "EMPLOYEE NAME");
		        	put("GENDER", "GENDER");
		        	put("EMAIL", "EMAIL");
		        	put("DIVISION", "DIVISION");
		        	put("POSITION", "POSITION");
		        	put("MANAGER", "MANAGER");
		        	put("ID", "EMPLOYEE ID");	       
		        }
		    });
		
		final Map<String, String>REPORTPROJECT_SEARCHCOLUMNS = Collections.unmodifiableMap(
				new LinkedHashMap<String, String>() {{
					put("NAME", "Project Name");
					put("DESCRIPTION", "Project Description");
					put("PM", "Project Manager");
					put("PROPOSED", "Proposed By");
					put("STARTDATE", "Project Start Date");
					put("ESTIMATEDATE", "Project Estimate Date");
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
		final int AGGREE   = 8;
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
	}
	
	//---4.Standard Audit Trails / Log Table Conversion			
	static interface LogTable{
		final int EMPLOYEES 			= 1;
		final int USERS 				= 2;
		final int DIVISIONS 			= 3;
		final int POSITIONS 			= 4;
		final int ROLES 				= 5;
		final int RESIGN_EMPLOYEES		= 6;
		final int DAY_OFFS 				= 7;
		final int NATIONAL_HOLIDAYS 	= 8;
		final int WEEKEND_HOLIDAYS 		= 9;
		final int ACTIVITIES 			= 10;
		final int TASKS 				= 11;
		final int PROJECTS 				= 12;
		final int NOTIFICATIONS 		= 13;
		final int GENERAL_SETTINGS		= 14;
		
	}
	static interface LogAction{
	//---5.Standard Audit Trails / Log Audit Trail Action Conversion		
		final String INSERT		= "I";
		final String BEFORE 	= "UB";
		final String AFTER 		= "UA";
		final String DELETE 	= "D";
	}
	
	static interface NotificationStatus{
	//---6.Standard Notifications Status Conversion
		final int RECEIVED = 1;
		final int READ = 2;
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
		String FAILLOGIN_SESSIONEXPIRED		= "Your Session has expired, please login again";
		String FAILLOGIN_SESSIONKICKED		= "Looks like there's someone already logged in with this account";
		
		String FAILLOAD_CONTENT				= "Fail to load content, something must be wrong at here...";
		String TABLE_EMPTY					= "No Data to be Shown";
		String TABLE_HEAD_EMPTY				= "Employee Head Not Found. Please Select Another Position  !";
		String FAIL_DO						= "Fail to do latest action. Please contact developer for Further Information";
	}
	
	//##F.Request and Session Attribute
	static interface Request {
		static String LOGIN_STATUS = "f1";
	}
	static interface Session{
		static String redirectPage		= "t3";
		static String redirectParam		= "t4";
		static String needRedirect	 	= "t5";
		static String lastPage			= "t6";

		static String Userdata			= "t7";
		static String Employeedata		= "t8";
		static String menuLists			= "t9";
		
		static String isSessionExpired	= "t10";
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
															"Menu.do",				 //0
															
															"DashboardAdmin.do",	 //1
															"UserAdmin.do",			 //2
															"EmployeeAdmin.do",		 //3
															"DivisionAdmin.do",		 //4
															"PositionAdmin.do",		 //5
															"RoleAdmin.do",			 //6
															"HolidayAdmin.do",		 //7
															"UserMenu.do",			 //8
															"UserRole.do",			 //9
															"NotifTemplate.do",		 //10
															"LogAdmin.do",			 //11
															"SettingAdmin.do",		 //12

															"DashboardUser.do",		 //13
															"TaskHeadUser.do",		 //14
															"TaskSubordinateUser.do",//15
															"ProjectUserAsHead.do",	 //16
															"ProjectUser.do",		 //17
															"ReportEmployees.do",	 //18
															"ReportProject.do",		 //19
															"Notification.do", 	 	 //20

															"Login.do",				 //21
															"Modal.do"				 //22
												};
	
	static interface Page {
		static int MENU					= 0;
		
		static int ADMIN_DASHBOARD		= 1;
		static int ADMIN_USER			= 2;
		static int ADMIN_EMPLOYEE		= 3;
		static int ADMIN_DIVISION		= 4;
		static int ADMIN_POSITION 		= 5;
		static int ADMIN_ROLE			= 6;
		static int ADMIN_HOLIDAY		= 7;
		static int ADMIN_USERMENU 		= 8;
		static int ADMIN_USERROLE 		= 9;
		static int ADMIN_NOTIFTEMPLATE	= 10;
		static int ADMIN_LOG			= 11;
		static int ADMIN_SETTING		= 12;
		
		static int USER_DASHBOARD		= 13;
		static int USER_TASK_HEAD		= 14;
		static int USER_TASK_SUBORDINATE= 15;
		static int USER_PROJECT_HEAD	= 16;
		static int USER_PROJECT			= 17;
	
		static int USER_REPORT_EMPLOYEES= 18;
		static int USER_REPORT_PROJECT	= 19;
		static int USER_VIEWNOTIF		= 20;
		
		static int LOGIN				= 21;
		static int MODAL				= 22;
		
	}
	
	//##K.Daily Time Constants
	public static String[] DAILY_TIME =  new String[]{  "00:00", "00:30",
														"01:00", "01:30",
														"02:00", "02:30",
														"03:00", "03:30",
														"04:00", "04:30",
														"05:00", "05:30",
														"06:00", "06:30",
														"07:00", "07:30",
														"08:00", "08:30",
														"09:00", "09:30",
														"10:00", "10:30",
														"11:00", "11:30",
														"12:00", "12:30",
														"13:00", "13:30",
														"14:00", "14:30",
														"15:00", "15:30",
														"16:00", "16:30",
														"17:00", "17:30",
														"18:00", "18:30",
														"19:00", "19:30",
														"20:00", "20:30",
														"21:00", "21:30",
														"22:00", "22:30",
														"23:00", "23:30"};
	
	//##L.Notification Type [Follow DB Identified Code]
	static interface NotificationType{
		static int TASK_SUBMITAPPROVAL 	   			= 1;
		static int TASK_SUBMITAPPROVALRETURN		= 2;
		static int TASK_SELFASSIGNAPPROVAL 			= 3;
		static int TASK_SELFASSIGNAPPROVALRETURN	= 4;
		static int TASK_ABORTBYHEAD		   			= 5;
		static int PROJECT_CREATEAPPROVAL  			= 6;
		static int PROJECT_CREATEAPPROVALRETURN  	= 7;
		static int PROJECT_SUBMITAPPROVAL  			= 8;
		static int PROJECT_SUBMITAPPROVALRETURN  	= 9;
		static int PROJECT_ABORT		   			= 10;
		static int PROJECT_NEWPMDELEGATED  			= 11;
		static int PROJECT_ASSIGNEDASROLE  			= 12;
		static int PROJECT_REMOVEDFROMROLE 			= 13;
		static int TASK_CREATED 					= 14;
		static int PROJECT_ASSIGNED_TO_PM 			= 15;
		static int TASK_CREATED_BY_SELF				= 16;
	}
	
	//##M.Misc
	public static String PATH_USERNOIMAGE = "resources/image/user-photo.jpg";
	
	//##N.Mail Template
	static interface MailTemplate {
		static String FROM 	= "from";
		static String TO	= "to";
		static String LINK	= "link";
	}
	
	//##O.Login Response
	static interface LoginResponse {
		static int FAIL_USERNOTEXISTS = 0;
		static int FAIL_IDENTIFICATION = 1;
		static int FAIL_LOCKED = 2;
		static int SUCCESS = 3;
	}
}
